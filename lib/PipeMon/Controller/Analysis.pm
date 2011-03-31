package PipeMon::Controller::Analysis;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

PipeMon::Controller::Analysis - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 base

Just gets us chained to the right place with the right pathpart initially

=cut

sub base :Chained('/species/base') :PathPart('analysis') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

=head2 index

=cut

sub index :Chained('base') :PathPart('') :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched PipeMon::Controller::Analysis in Analysis.');
}

=head2 analysis

=cut

sub analysis :Chained('base') :PathPart('') :Args(1) {
    my ( $self, $c, $key ) = @_;

    my $resultset = $c->model('PipeForSpecies::Analysis');

    my $analysis;
    if ($key =~ /^\d+$/) {
        $analysis = $resultset->find($key);
    } elsif ($key =~ /^[[:alpha:]]\w*$/) {
        ($analysis) = $resultset->search({logic_name => $key});
    } else {
        # Bad format
    }
    my $analysis_id = "<NOT FOUND>";
    my $logic_name  = "<NOT FOUND>";

    if ($analysis) {
        $analysis_id = $analysis->analysis_id;
        $logic_name  = $analysis->logic_name;
    }

    $c->response->body("Got key: $key, analysis_id: $analysis_id, logic_name: $logic_name");
}

=head1 AUTHOR

Michael Gray

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
