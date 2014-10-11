#bin 

function pause() {
   read -p "$*"
}

function jps_all() {
   echo '------------------'
   echo 'running process : '
   echo
   echo 'master : '
   jps
   echo
   echo 'slave1 : '
   rsh slave1 jps
   echo
   echo 'slave2 : '
   rsh slave2 jps
   echo
   echo 'save3 : '
   rsh slave3 jps
   echo '------------------'
}

jps_all
# echo -n 'Are you sure to start the cluster?N'
# read cmd
# if [ $cmd != "Y" ]; then
#   $cmd = "N"
#   echo "Press Y to comfirm"
#   exit 0
# if

echo 'Starting hadoop...'
~/hadoop-1.2.1/bin/start-all.sh

jps_all

tail ~/hadoop-1.2.1/logs/hadoop-hduser-namenode-galaxyeye.log | grep error
tail ~/hadoop-1.2.1/logs/hadoop-hduser-datanode-galaxyeye.log | grep error

pause 'Press [Enter] key to continue...'
echo 'Starting hbase...'
echo `pwd`
~/hbase-0.94.14/bin/start-hbase.sh

jps_all

tail ~/hbase-0.94.14/logs/hbase-hduser-master-galaxyeye.log | grep error
tail ~/hbase-0.94.14/logs/hbase-hduser-regionserver-galaxyeye.log | grep error
tail ~/hbase-0.94.14/logs/hbase-hduser-zookeeper-galaxyeye.log | grep error

