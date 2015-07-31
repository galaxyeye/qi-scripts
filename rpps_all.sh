#bin 

BIN=$HOME/bin
SATELLITES=`cat $BIN/conf/satellites`
SATELLITE_USER=`cat $BIN/conf/satellite-user`

for SATELLITE in $SATELLITES; do
  echo $SATELLITE" :"
  rsh $SATELLITE_USER@$SATELLITE $HOME/satellite/bin/satellite pps
done

