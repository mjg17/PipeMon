use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::CoordSystem;

ok( request('/coordsystem')->is_success, 'Request should succeed' );
done_testing();
