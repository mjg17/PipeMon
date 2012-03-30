use utf8;
package PipeMon::Schema::Pipeline::Result::ProteinAlignFeature;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::ProteinAlignFeature

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<protein_align_feature>

=cut

__PACKAGE__->table("protein_align_feature");

=head1 ACCESSORS

=head2 protein_align_feature_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 seq_region_id

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 seq_region_start

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 seq_region_end

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 seq_region_strand

  data_type: 'tinyint'
  default_value: 1
  is_nullable: 0

=head2 hit_start

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 hit_end

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 hit_name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 40

=head2 analysis_id

  data_type: 'smallint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 score

  data_type: 'double precision'
  is_nullable: 1

=head2 evalue

  data_type: 'double precision'
  is_nullable: 1

=head2 perc_ident

  data_type: 'float'
  is_nullable: 1

=head2 cigar_line

  data_type: 'text'
  is_nullable: 1

=head2 external_db_id

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 hcoverage

  data_type: 'double precision'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "protein_align_feature_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "seq_region_id",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "seq_region_start",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "seq_region_end",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "seq_region_strand",
  { data_type => "tinyint", default_value => 1, is_nullable => 0 },
  "hit_start",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "hit_end",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "hit_name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 40 },
  "analysis_id",
  {
    data_type => "smallint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "score",
  { data_type => "double precision", is_nullable => 1 },
  "evalue",
  { data_type => "double precision", is_nullable => 1 },
  "perc_ident",
  { data_type => "float", is_nullable => 1 },
  "cigar_line",
  { data_type => "text", is_nullable => 1 },
  "external_db_id",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "hcoverage",
  { data_type => "double precision", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</protein_align_feature_id>

=back

=cut

__PACKAGE__->set_primary_key("protein_align_feature_id");


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-03-30 11:54:25
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:i7LYBRcqmkEDeeDJ4m7U6Q


__PACKAGE__->belongs_to(
    'analysis',
    'PipeMon::Schema::Pipeline::Result::Analysis',
    'analysis_id',
    );

__PACKAGE__->belongs_to(
    'seq_region',
    'PipeMon::Schema::Pipeline::Result::SeqRegion',
    'seq_region_id',
    );

1;
