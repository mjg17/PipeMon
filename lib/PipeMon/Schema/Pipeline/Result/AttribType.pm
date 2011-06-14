package PipeMon::Schema::Pipeline::Result::AttribType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

PipeMon::Schema::Pipeline::Result::AttribType

=cut

__PACKAGE__->table("attrib_type");

=head1 ACCESSORS

=head2 attrib_type_id

  data_type: SMALLINT
  default_value: undef
  extra: HASH(0x89c2298)
  is_auto_increment: 1
  is_nullable: 0
  size: 5

=head2 code

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 15

=head2 name

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 description

  data_type: TEXT
  default_value: undef
  is_nullable: 1
  size: 65535

=cut

__PACKAGE__->add_columns(
  "attrib_type_id",
  {
    data_type => "SMALLINT",
    default_value => undef,
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
    size => 5,
  },
  "code",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 15 },
  "name",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 255 },
  "description",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
);
__PACKAGE__->set_primary_key("attrib_type_id");
__PACKAGE__->add_unique_constraint("code_idx", ["code"]);


# Created by DBIx::Class::Schema::Loader v0.05002 @ 2011-03-25 09:57:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:S4C8dGPdYuq6jP1vGJE6Og

__PACKAGE__->has_many(
    'seq_region_attributes',
    'PipeMon::Schema::Pipeline::Result::SeqRegionAttrib',
    'attrib_type_id',
    );

# You can replace this text with custom content, and it will be preserved on regeneration
1;
