package PipeMon::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

PipeMon::Controller::Root - Root Controller for PipeMon

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    my $species_dat = $c->model('Otter::SpeciesDat');
    my $datasets = $species_dat->datasets;
    my $ds_names = [ sort map { $_->name } grep { not $_->params->{RESTRICTED} } @$datasets ];

    $c->stash(datasets => $ds_names );
    $c->stash(template => 'datasets.tt2');
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.
Set up meta for TT META equivalent.

=cut

sub end : ActionClass('RenderView') {
    my ($self, $c) = @_;
    $c->stash(meta => {});
}

=head1 AUTHOR

Michael Gray

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
