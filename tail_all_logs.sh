#bin

HADOOP_HOME=~/hadoop-2.6.0
HBASE_HOME=~/hbase-0.98.8
NUTCH_HOME=~/nutch-2.3.0/local

function tail_grep() {
  echo ""
  echo "-------------------------------------------------------------------"
  echo "errors in $1 : "
  echo ""
  tail $@ | grep -i '[error|fatal|warn|info]'
}

tail_grep $HADOOP_HOME/logs/hadoop-hduser-namenode-galaxyeye.log
tail_grep $HADOOP_HOME/logs/hadoop-hduser-datanode-galaxyeye.log
tail_grep $HADOOP_HOME/logs/hadoop-hduser-secondarynamenode-galaxyeye.log
tail_grep $HADOOP_HOME/logs/hadoop-hduser-jobtracker-galaxyeye.log
tail_grep $HADOOP_HOME/logs/hadoop-hduser-tasktracker-galaxyeye.log

tail_grep $HBASE_HOME/logs/hbase-hduser-master-galaxyeye.log
tail_grep $HBASE_HOME/logs/hbase-hduser-regionserver-galaxyeye.log
tail_grep $HBASE_HOME/logs/hbase-hduser-zookeeper-galaxyeye.log

tail_grep $NUTCH_HOME/logs/hadoop.log
