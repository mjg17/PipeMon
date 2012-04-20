package PipeMon::Schema::Pipeline::ResultSet::ProteinAlignFeature;

use Moose;
extends 'DBIx::Class::ResultSet';
with    'PipeMon::Schema::Pipeline::ResultSetRole::AlignFeatureSummary';

1;
