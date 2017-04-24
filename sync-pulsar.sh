#bin

# environment
BIN=$HOME"/bin"
DEV_HOSTNAME_FILE="$BIN/conf/devs"

MASTER="master"

# script config
PULSAR_HOME=$HOME"/workspace/warps-pulsar"
PULSAR_VERSION=`cat $PULSAR_HOME/VERSION`

if ! grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  echo "this script must run from deploy machine"
  exit 1
fi

if [ $# = 0 ]; then
  echo "sync-pulsar.sh : usage: sync-pulsar.sh [LOCAL|JOB]"
  exit 1
fi

SYNC_TYPE=$1

EXCLUDE_FILES=$HOME"/bin/conf/exclude-list.txt"

SOURCE="$PULSAR_HOME/pulsar-distribution/target/pulsar-distribution-$PULSAR_VERSION-job.jar"
if [ $SYNC_TYPE = "LOCAL" ]; then
  SOURCE="$PULSAR_HOME/pulsar-distribution/target/pulsar-distribution-$PULSAR_VERSION"
fi

DESTINATION="hduser@$MASTER:~/pulsar-$PULSAR_VERSION/"

if [ -e "$SOURCE" ]; then
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES "$PULSAR_HOME/bin" $DESTINATION
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES "$PULSAR_HOME/conf" $DESTINATION
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES "$PULSAR_HOME/VERSION" $DESTINATION
else
  echo "$SOURCE does not exist"
  exit 1
fi

