package PipeMon::Schema::PipeQueue::Result::Queue;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

PipeMon::Schema::PipeQueue::Result::Queue

=cut

__PACKAGE__->table("queue");

=head1 ACCESSORS

=head2 id

  data_type: INT
  default_value: undef
  extra: HASH(0x89c0a50)
  is_auto_increment: 1
  is_nullable: 0
  size: 10

=head2 created

  data_type: DATETIME
  default_value: 0000-00-00 00:00:00
  is_nullable: 0
  size: 19

=head2 priority

  data_type: INT
  default_value: 0
  is_nullable: 0
  size: 11

=head2 job_id

  data_type: INT
  default_value: 0
  extra: HASH(0x89c0300)
  is_nullable: 0
  size: 10

=head2 host

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 40

=head2 pipeline

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 40

=head2 analysis

  data_type: VARCHAR
  default_value: (empty string)
  is_nullable: 0
  size: 40

=head2 is_update

  data_type: INT
  default_value: 0
  extra: HASH(0x89c0cd8)
  is_nullable: 0
  size: 10

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "INT",
    default_value => undef,
    extra => { unsigned => 1 },
    is_auto_increment => 1,
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
  "priority",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
  "job_id",
  {
    data_type => "INT",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 10,
  },
  "host",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 40 },
  "pipeline",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 40 },
  "analysis",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 40 },
  "is_update",
  {
    data_type => "INT",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 10,
  },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.05002 @ 2011-04-05 15:05:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jAvvgcz7qjP+NbZ2BtY3GQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
