package PipeMon::Action::Paged;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Action';

sub BUILD { }

after BUILD => sub {
    my $class = shift;
    my ($args) = @_;

    my $attr = $args->{attributes};

    unless (exists $attr->{PagedResultSetKey}) {
        Catalyst::Exception->throw(
            "Action '$args->{reverse}' requires the PagedResultSetKey(<stash_key>) attribute");
    }
    unless ($attr->{PagedResultSetKey}->[0]) {
        Catalyst::Exception->throw(
            "Action '$args->{reverse}' PagedResultSetKey(<stash_key>) attribute is missing stash_key");
    }
    if (exists $attr->{PagedFocusColumn} and not $attr->{PagedFocusColumn}->[0]) {
        Catalyst::Exception->throw(
            "Action '$args->{reverse}' PagedFocusColumn(<column_name>) attribute is missing column_name");
    }
};

after 'execute' => sub {
    my ( $self, $controller, $c ) = @_;

    return if $c->stash->{no_page};

    my $page  = $c->request->parameters->{page};
    my $limit = $c->request->parameters->{limit} || 20; # config?
    my $focus = $c->request->parameters->{focus};

    my $rs_key    = $c->action->attributes->{PagedResultSetKey}->[0];
    my $plain_rs  = $c->stash->{$rs_key};

    my $focus_col = $c->action->attributes->{PagedFocusColumn}->[0];

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
