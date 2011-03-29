package PipeMon::Model::Otter::MFetcher;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model::Adaptor';
with 'Catalyst::Component::InstancePerContext';

__PACKAGE__->config(
    class => 'Bio::Otter::MFetcher',
    args  => { _species_dat_filename => '/nfs/WWWdev/SANGER_docs/data/otter/54/species.dat' },
 );

sub build_per_context_instance {
    my ($self, $c) = @_;

    my $new = bless({ %$self }, ref($self));
    return $new;
}

sub mangle_arguments {
    my ($self, $args) = @_;
    return %$args;
}

=head1 NAME

PipeMon::Model::Otter::MFetcher - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

Michael Gray

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
