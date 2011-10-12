package PipeMon::Controller::InputId;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

PipeMon::Controller::InputId - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 base

Just gets us chained to the right place with the right pathpart initially

=cut

sub base :Chained('/species/base') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash( input_id_analysis_rs => $c->model('PipeForSpecies::InputIdAnalysis') );
}

=head2 input_id

=cut

sub input_id :Chained('base') :PathPart('input_id') :Args(1) {
    my ( $self, $c, $key ) = @_;

    my $resultset = $c->stash->{input_id_analysis_rs};

    my $input_id;
    if ($key =~ /^[[:alnum:]:.]+$/) {
        $input_id = $resultset->search( 
            {
                'me.input_id'         => $key,
                'analysis.logic_name' => { like => 'Submit%' },
            },
            {
                join => 'analysis'
            }
            )->single;
    } else {
        # Bad format
        $c->response->status(400);
        $c->response->body("'$key' doesn't look like an input_id");
        $c->detach;
    }

    unless ($input_id) {
        $c->response->status(404);
        $c->response->body("No such input_id '$key'");
        $c->detach;
    }

    my $jobs     = $input_id->jobs_by_input_id;
    my $analyses = $input_id->analyses_by_input_id;

    $c->stash( input_id   => $input_id,
               jobs       => $jobs,
               analyses   => $analyses,
               template   => 'input_id/input_id.tt2',
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
