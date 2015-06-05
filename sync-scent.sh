#bin

# environment
DEV_HOSTNAME="regulus"
MASTER="master"
SLAVES="slave1 slave2 slave3"

# script config
SCENT_VERSION=1.0.0
SCENT_HOME=$HOME"/workspace/qiwur-scent-$SCENT_VERSION-src"

if [ `hostname` != "$DEV_HOSTNAME" ]; then
  echo "this script must run from deploy machine"
  exit 1
fi

if [ $# = 0 ]; then
  echo "sync-scent.sh : usage: sync-scent.sh [LOCAL|JOB]"
  exit 1
fi

SYNC_TYPE=$1

EXCLUDE_FILES=$HOME"/bin/exclude-list.txt"

SOURCE="$SCENT_HOME/scent-distribution/target/scent-distribution-$SCENT_VERSION-job.jar"
if [ $SYNC_TYPE = "LOCAL" ]; then
  SOURCE="$SCENT_HOME/scent-distribution/target/scent-distribution-$SCENT_VERSION"
fi

DESTINATION="hduser@$MASTER:~/scent-$SCENT_VERSION"

if [ -e "$SOURCE" ]; then
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES "$SCENT_HOME/bin" $DESTINATION
else
  echo "$SOURCE does not exist"
  exit 1
fi

