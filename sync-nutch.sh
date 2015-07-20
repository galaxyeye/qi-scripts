#bin

# environment
DEV_HOSTNAME="regulus"
MASTER="master"
SLAVES="slave1 slave2 slave3"

# script config
NUTCH_VERSION=2.3.0
NUTCH_HOME=$HOME"/workspace/qiwur-nutch-$NUTCH_VERSION"

if [ `hostname` != "$DEV_HOSTNAME" ]; then
  echo "this script must run from deploy machine"
  exit 1
fi

if [ $# = 0 ]; then
  echo "sync-nutch.sh : usage: sync-nutch.sh [LOCAL|JOB]"
  exit 1
fi

SYNC_TYPE=$1

EXCLUDE_FILES=$HOME"/bin/exclude-list.txt"

DESTINATION="hduser@$MASTER:~/nutch-$NUTCH_VERSION"

if [ $SYNC_TYPE = "LOCAL" ]; then
  SOURCE="$NUTCH_HOME/runtime/local"
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION
elif [ $SYNC_TYPE = "JOB" ]; then
  SOURCE="$NUTCH_HOME/runtime/deploy"
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION  
else
  SOURCE="$NUTCH_HOME/runtime/local"
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION
  SOURCE="$NUTCH_HOME/runtime/deploy"
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION  
fi

