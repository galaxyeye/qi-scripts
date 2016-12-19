#bin

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

 . "$bin"/detect-env.sh

if ! grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  echo "this script must run from deploy machine"
  exit 1
fi

if [ $# = 0 ]; then
  echo "sync-nutch.sh : usage: sync-nutch.sh [LOCAL|JOB|BOTH]"
  exit 1
fi

SYNC_TYPE=$1

NUTCH_VERSION=`cat $NUTCH_HOME/VERSION`
DESTINATION="$MASTER_USER@$MASTER:~/warps-nutch-$NUTCH_VERSION"

if [ $SYNC_TYPE = "LOCAL" ]; then
  SOURCE="$NUTCH_HOME/runtime/local"
  if [ -d $SOURCE ]; then
    rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION
  fi
elif [ $SYNC_TYPE = "JOB" ]; then
  SOURCE="$NUTCH_HOME/runtime/deploy"
  if [ -d $SOURCE ]; then
    rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION
  fi
elif [ $SYNC_TYPE = "BOTH" ]; then
  SOURCE="$NUTCH_HOME/runtime/local"
  if [ -d $SOURCE ]; then
    rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION
  fi
  SOURCE="$NUTCH_HOME/runtime/deploy"
  if [ -d $SOURCE ]; then
    rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION
  fi
fi

