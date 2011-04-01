use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::Job;

ok( request('/job')->is_success, 'Request should succeed' );
done_testing();
