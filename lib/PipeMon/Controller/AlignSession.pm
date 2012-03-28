package PipeMon::Controller::AlignSession;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

PipeMon::Controller::AlignSession - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 base

Just gets us chained to the right place with the right pathpart initially

=cut

sub base :Chained('/loutreorpipe/base') :PathPart('align') :CaptureArgs(0) {
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
               template => 'align/sessions.tt2',
        );
}

=head2 stages

=cut

sub stages :Chained('base') :PathPart('stages') :Args(1) {
    my ( $self, $c, $key ) = @_;
    my $session = $c->stash->{align_session_rs}->find(
        $key,
        { prefetch => [ qw(ref_seq_region alt_seq_region ) ] },
        );
    my $stages = $session->align_stages->search(
        undef,
        { order_by => 'align_stage_id' },
        );
    $c->stash( session  => $session,
               stages   => [ $stages->all ],
               template => 'align/stages.tt2',
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
