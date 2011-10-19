package PipeMon::Controller::CoordSystem;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

has 'coord_system_keys' => (
    is  => 'rw',
    isa => 'ArrayRef[Str]',
);

__PACKAGE__->config(
    coord_system_keys => [ qw(
        coord_system_id
        species_id
        name
        version
        rank
        attrib
    )],
    );

=head1 NAME

PipeMon::Controller::CoordSystem - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 base

Just gets us chained to the right place with the right pathpart initially

=cut

sub base :Chained('/loutreorpipe/base') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

=head2 resultset

Get the right resultset

=cut

sub resultset :Private {
    my ( $self, $c ) = @_;
    my $model = $c->stash->{db_model};
    my $resultset = $model->resultset('CoordSystem');
    $c->stash( coord_system_rs => $resultset ); # NEEDED ?
    return $resultset;
}

=head2 coord_systems

=cut

sub coord_systems :Chained('base') :PathPart('coord_systems') :Args(0) {
    my ( $self, $c ) = @_;

    my $resultset = $c->forward('resultset');

    $c->stash( coord_systems => [$resultset->all],
               keys          => $self->coord_system_keys,
               template      => 'coord_system/coord_systems.tt2',
        );
}

=head2 coord_system_id

=cut

sub coord_system_id :Chained('base') :PathPart('coord_system/id') :Args(1) {
    my ( $self, $c, $id ) = @_;

    $c->forward( 'by_id' );
    $c->detach(  'display' );
}

=head2 by_id

=cut

sub by_id :Private {
    my ( $self, $c, $id ) = @_;

    unless ($id =~ /^\d+$/) {
        # Bad format
        $c->response->status(400);
        $c->response->body("'$id' doesn't look like a coord_system_id");
        $c->detach;
    }

    my $resultset = $c->forward('resultset');
    my $coord_system = $resultset->find($id);

    unless ($coord_system) {
        $c->response->status(404);
        $c->response->body("No such coord_system_id '$id'");
        $c->detach;
    }

    $c->stash( coord_system => $coord_system );
}

=head2 coord_system

=cut

sub coord_system :Chained('base') :PathPart('coord_system/name') :Args() {
    my ( $self, $c, $name, $version ) = @_;

    unless ($name) {
        $c->response->status(400);
        $c->response->body("Must supply at least a coord_system name");
        $c->detach;
    }

    $c->forward( 'search' );
    $c->detach( 'display' );
}

=head2 search

=cut

sub search :Private {
    my ( $self, $c, $name, $version ) = @_;

    # Not chained to base so cannot count on its setup
    my $model = $c->stash->{db_model};
    my $coord_system = $model->resultset('CoordSystem')->by_name($name, $version);

    unless ($coord_system) {
        $version ||= '<em>default</em>';
        $c->response->status(404);
        $c->response->body("No such coord_system '$name:$version'");
        $c->detach;
    }

    $c->stash( coord_system => $coord_system );
}

=head2 display

=cut

sub display :Private {
    my ( $self, $c ) = @_;

    $c->stash( keys         => $self->coord_system_keys,
               template     => 'coord_system/coord_system.tt2',
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
