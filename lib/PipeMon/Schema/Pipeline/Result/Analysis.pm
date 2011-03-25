package PipeMon::Schema::Pipeline::Result::Analysis;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

PipeMon::Schema::Pipeline::Result::Analysis

=cut

__PACKAGE__->table("analysis");

=head1 ACCESSORS

=head2 analysis_id

  data_type: SMALLINT
  default_value: undef
  extra: HASH(0x89c6bd0)
  is_auto_increment: 1
  is_nullable: 0
  size: 5

=head2 created

  data_type: DATETIME
  default_value: 0000-00-00 00:00:00
  is_nullable: 0
  size: 19

=head2 logic_name

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 128

=head2 db

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 120

=head2 db_version

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 40

=head2 db_file

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 120

=head2 program

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 80

=head2 program_version

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 40

=head2 program_file

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 80

=head2 parameters

  data_type: TEXT
  default_value: undef
  is_nullable: 1
  size: 65535

=head2 module

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 80

=head2 module_version

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 40

=head2 gff_source

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 40

=head2 gff_feature

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 40

=cut

__PACKAGE__->add_columns(
  "analysis_id",
  {
    data_type => "SMALLINT",
    default_value => undef,
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
    size => 5,
  },
  "created",
  {
    data_type => "DATETIME",
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
    size => 19,
  },
  "logic_name",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 128 },
  "db",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 120,
  },
  "db_version",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 40,
  },
  "db_file",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 120,
  },
  "program",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 80,
  },
  "program_version",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 40,
  },
  "program_file",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 80,
  },
  "parameters",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "module",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 80,
  },
  "module_version",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 40,
  },
  "gff_source",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 40,
  },
  "gff_feature",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 40,
  },
);
__PACKAGE__->set_primary_key("analysis_id");
__PACKAGE__->add_unique_constraint("logic_name_idx", ["logic_name"]);


# Created by DBIx::Class::Schema::Loader v0.05002 @ 2011-03-25 09:57:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YMFp6oFudPJQOklE9xZYJA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
