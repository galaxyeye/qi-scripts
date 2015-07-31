#bin 

MASTER=`cat $BIN/conf/master`
SLAVES=`cat $BIN/conf/slaves`

MASTER_USER=`cat $BIN/conf/master-user`
SLAVE_USER=`cat $BIN/conf/slave-user`

rsh $MASTER_USER@$MASTER jps

for SLAVE in $SLAVES; do
  echo $SLAVE" :"
  rsh $SLAVE_USER@$SLAVE jps
done

