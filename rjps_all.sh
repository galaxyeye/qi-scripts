#bin 

BIN=$HOME"/bin"
MASTER=`cat $BIN/conf/master`
SLAVES=`cat $BIN/conf/slaves`

MASTER_USER=`cat $BIN/conf/master-user`
SLAVE_USER=`cat $BIN/conf/slave-user`

echo
echo $MASTER" : "
rsh $MASTER_USER@$MASTER jps | grep -v "Jps"

for SLAVE in $SLAVES; do
  echo
  echo $SLAVE" : "
  rsh $SLAVE_USER@$SLAVE jps | grep -v "Jps"
  sleep 1
done

