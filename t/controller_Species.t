use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::Species;

ok( request('/species')->is_success, 'Request should succeed' );
done_testing();
