use utf8;
package PipeMon::Schema::Pipeline::Result::TmpAlign;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::TmpAlign

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tmp_align>

=cut

__PACKAGE__->table("tmp_align");

=head1 ACCESSORS

=head2 tmp_align_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 align_session_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 alt_start

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 alt_end

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 ref_start

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 ref_end

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "tmp_align_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "align_session_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "alt_start",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "alt_end",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "ref_start",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "ref_end",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</tmp_align_id>

=back

=cut

__PACKAGE__->set_primary_key("tmp_align_id");


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-03-28 10:45:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JKlFh0uUInRpuiCs1KnhCQ

__PACKAGE__->has_many(
    'masks',
    'PipeMon::Schema::Pipeline::Result::TmpMask',
    'tmp_align_id',
    );

1;
