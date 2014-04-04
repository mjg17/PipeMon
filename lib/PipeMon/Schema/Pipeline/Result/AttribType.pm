use utf8;
package PipeMon::Schema::Pipeline::Result::AttribType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::AttribType

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<attrib_type>

=cut

__PACKAGE__->table("attrib_type");

=head1 ACCESSORS

=head2 attrib_type_id

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 code

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 15

=head2 name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "attrib_type_id",
  {
    data_type => "smallint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "code",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 15 },
  "name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</attrib_type_id>

=back

=cut

__PACKAGE__->set_primary_key("attrib_type_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<code_idx>

=over 4

=item * L</code>

=back

=cut

__PACKAGE__->add_unique_constraint("code_idx", ["code"]);


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-11-29 16:38:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iXBKb6hT8MzVh2E3HVKIOg

__PACKAGE__->has_many(
    'seq_region_attributes',
    'PipeMon::Schema::Pipeline::Result::SeqRegionAttrib',
    'attrib_type_id',
    );

# You can replace this text with custom content, and it will be preserved on regeneration
1;
