package PipeMon::Model::PipeForSpecies;
use Moose;
use namespace::autoclean;

use Data::Dumper;

extends 'Catalyst::Model::DBIC::Schema';
with 'Catalyst::Component::InstancePerContext';

__PACKAGE__->config(
    schema_class => 'PipeMon::Schema::Pipeline',
    connect_info => 'dbi:mysql:pipe_not_set', # to stop complaints at startup
    );

sub build_per_context_instance {
    my ($self, $c) = @_;

    my $new = bless({ %$self }, ref($self));

    # By the time this is used, the stash should already contain a dataset
    #
    my $dataset = $c->stash->{dataset};
    my $opt_str = $dataset->satellite_dba_options('pipeline_db_head');

    # Duplication with Bio::Otter::SpeciesDat::DataSet
    my %options;
    {
        %options = eval $opt_str;
    }
    $c->log->debug( %options ? join(',', %options) : "NO PIPELINE" );

    my $dsn = sprintf("dbi:mysql:host=%s;port=%s;database=%s",
                      $options{-host}, $options{-port}, $options{-dbname});

    $new->schema($self->schema->connect( $dsn, $options{-user} ));
    return $new;
} 

=head1 NAME

PipeMon::Model::PipeForSpecies - Catalyst Model

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
