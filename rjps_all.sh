#bin 

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
