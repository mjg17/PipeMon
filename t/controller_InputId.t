use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::InputId;

ok( request('/inputid')->is_success, 'Request should succeed' );
done_testing();
