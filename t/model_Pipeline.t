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

my $sum = $rs->summary( 'status' );
ok($sum, 'simple summary on status');
diag("Count: ", $sum->count);

my $sum = $rs->summary( 'logic_name' );
ok($sum, 'simple summary on logic_name');
diag("Count: ", $sum->count);

done_testing();
