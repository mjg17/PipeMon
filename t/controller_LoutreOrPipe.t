use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::LoutreOrPipe;

# FIXME: check output, or mock up a test controller for this
ok( request('/human/loutre/analyses')->is_success, 'Request should succeed' );
ok( request('/human/pipe/analyses')->is_success, 'Request should succeed' );

done_testing();
