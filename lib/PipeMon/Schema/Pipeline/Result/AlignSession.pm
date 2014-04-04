use utf8;
package PipeMon::Schema::Pipeline::Result::AlignSession;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::AlignSession

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<align_session>

=cut

__PACKAGE__->table("align_session");

=head1 ACCESSORS

=head2 align_session_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 ref_seq_region_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 alt_seq_region_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 alt_db_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 author

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 comment

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "align_session_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "ref_seq_region_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "alt_seq_region_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "alt_db_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "author",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "comment",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</align_session_id>

=back

=cut

__PACKAGE__->set_primary_key("align_session_id");


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-03-28 10:45:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:02a5KWXH1XSNGkyiOWQPbA

__PACKAGE__->belongs_to(
    'ref_seq_region',
    'PipeMon::Schema::Pipeline::Result::SeqRegion',
    { 'foreign.seq_region_id' => 'self.ref_seq_region_id' },
    );

__PACKAGE__->belongs_to(
    'alt_seq_region',
    'PipeMon::Schema::Pipeline::Result::SeqRegion',
    { 'foreign.seq_region_id' => 'self.alt_seq_region_id' },
    );

__PACKAGE__->has_many(
    'align_stages',
    'PipeMon::Schema::Pipeline::Result::AlignStage',
    'align_session_id',
    );

__PACKAGE__->has_many(
    'tmp_aligns',
    'PipeMon::Schema::Pipeline::Result::TmpAlign',
    'align_session_id',
    );
1;
