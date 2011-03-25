package PipeMon::Model::Otter::MFetcher;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model::Adaptor';

__PACKAGE__->config( class => 'Bio::Otter::MFetcher' );

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
