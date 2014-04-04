use utf8;
package PipeMon::Schema::Pipeline::Result::TmpMask;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::TmpMask

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tmp_mask>

=cut

__PACKAGE__->table("tmp_mask");

=head1 ACCESSORS

=head2 tmp_mask_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 tmp_align_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 alt_mask_start

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 alt_mask_end

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 ref_mask_start

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 ref_mask_end

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "tmp_mask_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "tmp_align_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "alt_mask_start",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "alt_mask_end",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "ref_mask_start",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "ref_mask_end",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</tmp_mask_id>

=back

=cut

__PACKAGE__->set_primary_key("tmp_mask_id");


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-03-28 10:45:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1gGDXTsXpbviVxZf/QzTow


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
