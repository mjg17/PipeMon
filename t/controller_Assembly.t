use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::Assembly;

# FIXME: look up the ids!
ok( request('/human/pipe/components/55875/3')->is_success, 'Request should succeed' );
ok( request('/human/loutre/mapping/58212/58217')->is_success, 'Request should succeed' );

done_testing();
