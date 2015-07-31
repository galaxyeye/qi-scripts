#bin 

echo 'Remove satellite...'

rsh hduser@slave1 rm -rf /home/hduser/satellite
rsh hduser@slave2 rm -rf /home/hduser/satellite
rsh hduser@slave3 rm -rf /home/hduser/satellite

sleep 5

echo "Done."
echo

echo "hduser@slave1:~"
rsh hduser@slave1 ls -l /home/hduser/
echo

echo "hduser@slave2:~"
rsh hduser@slave2 ls -l /home/hduser/
echo

echo "hduser@slave3:~"
rsh hduser@slave3 ls -l /home/hduser/
echo

#bin

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

