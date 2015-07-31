#bin 

BIN=$HOME/bin
SATELLITE_HOME=$HOME/satellite
SATELLITE_BIN=$SATELLITE_HOME/bin
SATELLITE=$SATELLITE_BIN/satellite

SATELLITES=`cat $BIN/conf/satellites`
SATELLITE_USER=`cat $BIN/conf/satellite-user`

$HOME/bin/rpps_all.sh

echo 'Stop satellites...'

for SATELLITE in $SATELLITES; do
  echo "Stop "$SATELLITE"..."
  rsh $SATELLITE_USER@$SATELLITE $HOME/satellite/bin/satellite stop > /dev/null &
  sleep 3
done

$HOME/bin/rpps_all.sh

