package PipeMon::Schema::Pipeline::ResultSet::Job;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Switch;

=head2 summary

A predefined group_by summary of jobs

=cut

sub summary {
    my ($self, @group_on) = @_;

    my %search;

    my @join;
    my @group;
    my @as;

    foreach my $g (@group_on) {

        my ($group_by, $group_prefix);

        switch ($g) {

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
                die "Summary by '$g' not supported";
            }
        }

        $group_by = sprintf('%s.%s', $group_prefix, $g) unless $group_by;
        push @group, $group_by;
        push @as,    $g;
    }

    my %opts = (
        select   => [ @group, { count => 'me.job_id' } ],
        as       => [ @as,       'job_count' ],
        group_by => [ @group ],
        );
    if (@join) {
        $opts{join} = \@join;
    }

    return $self->search( \%search, \%opts );
}

1;
