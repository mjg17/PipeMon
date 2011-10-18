use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::Species;

ok( request('/human/index')->is_success, 'Request should succeed' );
ok( request('/mouse/index')->is_success, 'Request should succeed' );
done_testing();
