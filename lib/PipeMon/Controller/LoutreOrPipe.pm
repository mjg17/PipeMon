package PipeMon::Controller::LoutreOrPipe;
use Moose;
use namespace::autoclean;

use feature 'switch';

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

PipeMon::Controller::LoutreOrPipe - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

Chain to species, then interpret one path arg to resolve loutre or pipe

=cut

sub base :Chained('/species/base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $db_type ) = @_;

    my $model;

    given ($db_type) {

        when ('l')      { $model = 'LoutreForSpecies'; $db_type = 'loutre'; }
        when ('loutre') { $model = 'LoutreForSpecies'; }

        when ('p')      { $model = 'PipeForSpecies';   $db_type = 'pipe'; }
        when ('pipe')   { $model = 'PipeForSpecies'; }
        
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

=head2 loutre_only

Provide a path only to .../loutre/... but otherwise behave as base

=cut

sub loutre_only :Chained('/species/base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $db_type) = @_;

    unless ($db_type eq 'loutre') {
        $c->detach('wrong_path', [$db_type, 'loutre']);
    }

    $c->forward('base/loutre');
}

=head2 pipe_only

Provide a path only to .../pipe/... but otherwise behave as base

=cut

sub pipe_only :Chained('/species/base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $db_type) = @_;

    unless ($db_type eq 'pipe') {
        $c->detach('wrong_path', [$db_type, 'pipe']);
    }

    $c->forward('base/pipe');
}

=head2 wrong_path

=cut

sub wrong_path :Private {
    my ($self, $c, $supplied, $permitted) = @_;

    unless ($supplied =~ /^(loutre|pipe)$/) {
        $c->response->status(404);
        $c->response->body("No such database type '$supplied'");
        $c->detach;
    }

    my $try_path = $c->request->uri;
    $try_path =~ s/$supplied/$permitted/;
    $c->response->status(400);
    $c->response->body(qq{
            Only available for $permitted database<br/>
            Try: <a href="$try_path">$try_path</a>
            });
    $c->detach;
}

=head1 AUTHOR

Michael Gray

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
