use utf8;
package PipeMon::Schema::Pipeline::Result::JobStatus;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::JobStatus

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<job_status>

=cut

__PACKAGE__->table("job_status");

=head1 ACCESSORS

=head2 job_id

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 status

  data_type: 'varchar'
  default_value: 'CREATED'
  is_nullable: 0
  size: 40

=head2 time

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 is_current

  data_type: 'enum'
  default_value: 'n'
  extra: {list => ["n","y"]}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "job_id",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "status",
  {
    data_type => "varchar",
    default_value => "CREATED",
    is_nullable => 0,
    size => 40,
  },
  "time",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "is_current",
  {
    data_type => "enum",
    default_value => "n",
    extra => { list => ["n", "y"] },
    is_nullable => 1,
  },
);


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-11-29 16:38:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wVqjmiWu4bvsHOhJZuccIQ

# A bit nasty to use all columns - consider not defining? Should only get maninpulated via joins?
__PACKAGE__->set_primary_key(qw(job_id status time is_current));

1;
