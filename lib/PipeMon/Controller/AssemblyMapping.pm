package PipeMon::Controller::AssemblyMapping;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

has 'align_stage_keys' => (
    is  => 'ro',
    isa => 'ArrayRef[Str]',
    );

__PACKAGE__->config(
    align_stage_keys => [ qw(
        align_stage_id
        stage
        ts
        script
    )],
    );

=head1 NAME

PipeMon::Controller::AssemblyMapping - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 base

Just gets us chained to the right place with the right pathpart initially

=cut

sub base :Chained('/loutreorpipe/loutre_only') :PathPart('assembly_mapping') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $model = $c->stash->{db_model};
    $c->stash( align_session_rs => $model->resultset('AlignSession') );
}

=head2 sessions

=cut

sub sessions :Chained('base') :PathPart('sessions') :Args(0) {
    my ( $self, $c ) = @_;
    my $results = $c->stash->{align_session_rs}->search(
        undef,
        { prefetch => [ qw(ref_seq_region alt_seq_region) ] },
        );
    $c->stash( sessions => [$results->all],
               template => 'assembly_mapping/sessions.tt2',
        );
}

=head2 session

Retrieves a single session for further use.

=cut

sub session :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $key ) = @_;

    unless ($key =~ /^\d+$/) {
        # Bad format
        $c->response->status(400);
        $c->response->body("'$key' doesn't look like an align_session_id");
        $c->detach;
    }

    my $session = $c->stash->{align_session_rs}->find(
        $key,
        { prefetch => [ qw(ref_seq_region alt_seq_region ) ] },
        );

    unless ($session) {
        $c->response->status(404);
        $c->response->body("No such align_session '$key'");
        $c->detach;
    }

    $c->stash( session => $session );
}

=head2 stages

=cut

sub stages :Chained('session') :PathPart('stages') :Args(0) {
    my ( $self, $c ) = @_;
    my $session = $c->stash->{session};
    my $stages = $session->align_stages->search(
        undef,
        { order_by => 'stage' },
        );
    $c->stash( session  => $session,
               stages   => [ $stages->all ],
               template => 'assembly_mapping/stages.tt2',
               align_stage_keys => $self->align_stage_keys,
        );
}

=head2 stage

=cut

sub stage :Chained('session') :PathPart('stage') :Args(1) {
    my ( $self, $c, $key ) = @_;

    unless ($key =~ /^\d+$/) {
        # Bad format
        $c->response->status(400);
        $c->response->body("'$key' doesn't look like an align_stage_id");
        $c->detach;
    }

    my $session = $c->stash->{session};
    my $stage = $session->align_stages->find($key);

    unless ($stage) {
        my $session_id = $session->align_session_id;
        $c->response->status(404);
        $c->response->body("No such align_stage '$key' for align_session $session_id");
        $c->detach;
    }

    $c->stash( stage            => $stage,
               template         => 'assembly_mapping/stage.tt2',
               align_stage_keys => $self->align_stage_keys,
        );
}

=head2 tmp_aligns

=cut

sub tmp_aligns :Chained('session') :PathPart('tmp_aligns') :Args(0) {
    my ( $self, $c ) = @_;
    my $session = $c->stash->{session};
    my $tmp_aligns = $session->tmp_aligns->search(
        { align_session_id => $session->align_session_id },
        { order_by => 'ref_start' },
        );
    $c->stash( session    => $session,
               tmp_aligns => [ $tmp_aligns->all ],
               template   => 'assembly_mapping/tmp_aligns.tt2',
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
