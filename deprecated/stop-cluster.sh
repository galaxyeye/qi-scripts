#bin 

function pause() {
   read -p "$*"
}

function jps_all() {
   echo '------------------'
   echo 'running process : '
   echo 'master : '
   jps
   echo 'slave1 : '
   rsh slave1 jps
   echo 'slave2 : '
   rsh slave2 jps
   echo 'save3 : '
   rsh slave3 jps
   echo '------------------'
}

jps_all
pause 'Are you sure to stop the cluster?'

echo 'Stop hbase...'
echo `pwd`
~/hbase-0.94.14/bin/stop-hbase.sh

jps_all

tail ~/hbase-0.94.14/logs/hbase-hduser-master-galaxyeye.log | grep error
tail ~/hbase-0.94.14/logs/hbase-hduser-regionserver-galaxyeye.log | grep error
tail ~/hbase-0.94.14/logs/hbase-hduser-zookeeper-galaxyeye.log | grep error

pause 'Press [Enter] key to continue...'

echo 'Stop hadoop...'

~/hadoop-1.2.1/bin/stop-all.sh

jps_all

tail ~/hadoop-1.2.1/logs/hadoop-hduser-namenode-galaxyeye.log | grep error
tail ~/hadoop-1.2.1/logs/hadoop-hduser-datanode-galaxyeye.log | grep error

