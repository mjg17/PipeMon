use utf8;
package PipeMon::Schema::Pipeline::Result::Assembly;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::Assembly

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<assembly>

=cut

__PACKAGE__->table("assembly");

=head1 ACCESSORS

=head2 asm_seq_region_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 cmp_seq_region_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 asm_start

  data_type: 'integer'
  is_nullable: 0

=head2 asm_end

  data_type: 'integer'
  is_nullable: 0

=head2 cmp_start

  data_type: 'integer'
  is_nullable: 0

=head2 cmp_end

  data_type: 'integer'
  is_nullable: 0

=head2 ori

  data_type: 'tinyint'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "asm_seq_region_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "cmp_seq_region_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "asm_start",
  { data_type => "integer", is_nullable => 0 },
  "asm_end",
  { data_type => "integer", is_nullable => 0 },
  "cmp_start",
  { data_type => "integer", is_nullable => 0 },
  "cmp_end",
  { data_type => "integer", is_nullable => 0 },
  "ori",
  { data_type => "tinyint", is_nullable => 0 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<all_idx>

=over 4

=item * L</asm_seq_region_id>

=item * L</cmp_seq_region_id>

=item * L</asm_start>

=item * L</asm_end>

=item * L</cmp_start>

=item * L</cmp_end>

=item * L</ori>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "all_idx",
  [
    "asm_seq_region_id",
    "cmp_seq_region_id",
    "asm_start",
    "asm_end",
    "cmp_start",
    "cmp_end",
    "ori",
  ],
);


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-11-29 16:38:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Oho6lB8vuz5E9x0V6C2u8Q

# You can replace this text with custom content, and it will be preserved on regeneration

__PACKAGE__->belongs_to(
    'assembly',
    'PipeMon::Schema::Pipeline::Result::SeqRegion',
    { 'foreign.seq_region_id' => 'self.asm_seq_region_id' },
    );

__PACKAGE__->belongs_to(
    'component',
    'PipeMon::Schema::Pipeline::Result::SeqRegion',
    { 'foreign.seq_region_id' => 'self.cmp_seq_region_id' },
    );

1;
