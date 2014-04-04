use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::InputId;

ok( request('/mouse/pipe/input_id/contig:none:CT009658.7.1.190153:1:190153:1')->is_success,
    'Request should succeed' );
done_testing();
