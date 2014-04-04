use utf8;
package PipeMon::Schema::Pipeline::Result::SimpleFeature;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::SimpleFeature

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<simple_feature>

=cut

__PACKAGE__->table("simple_feature");

=head1 ACCESSORS

=head2 simple_feature_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 seq_region_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 seq_region_start

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 seq_region_end

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 seq_region_strand

  data_type: 'tinyint'
  is_nullable: 0

=head2 display_label

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 analysis_id

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 score

  data_type: 'double precision'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "simple_feature_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "seq_region_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "seq_region_start",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "seq_region_end",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "seq_region_strand",
  { data_type => "tinyint", is_nullable => 0 },
  "display_label",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "analysis_id",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 0 },
  "score",
  { data_type => "double precision", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</simple_feature_id>

=back

=cut

__PACKAGE__->set_primary_key("simple_feature_id");


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-11-29 16:38:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:88CR2YWU6aodUbIzyQM9CA


__PACKAGE__->belongs_to(
    'analysis',
    'PipeMon::Schema::Pipeline::Result::Analysis',
    'analysis_id',
    { proxy => [ qw/logic_name/ ] },
    );

__PACKAGE__->belongs_to(
    'seq_region',
    'PipeMon::Schema::Pipeline::Result::SeqRegion',
    'seq_region_id',
    {
        proxy => {
            seq_region_name => 'name',
        },
    },
    );

1;
