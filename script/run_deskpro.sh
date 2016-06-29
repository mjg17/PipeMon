export OTTER_HOME=/software/anacode/otter/otter_live
source /software/anacode/otter/otter_live/bin/otter_env.sh
eval $(/software/perl-5.18.2/bin/perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
"$( dirname "$0" )/pipemon_server.pl" -r
