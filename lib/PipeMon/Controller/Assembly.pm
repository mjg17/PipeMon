package PipeMon::Controller::Assembly;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

PipeMon::Controller::Assembly - Catalyst Controller

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
    $c->stash( assembly_rs => $model->resultset('Assembly') );
}

=head2 components

=cut

sub components :Chained('base') :PathPart('components') :Args(1) {
    my ( $self, $c, $assembly_sr_id ) = @_;

    unless ($assembly_sr_id =~ /^\d+$/) {
        # Bad format
        $c->response->status(400);
        $c->response->body("'$assembly_sr_id' doesn't look like a seq_region_id");
        $c->detach;
    }

    my $asm_seq_region = $c->stash->{db_model}->resultset('SeqRegion')->find($assembly_sr_id);
    unless ($asm_seq_region) {
        $c->response->status(404);
        $c->response->body("No such assembly '$asm_seq_region'");
        $c->detach;
    }

    my %search = ( asm_seq_region_id => $assembly_sr_id );

    foreach my $key (qw(cs_version cs_name)) {
        if (my $value = $c->request->parameters->{$key}) {
            my $field = $key;
            $field =~ s/cs_/coord_system./;
            $search{$field} = $value;
        }
    }

    my $page  = $c->request->parameters->{page}  || 1;
    my $limit = $c->request->parameters->{limit} || 20; # config?

    my %opts = (
        prefetch => [ 'assembly', { 'component' => 'coord_system' } ],
        order_by => 'asm_start',
        page     => $page,
        rows     => $limit,
        );

    my $cmp_rs = $c->stash->{assembly_rs}->search( \%search, \%opts );

    $c->stash(
        cmp_rs   => $cmp_rs,
        assembly => $asm_seq_region,
        pager    => $cmp_rs->pager,
        template => 'assembly/components.tt2',
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
