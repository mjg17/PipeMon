use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::SeqRegion;

ok( request('/seqregion')->is_success, 'Request should succeed' );
done_testing();
