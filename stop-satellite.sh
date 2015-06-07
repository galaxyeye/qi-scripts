#bin 

function pause() {
   read -p "$*"
}

SATELLITE_HOME=~/satellite
SATELLITE_BIN=$SATELLITE_HOME/bin
SATELLITE=$SATELLITE_BIN/satellite

cd $SATELLITE_HOME

$HOME/bin/rpps_all.sh

function rstop_satellite() {
   # cd $SATELLITE_HOME
   rsh $1 $SATELLITE stop
}

echo -n 'Are you sure to start satellites?N'
#read command
#if [ $command!="Y" ] && [ $command!="y" ] ; then
#  $command = "N"
#  echo "Press Y/y to comfirm"
#  exit 0
#if

echo 'Stop satellite...'

rstop_satellite satellite
rstop_satellite satellite2
rstop_satellite satellite3
rstop_satellite satellite4
rstop_satellite satellite5
rstop_satellite satellite6

$HOME/bin/rpps_all.sh

