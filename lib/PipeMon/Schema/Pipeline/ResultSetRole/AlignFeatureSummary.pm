package PipeMon::Schema::Pipeline::ResultSetRole::AlignFeatureSummary;

use Moose::Role;
requires 'search';

use feature 'switch';

=head2 summary

A predefined group_by summary of {dna,protein}_align_features

FIXME: copy-and-pasted from ...:ResultSet::Job.

=cut

sub summary {
    my ($self, @group_on) = @_;

    my @join;
    my @group;
    my @as;

    foreach my $g (@group_on) {

        my $group_prefix;

        given ($g) {

            when ([ qw{ analysis_id seq_region_id hit_name } ]) {
                $group_prefix = 'me';
            }

            when ('logic_name') {
                $group_prefix = 'analysis';
                push @join, 'analysis';
            }

            default {
                die "Summary by '$g' not supported";
            }
        }

        push @group, sprintf('%s.%s', $group_prefix, $g);
        push @as,    $g;
    }

    my %opts = (
        select   => [ @group, { count => '1' } ],
        as       => [ @as,    'feature_count' ],
        group_by => [ @group ],
        );
    if (@join) {
        $opts{join} = \@join;
    }

    return $self->search( undef, \%opts );
}

1;
