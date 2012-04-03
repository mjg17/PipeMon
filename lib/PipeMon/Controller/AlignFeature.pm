package PipeMon::Controller::AlignFeature;
use Moose;
use namespace::autoclean;

use feature 'switch';

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

PipeMon::Controller::AlignFeature - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 base

Just gets us chained to the right place with the right pathpart initially, and sorts out
DNA versus protein.

=cut

sub base :Chained('/loutreorpipe/pipe_only') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $feature_type ) = @_;

    my $feature_class;

    given ($feature_type) {
        when ('dna')     { $feature_class = 'DnaAlignFeature'; }
        when ('protein') { $feature_class = 'ProteinAlignFeature'; }
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
        feature_id   => "${feature_type}_align_feature_id",
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

    my %opts = (
        order_by => 'hit_name',
        prefetch => [ qw/analysis seq_region/ ],
        );

    my $features = $c->stash->{search_rs}->search( undef, \%opts );

    $c->stash(
        features => $features,
        template => 'feature/features.tt2',
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
