PIPEMON="$HOME/HTTPD/pipe_mon"
cd "$PIPEMON"
export OTTER_HOME=/software/anacode/otter/otter_live
source /software/anacode/otter/otter_live/bin/otter_env.sh
eval $(/software/perl-5.18.2/bin/perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
echo $PERL5LIB
script/pipemon_server.pl > /tmp/pipemon.out 2> /tmp/pipemon.err
