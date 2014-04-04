package PipeMon::Controller::Feature;
use Moose;
use namespace::autoclean;

use feature 'switch';

BEGIN {extends 'Catalyst::Controller'; }

has 'feature_keys' => (
    is  => 'ro',
    isa => 'ArrayRef[Str]',
);

__PACKAGE__->config(
    feature_keys => [ qw(
        id
        seq_region_id
        seq_region_name
        seq_region_start
        seq_region_end
        seq_region_strand
        hit_name
        hit_start
        hit_end
        hit_strand
        analysis_id
        logic_name
        score
        evalue
        perc_ident
        cigar_line
        external_db_id
        hcoverage
        ) ],
    );


=head1 NAME

PipeMon::Controller::Feature - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 base

Just gets us chained to the right place with the right pathpart initially, and sorts out
DNA versus protein vs simple.

=cut

sub base :Chained('/loutreorpipe/base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $feature_type ) = @_;

    my ($feature_class, $has_hit);
    my $feature_id = "${feature_type}_align_feature_id";

    given ($feature_type) {
        when ('dna')     { $feature_class = 'DnaAlignFeature';     $has_hit = 1; }
        when ('protein') { $feature_class = 'ProteinAlignFeature'; $has_hit = 1; }
        when ('simple')  { $feature_class = 'SimpleFeature';       $feature_id = 'simple_feature_id'; }
    }

    unless ($feature_class) {
        $c->response->status(404);
        $c->response->body("No such feature type '$feature_type'");
        $c->detach;
    }

    my $model = $c->stash->{db_model};

    $c->stash(
        feature_rs   => $model->resultset($feature_class),
        feature_type => $feature_type,
        feature_id   => $feature_id,
        has_hit      => $has_hit,
        );
}

=head2 search

Private chained component to handle search arguments

=cut

sub search :Chained('base') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    my %search;
    my %search_params;
    my @join;
    foreach my $key (qw/analysis_id seq_region_id/) {
        if (my $value = $c->request->parameters->{$key}) {
            $search_params{$key} = $value;
            my $search_key = 'me.' . $key;
            $search{$search_key} = $value;
        }
    }

    if (my $hit_name = $c->request->parameters->{hit_name}) {
        $search_params{hit_name} = $hit_name;
        if ($c->request->parameters->{hit_name_like}) {
            $search_params{hit_name_like} = 1;
            $search{'me.hit_name'} = { LIKE => "${hit_name}%" };
        } else {
            $search{'me.hit_name'} = $hit_name;
        }
    }

    if (my $logic_name = $c->request->parameters->{logic_name}) {
        $search_params{logic_name}     = $logic_name;
        $search{'analysis.logic_name'} = $logic_name;
        push @join, 'analysis';
    }

    my %opts;
    if (@join) {
        $opts{join} = \@join;
    }

    my $search_rs = $c->stash->{feature_rs}->search( \%search, \%opts );

    $c->stash( search_params => \%search_params,
               search_rs     => $search_rs,
        );
}

=head2 features

=cut

sub features :Chained('search') :PathPart('features') :Args(0)
             :MyAction('Paged') :PagedResultSetKey('features')
{
    my ( $self, $c ) = @_;

    my @order = qw/seq_region_start seq_region_strand/;
    push @order, 'hit_name' if $c->stash->{has_hit};

    my %opts = (
        order_by => \@order,
        prefetch => [ qw/analysis seq_region/ ],
        );

    my $features = $c->stash->{search_rs}->search( undef, \%opts );

    $c->stash(
        features => $features,
        template => 'feature/features.tt2',
        );
}


=head2 feature_summary

=cut

sub feature_summary :Chained('search') :PathPart('feature_summary') :Args(1) {
    my ( $self, $c, $group_on ) = @_;

    my @groups = split(',', $group_on);

    my $feature_summary = $c->stash->{search_rs}->summary( @groups );

    $c->stash(
        feature_summary => $feature_summary,
        groups          => \@groups,
        template        => 'feature/feature_summary.tt2',
        );
}


=head2 feature

=cut

sub feature :Chained('base') :PathPart('feature') :Args(1) {
    my ( $self, $c, $key ) = @_;

    unless ($key =~ /^\d+$/) {
        # Bad format
        $c->response->status(400);
        $c->response->body("'$key' doesn't look like a feature_id");
        $c->detach;
    }

    my $feature = $c->stash->{feature_rs}->find($key, { prefetch => [qw/analysis seq_region/] });

    $c->stash(
        feature      => $feature,
        feature_keys => $self->feature_keys,
        template     => 'feature/feature.tt2',
        );
}

=head1 AUTHOR

Michael Gray

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
