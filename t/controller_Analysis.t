use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::Analysis;

ok( request('/human/pipe/analyses')->is_success, 'Request should succeed' );
ok( request('/human/pipe/analysis/1')->is_success, 'Request should succeed' );
ok( request('/human/pipe/analysis/Uniprot_raw')->is_success, 'Request should succeed' );

done_testing();
