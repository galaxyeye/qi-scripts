#bin 

echo not implemented yet!!!

ps -ef | egrep "php -S(.{20,})"

PIDS=`ps -ef | egrep "php -S(.{20,})" | awk '{print $2}'`
read -a PID_ARRAY <<< "${PIDS}"

echo $PIDS
echo $PID_ARRAY

# cat -etv <<< "$IFS"

ns="ns1.cyberciti.biz	ns2.cyberciti.biz ns3.cyberciti.biz"
read -a dnsservers <<< "${ns}"
for i in "${dnsservers[@]}"
do
   echo "$i"
done

for PID in "${PID_ARRAY[@]}"
do
   echo "killing process $PID"
done

