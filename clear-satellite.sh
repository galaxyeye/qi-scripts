#bin 

function pause() {
   read -p "$*"
}

SATELLITE_HOME=~/satellite
SATELLITE_BIN=$SATELLITE_HOME/bin
SATELLITE_LOG=$SATELLITE_HOME/logs
SATELLITE_OUTPUT=$SATELLITE_HOME/output
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

function rdelete_old_logs() {
   rsh $1 find $SATELLITE_LOG $SATELLITE_OUTPUT -mtime +2 -a -type f -print -delete
}

echo -n 'Are you sure to clear satellite logs?N'
#read command
#if [ $command!="Y" ] && [ $command!="y" ] ; then
#  $command = "N"
#  echo "Press Y/y to comfirm"
#  exit 0
#if

echo 'Clear satellite logs...'

rdelete_old_logs slave1
rdelete_old_logs slave2
rdelete_old_logs slave3

pps_all
