#bin 

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

 . "$bin"/detect-env.sh

if [ "`hostname`"!="$MASTER_HOSTNAME" ]; then
  echo "this script must run on hadoop master host"
  exit 1
fi

while true; do
  echo
  echo -n "Selecte daemon : "
  echo "1. start-dfs"
  echo "2. start-yarn"
  echo "3. mr-jobhistory-daemon.sh start historyserver"
  echo "4. start-hbase"
  echo "('q' for quit): "; read cmd;

  if [ ! $cmd ]; then
    $cmd=""
  fi

  if [ "$cmd" == "1" ]; then
    EXEC_CALL="$HADOOP_HOME/sbin/start-dfs.sh"
  elif [ "$cmd" == "2" ]; then
    EXEC_CALL="$HADOOP_HOME/sbin/start-yarn.sh"
  elif [ "$cmd" == "3" ]; then
    EXEC_CALL="$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver"
  elif [ "$cmd" == "4" ]; then
    EXEC_CALL="$HBASE_HOME/bin/start-hbase.sh"
  elif [ "$cmd" == "q" ]; then
    exit 0
  fi

  if [ "$EXEC_CALL" ]; then
    echo "$EXEC_CALL"
    exec $EXEC_CALL
    $WARPS_BIN/rjps_all.sh
  fi
done





