package PipeMon::Controller::Meta;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

PipeMon::Controller::Meta - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 base

Just gets us chained to the right place with the right pathpart initially

=cut

sub base :Chained('/loutreorpipe/base') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $model = $c->stash->{db_model};
    $c->stash( meta_rs => $model->resultset('Meta') );
}

=head2 all

=cut

sub all :Chained('base') :PathPart('all') :Args(0) {
    my ( $self, $c ) = @_;

    my $resultset = $c->stash->{meta_rs};
    my $sorted = $resultset->search(
        undef,
        { order_by => [ qw(species_id meta_key meta_value) ] },
        );

    $c->stash( meta_t   => [$sorted->all],
               template => 'meta/all.tt2',
        );
}

=head1 AUTHOR

Michael Gray

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
