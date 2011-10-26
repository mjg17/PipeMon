package PipeMon::Model::LoutreForSpecies;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model::DBIC::Schema';
with 'Catalyst::Component::InstancePerContext';

has dbc => ( is => 'rw' );

__PACKAGE__->config(
    schema_class => 'PipeMon::Schema::Pipeline',
    connect_info => 'dbi:mysql:loutre_not_set', # to stop complaints at startup
    );

sub build_per_context_instance {
    my ($self, $c) = @_;

    my $new = bless({ %$self }, ref($self));

    my $dataset = $c->stash->{dataset};
    my $dbc = $dataset->otter_dba->dbc;
    $new->dbc($dbc);

    # By the time this is used, the stash should already contain a dataset
    #
    my $connect_sub = sub {

        $dbc->connect;
        return $dbc->db_handle;
    };

    $new->schema($self->schema->connect( $connect_sub ));
    return $new;
}

sub DEMOLISH {
    my ($self) = @_;
    $self->dbc->disconnect_if_idle;
}

=head1 NAME

PipeMon::Model::LoutreForSpecies - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

Michael Gray

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
