use utf8;
package PipeMon::Schema::Pipeline::Result::InputIdAnalysis;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::InputIdAnalysis

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<input_id_analysis>

=cut

__PACKAGE__->table("input_id_analysis");

=head1 ACCESSORS

=head2 input_id

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 input_id_type

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 40

=head2 analysis_id

  data_type: 'smallint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 runhost

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 20

=head2 db_version

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 40

=head2 result

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "input_id",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "input_id_type",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 40 },
  "analysis_id",
  {
    data_type => "smallint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "created",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "runhost",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 20 },
  "db_version",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 40 },
  "result",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</analysis_id>

=item * L</input_id>

=back

=cut

__PACKAGE__->set_primary_key("analysis_id", "input_id");


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-11-29 16:38:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LlwEda+ObU957Tyv89FMjg

__PACKAGE__->belongs_to(
    'analysis',
    'PipeMon::Schema::Pipeline::Result::Analysis',
    'analysis_id',
    { proxy => [ qw/logic_name/ ] },
    );

__PACKAGE__->has_many(
    'jobs_by_input_id',
    'PipeMon::Schema::Pipeline::Result::Job',
    { 'foreign.input_id' => 'self.input_id' },
    { prefetch => 'analysis' },
    );

__PACKAGE__->has_many(
    'analyses_by_input_id',
    'PipeMon::Schema::Pipeline::Result::InputIdAnalysis',
    { 'foreign.input_id' => 'self.input_id' },
    { prefetch => 'analysis' },
    );

1;
