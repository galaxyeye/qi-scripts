#bin

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

. "$bin"/detect-env.sh

$SATELLITE_HOME/bin/monitor pps | grep -v "grep phantomjs"

