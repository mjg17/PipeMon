use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::LoutreOrPipe;

ok( request('/loutreorpipe')->is_success, 'Request should succeed' );
done_testing();