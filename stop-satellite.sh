#bin 

function pause() {
   read -p "$*"
}

SATELLITE_HOME=~/satellite
SATELLITE_BIN=$SATELLITE_HOME/bin
SATELLITE=$SATELLITE_BIN/satellite

cd $SATELLITE_HOME

function pps_all() {
   echo '------------------'
   echo 'running process : '
   echo 'slave1 : '
   rsh slave1 $SATELLITE pps
   echo 'slave2 : '
   rsh slave2 $SATELLITE pps
   echo 'save3 : '
   rsh slave3 $SATELLITE pps
   echo '------------------'
}

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

rstop_satellite slave1
rstop_satellite slave2
rstop_satellite slave3

pps_all
