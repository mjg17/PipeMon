package PipeMon::Schema::Pipeline::Result::JobStatus;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

PipeMon::Schema::Pipeline::Result::JobStatus

=cut

__PACKAGE__->table("job_status");

=head1 ACCESSORS

=head2 job_id

  data_type: INT
  default_value: 0
  extra: HASH(0x89d6d18)
  is_nullable: 0
  size: 10

=head2 status

  data_type: VARCHAR
  default_value: CREATED
  is_nullable: 0
  size: 40

=head2 time

  data_type: DATETIME
  default_value: 0000-00-00 00:00:00
  is_nullable: 0
  size: 19

=head2 is_current

  data_type: ENUM
  default_value: n
  extra: HASH(0x89d6898)
  is_nullable: 1
  size: 1

=cut

__PACKAGE__->add_columns(
  "job_id",
  {
    data_type => "INT",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 10,
  },
  "status",
  {
    data_type => "VARCHAR",
    default_value => "CREATED",
    is_nullable => 0,
    size => 40,
  },
  "time",
  {
    data_type => "DATETIME",
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
    size => 19,
  },
  "is_current",
  {
    data_type => "ENUM",
    default_value => "n",
    extra => { list => ["n", "y"] },
    is_nullable => 1,
    size => 1,
  },
);


# Created by DBIx::Class::Schema::Loader v0.05002 @ 2011-03-25 09:57:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:PAkXln8mjm6a8H4WNL/iLg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
