use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::CoordSystem;

ok( request('/zebrafish/loutre/coord_systems')->is_success, 'Request should succeed' );
ok( request('/zebrafish/loutre/coord_system/name/contig')->is_success, 'Request should succeed' );
ok( request('/zebrafish/loutre/coord_system/name/chromosome/OtterArchive')->is_success, 'Request should succeed' );
ok( request('/zebrafish/loutre/coord_system/id/1')->is_success, 'Request should succeed' );

done_testing();
