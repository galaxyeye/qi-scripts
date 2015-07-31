#bin 

BIN=$HOME"/bin"
MASTER=`cat $BIN/conf/master`
SLAVES=`cat $BIN/conf/slaves`

MASTER_USER=`cat $BIN/conf/master-user`
SLAVE_USER=`cat $BIN/conf/slave-user`

# if no args specified, show usage
if [ $# = 0 ]; then
  echo "usage: rjpkill_all.sh FILE"
  echo "kill all java proceses on the cluster"
  exit 1
fi

EXE=$1

rsh $MASTER_USER@$MASTER $BIN/jpkill.sh -9 $EXE

for SLAVE in $SLAVES; do
  echo $SLAVE" :"
  rsh $SLAVE_USER@$SLAVE $BIN/jpkill.sh -9 $EXE
done

