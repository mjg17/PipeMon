# Run from PipeMon home

/software/perl-5.8.8/bin/dbicdump \
    -o dump_directory=./lib \
    PipeMon::Schema::PipeQueue \
    'dbi:mysql:database=pipe_queue;host=otterlive;port=3324' ottro

./script/pipemon_create.pl model PipeQueue DBIC::Schema PipeMon::Schema::PipeQueue
