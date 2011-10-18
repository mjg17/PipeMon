use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::PipeQueue;

ok( request('/pipequeue/summary')->is_success, 'Request should succeed' );
done_testing();
