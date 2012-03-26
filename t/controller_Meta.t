use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::Meta;

ok( request('/meta')->is_success, 'Request should succeed' );
done_testing();
