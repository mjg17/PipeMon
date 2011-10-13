package PipeMon::Schema::Pipeline::ResultSet::CoordSystem;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

=head2 by_name

Fetch coord system by name and optional version

=cut

sub by_name {
    my ($self, $name, $version) = @_;

    my %search = (
        name => $name,
        );

    if ($version) {
        $search{version} = $version;
    } else {
        $search{attrib} = { like => "%default_version%" };
    }

    my %opts => (
        order_by => 'rank',
        );

    return $self->search( \%search, \%opts )->single;
}

1;
