package PipeMon::Schema::Pipeline::Result::AssemblyRank;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

__PACKAGE__->table("assembly");

# Cut'n'paste from Assembly.pm

__PACKAGE__->add_columns(
    "rank", { data_type => "INT" },
    );

# do not attempt to deploy() this view
__PACKAGE__->result_source_instance->is_virtual(1);

__PACKAGE__->result_source_instance->view_definition(q[
    SELECT
           s.rank
      FROM (SELECT
                   @row := @row+1 'rank',
                   cmp_seq_region_id
              FROM
                   assembly,
                   (SELECT @row := 0) r
             WHERE
                   asm_seq_region_id = ?
             ORDER BY asm_start
           ) s
     WHERE
           cmp_seq_region_id = ?
    ]);

1;
