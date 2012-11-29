use utf8;
package PipeMon::Schema::Pipeline::Result::SeqRegionAttrib;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::SeqRegionAttrib

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<seq_region_attrib>

=cut

__PACKAGE__->table("seq_region_attrib");

=head1 ACCESSORS

=head2 seq_region_id

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 attrib_type_id

  data_type: 'smallint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 value

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "seq_region_id",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "attrib_type_id",
  {
    data_type => "smallint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "value",
  { data_type => "text", is_nullable => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-11-29 16:38:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tBd+aJ4443H+iVwjaIZZfA

# We can't safely assume a unique primary key. Well, probably we can for pipe_*, but not for loutre_*
# Having said that, duplicate identical entries would be in error, so...

__PACKAGE__->set_primary_key(qw/seq_region_id attrib_type_id value/);

__PACKAGE__->belongs_to(
    'attrib_type',
    'PipeMon::Schema::Pipeline::Result::AttribType',
    'attrib_type_id',
    {
        proxy => [ qw/code name description/ ],
    },
    );

__PACKAGE__->belongs_to(
    'seq_region',
    'PipeMon::Schema::Pipeline::Result::SeqRegion',
    'seq_region_id',
    );

1;
