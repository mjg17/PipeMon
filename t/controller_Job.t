use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::Job;

ok( request('/human/pipe/jobs')->is_success, 'Request should succeed' );
ok( request('/human/pipe/job_summary')->is_success, 'Request should succeed' );
ok( request('/human/pipe/job_summary/status,logic_name')->is_success, 'Request should succeed' );

# Jobs are transient - fix me to skip or lookup an id as appropriate
ok( request('/human/pipe/job/11681056')->is_success, 'Request should succeed' );

done_testing();
