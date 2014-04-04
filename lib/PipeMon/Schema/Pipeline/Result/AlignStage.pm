use utf8;
package PipeMon::Schema::Pipeline::Result::AlignStage;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::AlignStage

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<align_stage>

=cut

__PACKAGE__->table("align_stage");

=head1 ACCESSORS

=head2 align_stage_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 align_session_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 stage

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 ts

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 script

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 parameters

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "align_stage_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "align_session_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "stage",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "ts",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "script",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "parameters",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</align_stage_id>

=back

=cut

__PACKAGE__->set_primary_key("align_stage_id");


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-03-28 10:45:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6zClUeA6uywJB/0jGJOFbA

__PACKAGE__->belongs_to(
    'align_session',
    'PipeMon::Schema::Pipeline::Result::AlignSession',
    'align_session_id',
    );

1;
