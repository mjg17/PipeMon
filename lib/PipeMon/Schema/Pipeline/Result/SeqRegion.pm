use utf8;
package PipeMon::Schema::Pipeline::Result::SeqRegion;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PipeMon::Schema::Pipeline::Result::SeqRegion

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<seq_region>

=cut

__PACKAGE__->table("seq_region");

=head1 ACCESSORS

=head2 seq_region_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 40

=head2 coord_system_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 length

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "seq_region_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 40 },
  "coord_system_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "length",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</seq_region_id>

=back

=cut

__PACKAGE__->set_primary_key("seq_region_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<name_cs_idx>

=over 4

=item * L</name>

=item * L</coord_system_id>

=back

=cut

__PACKAGE__->add_unique_constraint("name_cs_idx", ["name", "coord_system_id"]);


# Created by DBIx::Class::Schema::Loader v0.07018 @ 2012-11-29 16:38:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zFxrV6ouTYxhBwasuPep2A

# You can replace this text with custom content, and it will be preserved on regeneration

__PACKAGE__->belongs_to(
    'coord_system',
    'PipeMon::Schema::Pipeline::Result::CoordSystem',
    'coord_system_id',
    {
        proxy => { 
            cs_name =>    'name',
            cs_version => 'version',
        },
    },
    );

__PACKAGE__->has_many(
    'attributes',
    'PipeMon::Schema::Pipeline::Result::SeqRegionAttrib',
    'seq_region_id',
    );

__PACKAGE__->has_many(
    'sv_attributes',
    'PipeMon::Schema::Pipeline::Result::SeqRegionAttrib::SV',
    'seq_region_id',            # FIXME: limit to attrs we expect to be SV
    );

__PACKAGE__->has_many(
    'component_assembly_entries',
    'PipeMon::Schema::Pipeline::Result::Assembly',
    { 'foreign.asm_seq_region_id' => 'self.seq_region_id' },
    );

__PACKAGE__->has_many(
    'assembly_assembly_entries',
    'PipeMon::Schema::Pipeline::Result::Assembly',
    { 'foreign.cmp_seq_region_id' => 'self.seq_region_id' },
    );

__PACKAGE__->many_to_many(
    'all_components',
    'component_assembly_entries',
    'component',
    );
    
__PACKAGE__->many_to_many(
    'all_assemblies',
    'assembly_assembly_entries',
    'assembly',
    );
    
__PACKAGE__->has_many(
    'dna_align_features',
    'PipeMon::Schema::Pipeline::Result::DnaAlignFeature',
    'seq_region_id',
    );

__PACKAGE__->has_many(
    'protein_align_features',
    'PipeMon::Schema::Pipeline::Result::ProteinAlignFeature',
    'seq_region_id',
    );

sub get_attrib_val_by_code {
    my ($self, $code) = @_;

    # Prefetch-friendly, at the expense of a quick grep through all the attribs
    #
    my (@attrs) = grep { $_->attrib_type->code eq $code } $self->sv_attributes;
    if (@attrs) {
        return $attrs[0]->value;
    } else {
        return undef;
    }
}

sub write_access {
    my ($self) = @_;
    return $self->get_attrib_val_by_code('write_access');
}

sub hidden {
    my ($self) = @_;
    return $self->get_attrib_val_by_code('hidden');
}

sub display_name {
    my ($self) = @_;
    return join(':',
                $self->cs_name,
                $self->cs_version || '',
                $self->name
        );
}

# May not be general
#
sub input_id_name {
    my ($self) = @_;
    my ($start, $end) = $self->name =~ /.+\.(\d+)\.(\d+)$/;
    return join(':',
                $self->display_name,
                $start,
                $end,
                1,
        );
}

sub n_all_components {
    my ($self) = @_;
    return $self->all_components->count;
}
sub n_all_assemblies {
    my ($self) = @_;
    return $self->all_assemblies->count;
}

sub mappings_to {
    my ($self) = @_;
    return $self->all_components->search(
        { 'coord_system.name' => $self->cs_name },
        {
            join     => 'coord_system',
            group_by => 'seq_region_id',
            '+select' => [ { count => 1 } ],
            '+as'     => [ 'segments'     ],
        },
        );
}

sub mappings_from {
    my ($self) = @_;
    return $self->all_assemblies->search(
        { 'coord_system.name' => $self->cs_name },
        {
            join      => 'coord_system',
            group_by  => 'seq_region_id',
            '+select' => [ { count => 1 } ],
            '+as'     => [ 'segments'     ],
        },
        );
}

sub n_mappings_to {
    my ($self) = @_;
    return $self->mappings_to->count;
}

sub n_mappings_from {
    my ($self) = @_;
    return $self->mappings_from->count;
}

sub components {
    my ($self) = @_;
    return $self->all_components->search(
        { 'coord_system.name' => { '!=' => $self->cs_name } },
        { join     => 'coord_system' },
        );
}

sub assemblies {
    my ($self) = @_;
    return $self->all_assemblies->search(
        { 'coord_system.name' => { '!=' => $self->cs_name } },
        { join     => 'coord_system' },
        );
}

sub n_components {
    my ($self) = @_;
    return $self->components->count;
}
sub n_assemblies {
    my ($self) = @_;
    return $self->assemblies->count;
}

sub component_types {
    my ($self) = @_;
    return $self->components->search(
        undef,
        {
            group_by => 'coord_system_id',
            '+select' => [ { count => 1 } ],
            '+as'     => [ 'count'     ],
        }
        );
}

# A bit obscure?
sub sole_component {
    my ($self, $spec ) = @_;
    my $results = $self->components->search( $spec );
    my $r1 = $results->next;
    return undef unless $r1;
    return undef if $results->next; # more than one, so don't return anything
    return $r1;
}

sub assembly_types {
    my ($self) = @_;
    return $self->assemblies->search(
        undef,
        {
            group_by => 'coord_system_id',
            '+select' => [ { count => 1 } ],
            '+as'     => [ 'count'        ],
        }
        );
}

# A bit obscure?
sub sole_assembly {
    my ($self, $spec ) = @_;
    my $results = $self->assemblies->search( $spec );
    my $r1 = $results->next;
    return undef unless $r1;
    return undef if $results->next; # more than one, so don't return anything
    return $r1;
}

1;
