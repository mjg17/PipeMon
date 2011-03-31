package PipeMon::Controller::Analysis;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

has 'analysis_keys' => (
    is  => 'rw',
    isa => 'ArrayRef[Str]',
);

__PACKAGE__->config(
    analysis_keys => [ qw(
        analysis_id
        logic_name
        created
        db
        db_version
        db_file
        program
        program_version
        program_file
        parameters
        module
        module_version
        gff_source
        gff_feature
    )],
    );

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

    my $resultset = $c->model('PipeForSpecies::Analysis');

    $c->stash( analyses => [$resultset->all],
               template => 'analysis/index.tt2',
        );
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
        $c->response->status(400);
        $c->response->body("Cannot map '$key' to analysis_id or logic_name");
        $c->detach;
    }

    unless ($analysis) {
        $c->response->status(404);
        $c->response->body("No such analysis '$key'");
        $c->detach;
    }

    $c->stash( analysis => $analysis,
               keys     => $self->analysis_keys,
               template => 'analysis/analysis.tt2',
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
