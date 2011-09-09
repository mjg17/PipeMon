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

sub components :Chained('base') :PathPart('components') :Args(2) {
    my ( $self, $c, $assembly_sr_id, $coord_system_id ) = @_;

    unless ($assembly_sr_id =~ /^\d+$/) {
        # Bad format
        $c->response->status(400);
        $c->response->body("'$assembly_sr_id' doesn't look like a seq_region_id");
        $c->detach;
    }

    my $asm_seq_region = $c->stash->{db_model}->resultset('SeqRegion')->find($assembly_sr_id);
    unless ($asm_seq_region) {
        $c->response->status(404);
        $c->response->body("No such assembly '$assembly_sr_id'");
        $c->detach;
    }

    my %search = (
        'asm_seq_region_id'         => $assembly_sr_id,
        'component.coord_system_id' => $coord_system_id,
        );

    my $page  = $c->request->parameters->{page};
    my $limit = $c->request->parameters->{limit} || 20; # config?
    my $focus = $c->request->parameters->{focus};

    if ($focus and not $page) {
        my $focus_row = $c->stash->{db_model}->resultset('AssemblyRank')->search(
            {},
            { bind => [ $assembly_sr_id, $focus ] },
            )->first;
        if ($focus_row) {
            my $rank = $focus_row->get_column('rank');
            $page = int(($rank - 1) / $limit) + 1;
        }
    }
    $page ||= 1;

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
        focus    => $focus,
        template => 'assembly/components.tt2',
        );
}

=head2 mapping

=cut

sub mapping :Chained('base') :PathPart('mapping') :Args(2) {
    my ( $self, $c, $ref_sr_id, $alt_sr_id ) = @_;

    my %checks = ( Ref => $ref_sr_id, Alt => $alt_sr_id );
    while (my ($key, $val) = each %checks) {
        unless ($val =~ /^\d+$/) {
            # Bad format
            $c->response->status(400);
            $c->response->body("$key '$val' doesn't look like a seq_region_id");
            $c->detach;
        }
    }
    my %seq_region;
    while (my ($key, $val) = each %checks) {
        $seq_region{$key} = $c->stash->{db_model}->resultset('SeqRegion')->find($val);
        unless ($seq_region{$key}) {
            $c->response->status(404);
            $c->response->body("$key assembly '$val' not found");
            $c->detach;
        }
    }

    my $cmp_rs = $c->stash->{assembly_rs}->search(
        {
            asm_seq_region_id => $ref_sr_id,
            cmp_seq_region_id => $alt_sr_id,
        },
        {
            prefetch => [ 'assembly', 'component' ],
            order_by => 'asm_start',
        }
        );

    $c->stash(
        cmp_rs   => $cmp_rs,
        ref_sr   => $seq_region{'Ref'},
        alt_sr   => $seq_region{'Alt'},
        template => 'assembly/mapping.tt2',
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
