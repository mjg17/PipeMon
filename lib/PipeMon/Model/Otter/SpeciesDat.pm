package PipeMon::Model::Otter::SpeciesDat;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model::Factory::PerRequest';

__PACKAGE__->config(
    class => 'Bio::Otter::SpeciesDat',
    );

sub mangle_arguments {
    my ($self, $args) = @_;
    # Constructor takes a single filename argument
    return $args->{species_file};
}

=head1 NAME

PipeMon::Model::Otter::SpeciesDat - Catalyst Model

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
