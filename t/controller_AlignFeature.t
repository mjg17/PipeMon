use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::AlignFeature;

ok( request('/alignfeature')->is_success, 'Request should succeed' );
done_testing();
