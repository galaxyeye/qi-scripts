#bin

BIN=$HOME"/bin"
MASTER=`cat $BIN/conf/master`
SLAVES=`cat $BIN/conf/slaves`

MASTER_USER=`cat $BIN/conf/master-user`
SLAVE_USER=`cat $BIN/conf/slave-user`

if [ $# = 0 ]; then
  DIR="~"
else
  DIR=$1
fi

rsh $MASTER_USER@$MASTER ls -l $DIR

for SLAVE in $SLAVES; do
  echo $SLAVE" :"
  rsh $SLAVE_USER@$SLAVE ls -l $DIR
done

