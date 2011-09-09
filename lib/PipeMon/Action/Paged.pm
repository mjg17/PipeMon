package PipeMon::Action::Paged;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Action';

after 'execute' => sub {
    my ( $self, $controller, $c ) = @_;

    my $page  = $c->request->parameters->{page};
    my $limit = $c->request->parameters->{limit} || 20; # config?
    my $focus = $c->request->parameters->{focus};

    my $rs_key    = $c->stash->{paged_rs_key};
    my $plain_rs  = $c->stash->{$rs_key};

    my $focus_col = $c->stash->{paged_focus_column};

    if ($focus_col and $focus and not $page) {

        my $i = 0;
        my %focus_map = map { $_ => ++$i } $plain_rs->get_column($focus_col)->all;

        my $rank = $focus_map{$focus};

        if ($rank) {
            $page = int(($rank - 1) / $limit) + 1;
        }
    }

    $page ||= 1;

    my $paged_rs = $plain_rs->search( {}, { page => $page, rows => $limit } );

    $c->stash(
        $rs_key  => $paged_rs,  # replace the plain one
        pager    => $paged_rs->pager,
        focus    => $focus,
        );

};

__PACKAGE__->meta->make_immutable;

1;
