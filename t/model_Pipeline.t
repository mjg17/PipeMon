use strict;
use warnings;
use Test::More;
use Test::More;

use PipeMon;

BEGIN { use_ok 'PipeMon::Model::Pipeline' }

my $model = PipeMon->model('Pipeline');
ok($model, 'model');

my $rs = $model->resultset('Job');
ok($rs, 'resultset for Job');

my $sum = $rs->summary( 'analysis_id' );
ok($sum, 'simple summary on analysis_id');
diag("Count: ", $sum->count);

$sum = $rs->summary( 'status' );
ok($sum, 'simple summary on status');
diag("Count: ", $sum->count);

$sum = $rs->summary( 'logic_name' );
ok($sum, 'simple summary on logic_name');
diag("Count: ", $sum->count);

$sum = $rs->summary( qw/analysis_id status/ );
ok($sum, 'compound summary on analysis_id, status');
diag("Count: ", $sum->count);

my $sr_rs = $model->resultset('SeqRegion');
ok($sr_rs, 'resultset for SeqRegion');

my @chrs = $sr_rs->search(
    {
        'coord_system.name' => 'chromosome',
    },
    {
        join => [ 'coord_system' ],
        prefetch => { 'sv_attributes' => 'attrib_type' },
    } 
    )->all();
ok(@chrs, 'search with attrib prefetch');
diag("Count: ", scalar(@chrs));

my @attrs = $chrs[0]->sv_attributes;
ok(@attrs, 'attribs for first chr');
diag("Count: ", scalar(@attrs));

my $code = $attrs[0]->code;
ok($code, 'code for first attr');
diag("Code: ", $code);

my $hidden = $chrs[0]->hidden;
ok(defined($hidden), 'hidden is defined');

done_testing();
