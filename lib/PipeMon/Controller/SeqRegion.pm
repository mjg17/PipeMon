package PipeMon::Controller::SeqRegion;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

PipeMon::Controller::SeqRegion - Catalyst Controller

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
    $c->stash( seq_region_rs => $model->resultset('SeqRegion') );
}

=head2 seq_sets

=cut

sub seq_sets :Chained('base') :PathPart('seq_sets') :Args(0) {
    my ( $self, $c ) = @_;

    my $resultset = $c->stash->{seq_region_rs};
    my $seq_sets  = $resultset->search(
        {
            'coord_system.name' => 'chromosome',
        },
        {
            join => ['coord_system' ],
            order_by => 'me.name',
        } 
        );

    $c->stash( seq_sets => $seq_sets,
               template => 'seq_region/seq_sets.tt2',
        );
}

=head2 seq_region 

=cut

sub seq_region :Chained('base') :PathPart('seq_region') :Args(1) {
}

=head1 AUTHOR

Michael Gray

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
