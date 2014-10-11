#bin

function tail_grep() {
  echo ""
  echo "-------------------------------------------------------------------"
  echo "errors in $1 : "
  echo ""
  tail $@ | grep -i '[error|fatal|warn|info]'
}

tail_grep ~/hadoop-1.2.1/logs/hadoop-hduser-namenode-galaxyeye.log
tail_grep ~/hadoop-1.2.1/logs/hadoop-hduser-datanode-galaxyeye.log
tail_grep ~/hadoop-1.2.1/logs/hadoop-hduser-secondarynamenode-galaxyeye.log
tail_grep ~/hadoop-1.2.1/logs/hadoop-hduser-jobtracker-galaxyeye.log
tail_grep ~/hadoop-1.2.1/logs/hadoop-hduser-tasktracker-galaxyeye.log

tail_grep ~/hbase-0.94.14/logs/hbase-hduser-master-galaxyeye.log
tail_grep ~/hbase-0.94.14/logs/hbase-hduser-regionserver-galaxyeye.log
tail_grep ~/hbase-0.94.14/logs/hbase-hduser-zookeeper-galaxyeye.log

tail_grep ~/nutch-2.2.1/local/logs/hadoop.log
