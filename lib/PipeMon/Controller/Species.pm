package PipeMon::Controller::Species;
use Moose;
use namespace::autoclean;

use Bio::Otter::SpeciesDat::DataSet;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

PipeMon::Controller::Species - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

Extract species to start chained dispatch here

=cut

sub base :Chained('/') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $species) = @_;

    # Store the ResultSet in stash so it's available for other methods
    $c->stash(species => $species);

    my $ds = $c->model('Otter::SpeciesDat')->dataset($species);
    unless ($ds) {
        $c->response->status(404);
        $c->response->body("No such species '$species'");
        $c->detach;
    }

    # if ($ds->params->{RESTRICTED}) {
    #     $c->response->status(401);
    #     $c->response->body("Not permitted to see '$species'");
    #     $c->detach;
    # }

    $c->stash(dataset => $ds);

    # Print a message to the debug log
    $c->log->debug("*** SPECIES: >$species< ***");
}

=head2 index

=cut

sub index :Chained('base') :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash(template => 'species.tt2');
}


=head1 AUTHOR

Michael Gray

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
