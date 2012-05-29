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

sub base :Chained('/loutreorpipe/base') :PathPart('meta') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $model = $c->stash->{db_model};
    $c->stash( meta_rs => $model->resultset('Meta') );
}

=head2 sorted

Apply a standard sort order

=cut

sub sorted :Chained('base') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    my $resultset = $c->stash->{meta_rs};
    my $sorted = $resultset->search(
        undef,
        { order_by => [ qw(species_id meta_key meta_value) ] },
        );
    $c->stash( sorted_rs => $sorted );
}

=head2 all

=cut

sub all :Chained('sorted') :PathPart('all') :Args(0) {
    my ( $self, $c ) = @_;
    my $sorted = $c->stash->{sorted_rs};
    $c->stash( meta_t   => [$sorted->all],
               template => 'meta/all.tt2',
               title    => '[all]',
        );
}

=head2 subset

=cut

sub subset :Chained('sorted') :PathPart('') :Args(1) {
    my ( $self, $c, $subset ) = @_;

    unless ($subset =~ /^\w+$/) {
        # Bad format
        $c->response->status(400);
        $c->response->body("'$subset' doesn't look like a metakey class");
        $c->detach;
    }

    my $like = $subset . '.%';
    my $title = sprintf('[%s.*]', $subset);

    my $sorted = $c->stash->{sorted_rs};
    my $sifted = $sorted->search(
        { meta_key => { like => $like } },
        );

    $c->stash( meta_t   => [$sifted->all],
               template => 'meta/all.tt2',
               title    => $title,
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
