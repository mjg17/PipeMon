package PipeMon::Schema::Pipeline::Result::InputIdAnalysis;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

PipeMon::Schema::Pipeline::Result::InputIdAnalysis

=cut

__PACKAGE__->table("input_id_analysis");

=head1 ACCESSORS

=head2 input_id

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 input_id_type

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 40

=head2 analysis_id

  data_type: SMALLINT
  default_value: 0
  extra: HASH(0x89c9664)
  is_nullable: 0
  size: 10

=head2 created

  data_type: DATETIME
  default_value: 0000-00-00 00:00:00
  is_nullable: 0
  size: 19

=head2 runhost

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 20

=head2 db_version

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 40

=head2 result

  data_type: INT
  default_value: 0
  is_nullable: 0
  size: 11

=cut

__PACKAGE__->add_columns(
  "input_id",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 100 },
  "input_id_type",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 40 },
  "analysis_id",
  {
    data_type => "SMALLINT",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 10,
  },
  "created",
  {
    data_type => "DATETIME",
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
    size => 19,
  },
  "runhost",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 20 },
  "db_version",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 40 },
  "result",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
);
__PACKAGE__->set_primary_key("analysis_id", "input_id");


# Created by DBIx::Class::Schema::Loader v0.05002 @ 2011-03-25 09:57:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iEStsmrBn9+1h6ROQjxN/g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
