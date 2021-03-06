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

sub components :Chained('base') :PathPart('components') :Args(2) 
               :MyAction('Paged') :PagedResultSetKey('cmp_rs') :PagedFocusColumn('cmp_seq_region_id')
{
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

    my $cmp_rs = $c->stash->{assembly_rs}->search(
        {
            'asm_seq_region_id'         => $assembly_sr_id,
            'component.coord_system_id' => $coord_system_id,
        },
        {
            prefetch => [ 'assembly', 'component' ],
            order_by => 'asm_start',
        },
        );

    my $gaps_param = $c->request->parameters->{gaps},
    my $gaps = 1;
    $gaps = 0 if defined $gaps_param and not $gaps_param;

    $c->stash(
        cmp_rs             => $cmp_rs,

        gaps     => $gaps,

        assembly => $asm_seq_region,
        template => 'assembly/components.tt2',
        );
}

=head2 mapping

=cut

sub mapping :Chained('base') :PathPart('mapping') :Args(2)
            :MyAction('Paged') :PagedResultSetKey('cmp_rs')
{
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

    $c->stash(template => 'assembly/mapping.tt2');

    my $format = $c->request->parameters->{format};
    if ($format and $format eq 'csv') {
        $c->stash(
            template   => 'assembly/mapping_csv.tt2',
            no_page    => 1,
            no_wrapper => 1,
            );
        if (0) {
            # This to display
            $c->res->content_type('text/plain');
        } else {
            # To force download, do this instead:
            my $ref_nm = $seq_region{'Ref'}->name;
            my $alt_nm = $seq_region{'Alt'}->name;
            my $filename = "${ref_nm}__${alt_nm}.csv";
            $c->res->content_type('text/comma-separated-values');
            $c->res->header('Content-Disposition', qq[attachment; filename="$filename"]);
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

        gaps     => $c->request->parameters->{gaps},

        ref_sr   => $seq_region{'Ref'},
        alt_sr   => $seq_region{'Alt'},
        );
}

=head2 assemblies

=cut

sub assemblies :Chained('base') :PathPart('assemblies') :Args() {
    my ( $self, $c, $cmp_sr_id, $asm_cs_id ) = @_;

    unless ($cmp_sr_id) {
        $c->response->status(400);
        $c->response->body("Must supply at least a cmp_seq_region_id");
        $c->detach;
    }

    # Check the params and get the related objects
    $c->forward('/seqregion/by_id',   [ $cmp_sr_id ]);
    $c->forward('/coordsystem/by_id', [ $asm_cs_id ]) if $asm_cs_id;

    my %search;
    $search{'cmp_seq_region_id'       } = $cmp_sr_id;
    $search{'assembly.coord_system_id'} = $asm_cs_id if $asm_cs_id;

    my $asm_rs = $c->stash->{assembly_rs}->search(
        \%search,
        {
            prefetch => [ { 'assembly' => 'coord_system'}, 'component' ],
            order_by => 'assembly.name',
        }
        );

    $c->stash(
        asm_rs => $asm_rs,
        template => 'assembly/assemblies.tt2',
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
