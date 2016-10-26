#bin 

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

 . "$bin"/detect-env.sh

$HOME/bin/rpps_all.sh

echo 'Stop satellites...'

for SATELLITE in $SATELLITES; do
  SATELLITE_HOME="~/qiwur-satellite"
  SATELLITE_BIN=$SATELLITE_HOME/bin
  MONITOR_LOG_DIR=$SATELLITE_HOME/logs
  MONITOR_LOG_OUT=$SATELLITE_HOME/logs/monitor.out

  EXEC_CALL=("$RSH" "$SATELLITE_USER@$SATELLITE" "$SATELLITE_BIN/monitor stop > $MONITOR_LOG_OUT &")

  echo
  echo $SATELLITE" :"
  echo "${EXEC_CALL[@]}"
  exec "${EXEC_CALL[@]}" &
done

$HOME/bin/rpps_all.sh

