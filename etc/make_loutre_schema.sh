# Run from PipeMon home

# NB this adds loutre tables into PipeMon::Schema::Pipeline to avoid having two schemas.

/software/perl-5.8.8/bin/dbicdump \
    -o dump_directory=./lib \
    -o constraint='^(align_session|align_stage|tmp_align|tmp_mask)$' \
    PipeMon::Schema::Pipeline \
    'dbi:mysql:database=loutre_human;host=otterlive;port=3324' ottro

./script/pipemon_create.pl model Pipeline DBIC::Schema PipeMon::Schema::Pipeline

# EOF
