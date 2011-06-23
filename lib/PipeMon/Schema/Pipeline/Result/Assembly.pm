package PipeMon::Schema::Pipeline::Result::Assembly;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

PipeMon::Schema::Pipeline::Result::Assembly

=cut

__PACKAGE__->table("assembly");

=head1 ACCESSORS

=head2 asm_seq_region_id

  data_type: INT
  default_value: 0
  extra: HASH(0x8a9ca38)
  is_nullable: 0
  size: 10

=head2 cmp_seq_region_id

  data_type: INT
  default_value: 0
  extra: HASH(0x8aba1f0)
  is_nullable: 0
  size: 10

=head2 asm_start

  data_type: INT
  default_value: 0
  is_nullable: 0
  size: 10

=head2 asm_end

  data_type: INT
  default_value: 0
  is_nullable: 0
  size: 10

=head2 cmp_start

  data_type: INT
  default_value: 0
  is_nullable: 0
  size: 10

=head2 cmp_end

  data_type: INT
  default_value: 0
  is_nullable: 0
  size: 10

=head2 ori

  data_type: TINYINT
  default_value: 0
  is_nullable: 0
  size: 4

=cut

__PACKAGE__->add_columns(
  "asm_seq_region_id",
  {
    data_type => "INT",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 10,
  },
  "cmp_seq_region_id",
  {
    data_type => "INT",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 10,
  },
  "asm_start",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 10 },
  "asm_end",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 10 },
  "cmp_start",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 10 },
  "cmp_end",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 10 },
  "ori",
  { data_type => "TINYINT", default_value => 0, is_nullable => 0, size => 4 },
);
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


# Created by DBIx::Class::Schema::Loader v0.05002 @ 2011-06-22 16:42:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9Lps+CM5S7Z8Z08d4CWkww

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
