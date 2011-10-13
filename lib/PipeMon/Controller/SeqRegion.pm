package PipeMon::Controller::SeqRegion;
use Moose;
use namespace::autoclean;

use Hum::Sort 'ace_sort';

BEGIN {extends 'Catalyst::Controller'; }

has 'seq_region_keys' => (
    is  => 'ro',
    isa => 'ArrayRef[Str]',
    );

__PACKAGE__->config(
    seq_region_keys => [ qw(
        seq_region_id
        name
        cs_name
        cs_version
        length
        write_access
        hidden
        n_all_components
        n_all_assemblies
        n_components
        n_assemblies
    )],
    );

=head1 NAME

PipeMon::Controller::SeqRegion - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

Just gets us chained to the right place with the right pathpart initially,
and sets up prefetch for searches.

=cut

sub base :Chained('/loutreorpipe/base') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $model = $c->stash->{db_model};

    my $resultset = $model->resultset('SeqRegion')->search(
        undef,
        { prefetch =>  [
              { 'sv_attributes' => 'attrib_type' },
              'coord_system',
              ],
        }
        );
    $c->stash( seq_region_rs => $resultset );
}

=head2 seq_sets

=cut

sub seq_sets :Chained('base') :PathPart('seq_sets') :Args(0) {
    my ( $self, $c ) = @_;

    my $resultset = $c->stash->{seq_region_rs};
    my @seq_sets  = sort seq_set_sort $resultset->search(
        {
            'coord_system.name' => 'chromosome',
        },
    )->all();

    $c->stash( seq_sets => \@seq_sets,
               template => 'seq_region/seq_sets.tt2',
        );
}

sub seq_set_sort {
    my $a_hidden = $a->hidden;
    my $b_hidden = $b->hidden;
    my $a_visible = (defined($a_hidden) and not $a_hidden and $a->coord_system->version eq 'Otter');
    my $b_visible = (defined($b_hidden) and not $b_hidden and $b->coord_system->version eq 'Otter');

    return (
        $b_visible <=> $a_visible
                   ||
        ace_sort($a->name, $b->name) 
        );
}

=head2 seq_region_id

=cut

sub seq_region_id :Chained('base') :PathPart('seq_region/id') :Args(1) {
    my ( $self, $c, $key ) = @_;

    my $resultset = $c->stash->{seq_region_rs};

    unless ($key =~ /^\d+$/) {
        # Bad format
        $c->response->status(400);
        $c->response->body("'$key' doesn't look like a seq_region_id");
        $c->detach;
    }

    my $seq_region = $resultset->find($key);

    unless ($seq_region) {
        $c->response->status(404);
        $c->response->body("No such seq_region '$key'");
        $c->detach;
    }

    $c->stash(seq_region => $seq_region);
    $c->detach( 'display' );
}

=head2 seq_region 

=cut

sub seq_region :Chained('base') :PathPart('seq_region/name') :Args() {
    my ( $self, $c, $sr_name, $cs_name, $cs_ver ) = @_;

    unless ($sr_name) {
        $c->response->status(400);
        $c->response->body("Must supply at least a seq_region name");
        $c->detach;
    }

    if ($sr_name =~ ':') {
        my @coords;
       ($cs_name, $cs_ver, $sr_name, @coords) = split(':', $sr_name);
    }

    my %search = ('me.name' => $sr_name);

    if ($cs_name) {
        $c->forward('/coordsystem/search', [ $cs_name, $cs_ver ]);
        $search{'me.coord_system_id'} = $c->stash->{coord_system}->coord_system_id;
    }

    my $resultset = $c->stash->{seq_region_rs};
    my ($seq_region, $not_unique) = $resultset->search(\%search);

    unless ($seq_region) {
        $c->response->status(404);
        $c->response->body("No such seq_region '$sr_name'");
        $c->detach;
    }

    if ($not_unique) {
        $c->response->status(400);
        $c->response->body("More than one seq_region with name '$sr_name'");
        $c->detach;
    }

    $c->stash(seq_region => $seq_region);
    $c->detach( 'display' );
}

=head2 display

=cut

sub display :Private {
    my ( $self, $c ) = @_;

    my $seq_region = $c->stash->{seq_region};

    my $attrs = $seq_region->attributes->search(
        undef,
        {
            order_by => 'me.attrib_type_id',
            prefetch => 'attrib_type',
        },
        );

    my $mappings_to     = $seq_region->mappings_to;
    my $mappings_from   = $seq_region->mappings_from;
    my $component_types = $seq_region->component_types;
    my $assembly_types  = $seq_region->assembly_types;

    $c->stash( sr_keys         => $self->seq_region_keys,
               attrs           => $attrs,
               mappings_to     => $mappings_to,
               mappings_from   => $mappings_from,
               component_types => $component_types,
               assembly_types  => $assembly_types,
               template        => 'seq_region/seq_region.tt2',
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
