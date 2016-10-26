#bin

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

 . "$bin"/detect-env.sh

HOST_NAME=`hostname`

function tail_grep() {
  FILENAME=$1
  if [ -f "$FILENAME" ]; then
      echo
      echo "errors in $1 : "
      tail $@ | egrep -i 'error|fatal|warn'
      echo "-------------"
      echo "info in $1 : "
      tail $@ | egrep -i 'info'
  fi
}

tail_grep $HADOOP_HOME/logs/hadoop-hduser-namenode-"$HOST_NAME".log
tail_grep $HADOOP_HOME/logs/hadoop-hduser-secondarynamenode-"$HOST_NAME".log
tail_grep $HADOOP_HOME/logs/hadoop-hduser-tasktracker-"$HOST_NAME".log
tail_grep $HADOOP_HOME/logs/hadoop-hduser-datanode-"$HOST_NAME".log
tail_grep $HADOOP_HOME/logs/hadoop-hduser-jobtracker-"$HOST_NAME".log

tail_grep $HBASE_HOME/logs/hbase-hduser-master-"$HOST_NAME".log
tail_grep $HBASE_HOME/logs/hbase-hduser-regionserver-"$HOST_NAME".log
tail_grep $HBASE_HOME/logs/hbase-hduser-zookeeper-"$HOST_NAME".log

