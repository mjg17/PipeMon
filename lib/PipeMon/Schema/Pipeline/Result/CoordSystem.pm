package PipeMon::Schema::Pipeline::Result::CoordSystem;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

PipeMon::Schema::Pipeline::Result::CoordSystem

=cut

__PACKAGE__->table("coord_system");

=head1 ACCESSORS

=head2 coord_system_id

  data_type: INT
  default_value: undef
  extra: HASH(0x89c47bc)
  is_auto_increment: 1
  is_nullable: 0
  size: 10

=head2 species_id

  data_type: INT
  default_value: 1
  extra: HASH(0x89c1e60)
  is_nullable: 0
  size: 10

=head2 name

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 40

=head2 version

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 255

=head2 rank

  data_type: INT
  default_value: 0
  is_nullable: 0
  size: 11

=head2 attrib

  data_type: SET
  default_value: undef
  extra: HASH(0x89abc84)
  is_nullable: 1
  size: 30

=cut

__PACKAGE__->add_columns(
  "coord_system_id",
  {
    data_type => "INT",
    default_value => undef,
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
    size => 10,
  },
  "species_id",
  {
    data_type => "INT",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 10,
  },
  "name",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 40 },
  "version",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "rank",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
  "attrib",
  {
    data_type => "SET",
    default_value => undef,
    extra => { list => ["default_version", "sequence_level"] },
    is_nullable => 1,
    size => 30,
  },
);
__PACKAGE__->set_primary_key("coord_system_id");
__PACKAGE__->add_unique_constraint("name_idx", ["name", "version", "species_id"]);
__PACKAGE__->add_unique_constraint("rank_idx", ["rank", "species_id"]);


# Created by DBIx::Class::Schema::Loader v0.05002 @ 2011-03-25 09:57:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Y7sG3D17QAu6+ipLhMRkhg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
