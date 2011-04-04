package PipeMon::Schema::Pipeline::Result::Job;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

PipeMon::Schema::Pipeline::Result::Job

=cut

__PACKAGE__->table("job");

=head1 ACCESSORS

=head2 job_id

  data_type: INT
  default_value: undef
  extra: HASH(0x89c9850)
  is_auto_increment: 1
  is_nullable: 0
  size: 10

=head2 input_id

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 analysis_id

  data_type: SMALLINT
  default_value: 0
  extra: HASH(0x89c93dc)
  is_nullable: 0
  size: 5

=head2 submission_id

  data_type: MEDIUMINT
  default_value: 0
  extra: HASH(0x89c9b98)
  is_nullable: 0
  size: 10

=head2 stdout_file

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 200

=head2 stderr_file

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 200

=head2 retry_count

  data_type: TINYINT
  default_value: 0
  extra: HASH(0x89c20a0)
  is_nullable: 1
  size: 2

=head2 temp_dir

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 1
  size: 100

=head2 exec_host

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 1
  size: 40

=cut

__PACKAGE__->add_columns(
  "job_id",
  {
    data_type => "INT",
    default_value => undef,
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
    size => 10,
  },
  "input_id",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 100 },
  "analysis_id",
  {
    data_type => "SMALLINT",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 5,
  },
  "submission_id",
  {
    data_type => "MEDIUMINT",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 10,
  },
  "stdout_file",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 200 },
  "stderr_file",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 200 },
  "retry_count",
  {
    data_type => "TINYINT",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => 2,
  },
  "temp_dir",
  { data_type => "VARCHAR", default_value => "", is_nullable => 1, size => 100 },
  "exec_host",
  { data_type => "VARCHAR", default_value => "", is_nullable => 1, size => 40 },
);
__PACKAGE__->set_primary_key("job_id");


# Created by DBIx::Class::Schema::Loader v0.05002 @ 2011-03-25 09:57:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aujE432V/CFSg0gHO3v/BA

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
