package PipeMon::Controller::Job;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

has 'job_keys' => (
    is  => 'ro',
    isa => 'ArrayRef[Str]',
);

has 'input_id_analysis_keys' => (
    is  => 'ro',
    isa => 'ArrayRef[Str]',
);

has 'pipe_queue_keys' => (
    is  => 'ro',
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
    input_id_analysis_keys => [ qw(
        input_id
        input_id_type
        analysis_id
        logic_name
        created
        runhost
        db_version
        result
    )],
    pipe_queue_keys => [ qw(
        id
        created
        priority
        is_update
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

sub base :Chained('/loutreorpipe/base') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $model = $c->stash->{db_model};
    $c->stash( job_rs => $model->resultset('Job') );
}

=head2 search

Private chained component to handle search arguments

=cut

sub search :Chained('base') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    my %search;
    my %search_params;
    my @join;
    foreach my $key (qw/analysis_id input_id/) {
        if (my $value = $c->request->parameters->{$key}) {
            $search_params{$key} = $value;
            my $search_key = 'me.' . $key;
            $search{$search_key} = $value;
        }
    }
    if (my $logic_name = $c->request->parameters->{logic_name}) {
        $search_params{logic_name}     = $logic_name;
        $search{'analysis.logic_name'} = $logic_name;
        push @join, 'analysis';
    }
    if (my $status = $c->request->parameters->{status}) {
        $search_params{status} = $status;
        $search{'job_status.status'}     = $status;
        $search{'job_status.is_current'} = 'y';
        push @join, 'job_status';
    }

    my %opts;
    if (@join) {
        $opts{join} = \@join;
    }

    my $search_rs = $c->stash->{job_rs}->search( \%search, \%opts );

    $c->stash( search_params => \%search_params,
               search_rs     => $search_rs,
        );
}

=head2 jobs

=cut

sub jobs :Chained('search') :PathPart('jobs') :Args(0) :MyAction('Paged') {
    my ( $self, $c ) = @_;

    my %opts = (
        order_by => 'job_id',
        prefetch => [ qw/analysis/ ],
        );

    my $jobs  = $c->stash->{search_rs}->search( undef, \%opts );

    $c->stash(
        jobs     => $jobs,

        paged_rs_key => 'jobs',

        template => 'job/jobs.tt2',
        );
}

=head2 job_summary

=cut

sub job_summary :Chained('search') :PathPart('job_summary') :Args(1) {
    my ( $self, $c, $group_on ) = @_;

    my @groups = split(',', $group_on);

    my $job_summary = $c->stash->{search_rs}->summary( @groups );

    $c->stash(
        job_summary => $job_summary,
        groups      => \@groups,
        template    => 'job/job_summary.tt2',
        );
}

=head2 job_summary_canned

=cut

sub job_summary_canned :Chained('search') :PathPart('job_summary') :Args(0) {
    my ( $self, $c ) = @_;

    $c->forward('job_summary', ['logic_name,status']);
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

    my $pq_rs = $c->model('PipeQueue::Queue')->by_species($c->stash->{species});
    my $pipe_queue_entry = $pq_rs->find({ job_id   => $job->job_id });

    $c->stash( job        => $job,
               job_status => [ $job->job_status->search( undef, { order_by => { '-desc' => 'time' } } ) ],
               input_id_analysis => $job->input_id_analysis,
               pq_entry   => $pipe_queue_entry,
               job_keys   => $self->job_keys,
               iia_keys   => $self->input_id_analysis_keys,
               pq_keys    => $self->pipe_queue_keys,
               template   => 'job/job.tt2',
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
