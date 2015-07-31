#bin 

BIN=$HOME/bin
SATELLITES=`cat $BIN/conf/satellites`
SATELLITE_USER=`cat $BIN/conf/satellite-user`

SATELLITE_HOME=$HOME/satellite
SATELLITE_LOG=$SATELLITE_HOME/logs
SATELLITE_OUTPUT=$SATELLITE_OUTPUT/output

cd $SATELLITE_HOME

echo -n 'Are you sure to clear satellite logs?N'
#read command
#if [ $command!="Y" ] && [ $command!="y" ] ; then
#  $command = "N"
#  echo "Press Y/y to comfirm"
#  exit 0
#if

echo 'Clear satellite logs...'

for SATELLITE in $SATELLITES; do
  echo $SATELLITE" :"
  rsh $SATELLITE_USER@$SATELLITE find $SATELLITE_LOG $SATELLITE_OUTPUT -mtime +2 -a -type f -print -delete
done

for SATELLITE in $SATELLITES; do
  echo $SATELLITE" :"
  rsh $SATELLITE_USER@$SATELLITE ls -l $SATELLITE_LOG $SATELLITE_OUTPUT
done

