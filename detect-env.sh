#bin

export JAVE_HOME=/usr/lib/jvm/java-8-sun/

export MASTER_HOSTNAME=galaxyeye

export WARPS_MACHINE_HOME=`cd && pwd`

export WARPS_BIN=$WARPS_MACHINE_HOME"/bin"

export DEV_HOSTNAME_FILE="$WARPS_BIN/conf/devs"

export MASTER=`cat $WARPS_BIN/conf/master`
export SLAVES=`cat $WARPS_BIN/conf/slaves`
export SATELLITES=`cat $WARPS_BIN/conf/satellites`

export MASTER_USER=`cat $WARPS_BIN/conf/master-user`
export SLAVE_USER=`cat $WARPS_BIN/conf/slave-user`
export SATELLITE_USER=`cat $WARPS_BIN/conf/satellite-user`

export EXCLUDE_FILES=$WARPS_BIN"/conf/exclude-list.txt"

IS_DEV_HOST=false
if grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  IS_DEV_HOST=true
fi
export IS_DEV_HOST=$IS_DEV_HOST

if $IS_DEV_HOST; then
  export SATELLITE_HOME=$WARPS_MACHINE_HOME/workspace/qiwur-satellite
  export NUTCH_HOME=$WARPS_MACHINE_HOME/workspace/qiwur-nutch
  export SCENT_HOME=$WARPS_MACHINE_HOME/workspace/qiwur-scent
  export HADOOP_HOME=$WARPS_MACHINE_HOME/program/hadoop-2.5.2
  export HBASE_HOME=$WARPS_MACHINE_HOME/program/hbase-0.98.8
else
  export SATELLITE_HOME=$WARPS_MACHINE_HOME/qiwur-satellite
  export NUTCH_HOME=$WARPS_MACHINE_HOME/qiwur-nutch
  export SCENT_HOME=$WARPS_MACHINE_HOME/qiwur-scent
  export HADOOP_HOME=$WARPS_MACHINE_HOME/hadoop-2.5.2
  export HBASE_HOME=$WARPS_MACHINE_HOME/hbase-0.98.8
fi

export RSH=/usr/bin/rsh

