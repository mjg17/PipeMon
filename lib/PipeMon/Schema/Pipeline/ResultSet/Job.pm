package PipeMon::Schema::Pipeline::ResultSet::Job;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Switch;

=head2 summary

A predefined group_by summary of jobs

=cut

sub summary {
    my ($self, $group_on, $search_args) = @_;

    $search_args ||= {};
    my %search = ( %$search_args );

    my @join;

    my ($group_by, $group_prefix);
    switch ($group_on) {

        case 'analysis_id' {
            $group_prefix = 'me';
        }

        case 'status' {
            $group_prefix = 'job_status';
            push @join, 'job_status';
            $search{is_current} = 'y';
        }

        case 'logic_name' {
            $group_prefix = 'analysis';
            push @join, 'analysis';
        }

        else {
            die "Summary by '$group_on' not supported";
        }
    }
    $group_by = sprintf('%s.%s', $group_prefix, $group_on) unless $group_by;

    my %opts = (
        select   => [ $group_by, { count => 'me.job_id' } ],
        as       => [ qw/group_by job_count/ ],
        group_by => [ $group_by ],
        );
    if (@join) {
        $opts{join} = \@join;
    }

    return $self->search( \%search, \%opts );
}

1;
