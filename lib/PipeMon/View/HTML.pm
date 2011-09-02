package PipeMon::View::HTML;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(

    # Set the location for TT files
    INCLUDE_PATH => [
        PipeMon->path_to( 'root', 'src' ),
    ],
    TIMER              => 0,
    # This is your wrapper template located in the 'root/src'
    WRAPPER =>     'xhtml_wrapper.tt2',
    # Some common macros
    PRE_PROCESS => 'common.tt2',
    render_die => 1,
);

=head1 NAME

PipeMon::View::HTML - TT View for PipeMon

=head1 DESCRIPTION

TT View for PipeMon.

=head1 SEE ALSO

L<PipeMon>

=head1 AUTHOR

Michael Gray

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
