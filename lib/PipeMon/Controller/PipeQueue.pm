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

=head2 priority

=cut

sub priority :Path('priority') :Args(0) {
    my ( $self, $c ) = @_;

    my ($where, $species_list);
    if (my $species = $c->request->parameters->{species}) {
        my @species = split ',', $species;
        my @pipeline_list = map { 'pipe_' . $_ } @species;
        $where = { pipeline => { -in => \@pipeline_list } };
        $species_list = ' for ' . join ', ', @species;
    }

    my @fields = qw( pipeline analysis priority is_update );

    my $pipe_priority = $c->model('PipeQueue::Queue')->search(
        $where,
        {
            select   => [ @fields, { min => 'created' }, { max => 'created' }, { count => 'id' } ],
            as       => [ @fields, 'oldest',             'youngest',           'job_count' ],
            group_by => [ @fields ],
            order_by => { -desc => 'priority' },
        } );
    $c->stash(
        pipe_priority => $pipe_priority,
        species_list  => $species_list,
        template      => 'pipe_queue/priority.tt2',
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
