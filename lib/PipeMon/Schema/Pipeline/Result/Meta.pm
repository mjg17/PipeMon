package PipeMon::Schema::Pipeline::Result::Meta;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

PipeMon::Schema::Pipeline::Result::Meta

=cut

__PACKAGE__->table("meta");

=head1 ACCESSORS

=head2 meta_id

  data_type: INT
  default_value: undef
  is_auto_increment: 1
  is_nullable: 0
  size: 11

=head2 species_id

  data_type: INT
  default_value: 1
  extra: HASH(0x8ac9adc)
  is_nullable: 1
  size: 10

=head2 meta_key

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 40

=head2 meta_value

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "meta_id",
  {
    data_type => "INT",
    default_value => undef,
    is_auto_increment => 1,
    is_nullable => 0,
    size => 11,
  },
  "species_id",
  {
    data_type => "INT",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => 10,
  },
  "meta_key",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 40 },
  "meta_value",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("meta_id");


# Created by DBIx::Class::Schema::Loader v0.05002 @ 2011-06-22 16:42:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QT7wha1on2YnhF/+lmmTgg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
