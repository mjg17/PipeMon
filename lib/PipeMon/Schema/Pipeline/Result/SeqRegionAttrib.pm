package PipeMon::Schema::Pipeline::Result::SeqRegionAttrib;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

PipeMon::Schema::Pipeline::Result::SeqRegionAttrib

=cut

__PACKAGE__->table("seq_region_attrib");

=head1 ACCESSORS

=head2 seq_region_id

  data_type: INT
  default_value: 0
  extra: HASH(0x89c9de4)
  is_nullable: 0
  size: 10

=head2 attrib_type_id

  data_type: SMALLINT
  default_value: 0
  extra: HASH(0x880d0a4)
  is_nullable: 0
  size: 5

=head2 value

  data_type: TEXT
  default_value: undef
  is_nullable: 0
  size: 65535

=cut

__PACKAGE__->add_columns(
  "seq_region_id",
  {
    data_type => "INT",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 10,
  },
  "attrib_type_id",
  {
    data_type => "SMALLINT",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 5,
  },
  "value",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 0,
    size => 65535,
  },
);


# Created by DBIx::Class::Schema::Loader v0.05002 @ 2011-03-25 09:57:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jYQQaqnTkFB6KYg+t8vsuw

# We can't safely assume a unique primary key. Well, probably we can for pipe_*, but not for loutre_*

__PACKAGE__->belongs_to(
    'attrib_type',
    'PipeMon::Schema::Pipeline::Result::AttribType',
    'attrib_type_id',
    {
        proxy => [ qw/code name description/ ],
    },
    );

1;
