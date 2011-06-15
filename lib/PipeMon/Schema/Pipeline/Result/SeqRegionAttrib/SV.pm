package PipeMon::Schema::Pipeline::Result::SeqRegionAttrib::SV;

use strict;
use warnings;

use base 'PipeMon::Schema::Pipeline::Result::SeqRegionAttrib';


=head1 NAME

PipeMon::Schema::Pipeline::Result::SeqRegionAttrib::SV

=cut

__PACKAGE__->table("seq_region_attrib");
__PACKAGE__->set_primary_key(qw/seq_region_id attrib_type_id/);

1;
