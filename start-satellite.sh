#bin 

SATELLITE_HOME=~/satellite
SATELLITE_BIN=$SATELLITE_HOME/bin
SATELLITE=$SATELLITE_BIN/satellite

cd $SATELLITE_HOME

function rstart_satellite() {
   rsh $1 $SATELLITE start > /dev/null &
}

$HOME/bin/rpps_all.sh
#echo -n 'Are you sure to start satellites?N'
#read command
#if [ $command!="Y" ] && [ $command!="y" ] ; then
#  $command = "N"
#  echo "Press Y/y to comfirm"
#  exit 0
#if

echo 'Starting satellite...'

sleep 3
rstart_satellite satellite
sleep 3
rstart_satellite satellite2
sleep 3
rstart_satellite satellite3
sleep 3
rstart_satellite satellite4
sleep 3
rstart_satellite satellite5
sleep 3
rstart_satellite satellite6

# wait for a while
sleep 3

$HOME/bin/rpps_all.sh

