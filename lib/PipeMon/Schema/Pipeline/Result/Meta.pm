use utf8;
package PipeMon::Schema::Pipeline::Result::Meta;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::Meta

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<meta>

=cut

__PACKAGE__->table("meta");

=head1 ACCESSORS

=head2 meta_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 species_id

  data_type: 'integer'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 1

=head2 meta_key

  data_type: 'varchar'
  is_nullable: 0
  size: 40

=head2 meta_value

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "meta_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "species_id",
  {
    data_type => "integer",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 1,
  },
  "meta_key",
  { data_type => "varchar", is_nullable => 0, size => 40 },
  "meta_value",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</meta_id>

=back

=cut

__PACKAGE__->set_primary_key("meta_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<species_key_value_idx>

=over 4

=item * L</species_id>

=item * L</meta_key>

=item * L</meta_value>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "species_key_value_idx",
  ["species_id", "meta_key", "meta_value"],
);


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-11-29 16:38:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HX+m+5gTABefKYRe4oP+Eg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
