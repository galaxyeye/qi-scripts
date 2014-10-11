#bin 

echo 'running process : '
echo 
echo 'master : '
free -m
echo
echo 'slave1 : '
rsh slave1 free -m
echo
echo 'slave2 : '
rsh slave2 free -m
echo
echo 'save3 : '
rsh slave3 free -m
