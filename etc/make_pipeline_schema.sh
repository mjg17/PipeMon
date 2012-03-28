# Run from PipeMon home

/software/perl-5.8.8/bin/dbicdump \
    -o dump_directory=./lib \
    -o constraint='^(job|job_status|analysis|input_id_analysis|seq_region|seq_region_attrib|attrib_type|coord_system|assembly|meta)$' \
    PipeMon::Schema::Pipeline \
    'dbi:mysql:database=pipe_human;host=otterpipe1;port=3322' ottro

./script/pipemon_create.pl model Pipeline DBIC::Schema PipeMon::Schema::Pipeline

# EOF
