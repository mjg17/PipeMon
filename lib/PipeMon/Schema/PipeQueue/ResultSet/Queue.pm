package PipeMon::Schema::PipeQueue::ResultSet::Queue;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

=head2 by_species

=cut

sub by_species {
    my ($self, $species) = @_;
    my $pipeline = sprintf('pipe_%s', $species); # a bit hacky. should really be from mfetcher species info
    
    return $self->search( { pipeline => $pipeline } );
}

1;
