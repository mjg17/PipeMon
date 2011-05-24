package PipeMon::Controller::PipeQueue;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

PipeMon::Controller::PipeQueue - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched PipeMon::Controller::PipeQueue in PipeQueue.');
}


=head2 summary

=cut

sub summary :Path('summary') :Args(0) {
    my ( $self, $c ) = @_;

    my $pipe_summary = $c->model('PipeQueue::Queue')->search( undef,
                                                              {
                                                                  select   => [ 'pipeline', { count => 'id' } ],
                                                                  as       => [ 'pipeline', 'job_count' ],
                                                                  group_by => [ qw( pipeline ) ]
                                                              } );
    $c->stash( 
        pipe_summary => $pipe_summary,
        template     => 'pipe_queue/summary.tt2',
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
