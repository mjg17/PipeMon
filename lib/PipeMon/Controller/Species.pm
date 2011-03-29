package PipeMon::Controller::Species;
use Moose;
use namespace::autoclean;

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

    my $ds = $c->model('Otter::MFetcher')->dataset_hash->{$species};
    unless ($ds) {
        $c->response->status(404);
        $c->response->body("No such species '$species'");
        $c->detach;
    }

    if ($ds->{RESTRICTED}) {
        $c->response->status(401);
        $c->response->body("Not permitted to see '$species'");
        $c->detach;
    }

    $c->model('Otter::MFetcher')->dataset_name($species);

    # Print a message to the debug log
    $c->log->debug("*** SPECIES: >$species< ***");
}

=head2 index

=cut

sub index :Chained('base') :Args(0) {
    my ( $self, $c ) = @_;

    my $species = $c->stash->{species};
    my $model = $c->model('PipeForSpecies');
    my $n_analyses = $model->resultset('Analysis')->count;

    $c->response->body("<p>Matched PipeMon::Controller::Species in Species for $species.</p>\n" .
        "<p>Number of analyses: $n_analyses</p>");
}


=head1 AUTHOR

Michael Gray

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
