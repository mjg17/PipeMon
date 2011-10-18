use strict;
use warnings;
use Test::More;


use Catalyst::Test 'PipeMon';
use PipeMon::Controller::SeqRegion;

ok( request('/mouse/loutre/seq_sets')->is_success, 'Request should succeed' );
# FIXME: lookup an id
ok( request('/mouse/loutre/seq_region/id/40618')->is_success, 'Request should succeed' );
ok( request('/mouse/loutre/seq_region/name/chr1-02')->is_success, 'Request should succeed' );
ok( request('/mouse/loutre/seq_region/name/1/chromosome/NCBIM36')->is_success, 'Request should succeed' );
ok( request('/mouse/loutre/seq_region/name/contig:none:AC117576.11.1.200174')->is_success, 'Request should succeed' );

done_testing();
