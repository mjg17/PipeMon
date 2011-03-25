use strict;
use warnings;
use Test::More;

use PipeMon;

my $model = PipeMon->model('Otter::MFetcher');
ok($model, 'model');

ok($model->species_dat_filename('/nfs/WWWdev/SANGER_docs/data/otter/54/species.dat'), 'set species_dat_filename');

my $dataset_h = $model->dataset_hash;
ok($dataset_h, 'dataset_hash');

done_testing();
