package PipeMon::Schema::Pipeline::ResultSet::SimpleFeature;

use Moose;
extends 'DBIx::Class::ResultSet';
with    'PipeMon::Schema::Pipeline::ResultSetRole::FeatureSummary';

1;
