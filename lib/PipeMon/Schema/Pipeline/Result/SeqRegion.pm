package PipeMon::Schema::Pipeline::Result::SeqRegion;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

PipeMon::Schema::Pipeline::Result::SeqRegion

=cut

__PACKAGE__->table("seq_region");

=head1 ACCESSORS

=head2 seq_region_id

  data_type: INT
  default_value: undef
  extra: HASH(0x89d6c88)
  is_auto_increment: 1
  is_nullable: 0
  size: 10

=head2 name

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 40

=head2 coord_system_id

  data_type: INT
  default_value: 0
  extra: HASH(0x89d7108)
  is_nullable: 0
  size: 10

=head2 length

  data_type: INT
  default_value: undef
  extra: HASH(0x89c68dc)
  is_nullable: 0
  size: 10

=cut

__PACKAGE__->add_columns(
  "seq_region_id",
  {
    data_type => "INT",
    default_value => undef,
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
    size => 10,
  },
  "name",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 40 },
  "coord_system_id",
  {
    data_type => "INT",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 10,
  },
  "length",
  {
    data_type => "INT",
    default_value => undef,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 10,
  },
);
__PACKAGE__->set_primary_key("seq_region_id");
__PACKAGE__->add_unique_constraint("name_cs_idx", ["name", "coord_system_id"]);


# Created by DBIx::Class::Schema::Loader v0.05002 @ 2011-03-25 09:57:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EVWZYLo7VZ4UyfOfUYbLXg

# You can replace this text with custom content, and it will be preserved on regeneration

__PACKAGE__->belongs_to(
    'coord_system',
    'PipeMon::Schema::Pipeline::Result::CoordSystem',
    'coord_system_id',
    );

1;
