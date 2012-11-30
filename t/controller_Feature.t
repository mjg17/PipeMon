use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::Feature;

ok( request('/feature')->is_success, 'Request should succeed' );
done_testing();
