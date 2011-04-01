package PipeMon::Controller::Job;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

has 'job_keys' => (
    is  => 'rw',
    isa => 'ArrayRef[Str]',
);

__PACKAGE__->config(
    job_keys => [ qw(
        job_id
        input_id
        analysis_id
        logic_name
        submission_id
        status
        stdout_file
        stderr_file
        retry_count
        temp_dir
        exec_host
    )],
    );

=head1 NAME

PipeMon::Controller::Job - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 base

Just gets us chained to the right place with the right pathpart initially

=cut

sub base :Chained('/species/base') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash( job_rs => $c->model('PipeForSpecies::Job') );
}

=head2 list

=cut

sub list :Chained('base') :PathPart('jobs') :Args(0) {
    my ( $self, $c ) = @_;

    my $limit = $c->request->parameters->{limit} || 20;

    my $jobs  = $c->stash->{job_rs}->search( undef, 
                                             { order_by => 'job_id',
                                               rows     => $limit,
                                               prefetch => [ qw/analysis/ ] } );

    my $total = $c->stash->{job_rs}->count;

    $c->stash(
        jobs     => $jobs,
        limit    => $limit,
        total    => $total,
        template => 'job/list.tt2',
        );
}

=head2 job

=cut

sub job :Chained('base') :PathPart('job') :Args(1) {
    my ( $self, $c, $key ) = @_;

    my $resultset = $c->stash->{job_rs};

    my $job;
    if ($key =~ /^\d+$/) {
        $job = $resultset->find($key, { prefetch => 'analysis' } );
    } else {
        # Bad format
        $c->response->status(400);
        $c->response->body("'$key' doesn't look like a job_id");
        $c->detach;
    }

    unless ($job) {
        $c->response->status(404);
        $c->response->body("No such job '$key'");
        $c->detach;
    }

    $c->stash( job      => $job,
               keys     => $self->job_keys,
               template => 'job/job.tt2',
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
