#bin 

echo 'running process : '
echo 
echo 'master : '
df -h
echo
echo 'slave1 : '
rsh slave1 df -h
echo
echo 'slave2 : '
rsh slave2 df -h
echo
echo 'save3 : '
rsh slave3 df -h
