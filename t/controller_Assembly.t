use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::Assembly;

ok( request('/assembly')->is_success, 'Request should succeed' );
done_testing();
