#bin

BIN=$HOME"/bin"
SLAVES=`cat $BIN/conf/slaves`
SLAVE_USER=`cat $BIN/conf/slave-user`

# if no args specified, show usage
if [ $# = 0 ]; then
  echo "usage: rrm_slave.sh FILE"
  echo "rm all file or directory on the slave hosts"
  exit 1
fi

FILE=$1

for SLAVE in $SLAVES; do
  echo $SLAVE" :"
  rsh $SLAVE_USER@$SLAVE rm -rf $FILE
done

