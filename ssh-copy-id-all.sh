#bin 

REMOTE_USER=`whoami`

if [ $# -gt 1 ]; then
    echo "Usage: ssh-copy-id-all [user]"
    exit 0
elif [ $# -eq 1 ]; then
    REMOTE_USER=$1
fi

BIN=$HOME"/bin"
MASTER=`cat $BIN/conf/master`
SLAVES=`cat $BIN/conf/slaves`
SATELLITES=`cat $BIN/conf/satellites`
HOST_NAMES=`cat $BIN/conf/host_names`

ALL_HOSTS="$MASTER
$SLAVES
$SATELLITES
$HOST_NAMES"

for HOST in $ALL_HOSTS; do
  # echo "$REMOTE_USER@$HOST"
  ssh-copy-id $REMOTE_USER@$HOST
done

