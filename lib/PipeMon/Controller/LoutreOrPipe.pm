package PipeMon::Controller::LoutreOrPipe;
use Moose;
use namespace::autoclean;

use Switch;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

PipeMon::Controller::LoutreOrPipe - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

Chain to species, then interpret one path arg to resolve loure or pipe

=cut

sub base :Chained('/species/base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $db_type ) = @_;

    my $model;

    switch ($db_type) {

        case 'l'      { $model = 'LoutreForSpecies'; $db_type = 'loutre'; }
        case 'loutre' { $model = 'LoutreForSpecies'; }

        case 'p'      { $model = 'PipeForSpecies';   $db_type = 'pipe'; }
        case 'pipe'   { $model = 'PipeForSpecies'; }
        
    }

    unless ($model) {
        $c->response->status(404);
        $c->response->body("No such db type '$db_type'");
        $c->detach;
    }

    $c->stash(db_type  => $db_type);
    $c->stash(db_model => $c->model($model));

    $c->log->debug("*** DB MODEL: >$model< ***");
}

=head1 AUTHOR

Michael Gray

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
