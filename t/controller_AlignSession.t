use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::AlignSession;

ok( request('/alignsession')->is_success, 'Request should succeed' );
done_testing();
