use utf8;
package PipeMon::Schema::Pipeline::Result::Job;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::Job

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<job>

=cut

__PACKAGE__->table("job");

=head1 ACCESSORS

=head2 job_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 input_id

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 analysis_id

  data_type: 'smallint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 submission_id

  data_type: 'mediumint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 stdout_file

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 200

=head2 stderr_file

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 200

=head2 retry_count

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 1

=head2 temp_dir

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 100

=head2 exec_host

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 40

=cut

__PACKAGE__->add_columns(
  "job_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "input_id",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "analysis_id",
  {
    data_type => "smallint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "submission_id",
  {
    data_type => "mediumint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "stdout_file",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 200 },
  "stderr_file",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 200 },
  "retry_count",
  {
    data_type => "tinyint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 1,
  },
  "temp_dir",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 100 },
  "exec_host",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 40 },
);

=head1 PRIMARY KEY

=over 4

=item * L</job_id>

=back

=cut

__PACKAGE__->set_primary_key("job_id");


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-11-29 16:38:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YXS9ZH13Cyxv07mXudT6fA

__PACKAGE__->belongs_to(
    'analysis',
    'PipeMon::Schema::Pipeline::Result::Analysis',
    'analysis_id',
    { proxy => [ qw/logic_name/ ] },
    );

__PACKAGE__->has_many(
    'job_status',
    'PipeMon::Schema::Pipeline::Result::JobStatus',
    'job_id',
    );

__PACKAGE__->might_have(
    'current_status',
    'PipeMon::Schema::Pipeline::Result::JobStatus',
    'job_id',
    {
        where => { is_current => 'y' },
        proxy => [ qw/status time/ ],
    },
    );

__PACKAGE__->might_have(
    'input_id_analysis',
    'PipeMon::Schema::Pipeline::Result::InputIdAnalysis',
    {
        'foreign.input_id'    => 'self.input_id',
        'foreign.analysis_id' => 'self.analysis_id',
    },
    );

1;
