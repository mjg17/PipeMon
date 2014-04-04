use strict;
use warnings;
use Test::More;
use Test::More;

BEGIN { use_ok 'PipeMon::Model::PipeForSpecies' }
BEGIN { use_ok 'PipeMon::Schema::Pipeline' }

my $connect_info = PipeMon::Model::PipeForSpecies->config->{connect_info};
diag "connecting schema to ".$connect_info."\n";
my $schema = PipeMon::Schema::Pipeline->connect( $connect_info );
#
my @sources = $schema->sources();
ok( scalar @sources > 0, 'found schema sources :-  '.join(", ",@sources) );

done_testing();
