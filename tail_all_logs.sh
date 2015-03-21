#bin

HADOOP_HOME=~/hadoop-2.5.2
HBASE_HOME=~/hbase-0.94.24
NUTCH_HOME=~/nutch-2.3.0/local
HOST_NAME=`hostname`

function tail_grep() {
  FILENAME=$1
  if [ -f "$FILENAME" ]; then
      echo 
      echo "-------------------------------------------------------------------"
      echo "errors in $1 : "
      echo ""
      tail $@ | grep -i '[error|fatal|warn|info]'
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

tail_grep $NUTCH_HOME/logs/hadoop.log

