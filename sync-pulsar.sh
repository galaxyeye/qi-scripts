#bin

# environment
BIN=$HOME"/bin"
DEV_HOSTNAME_FILE="$BIN/conf/devs"

MASTER="master"

# script config
PULSAR_HOME=$HOME"/workspace/pulsar-1.10.x"
PULSAR_VERSION=`cat $PULSAR_HOME/VERSION`

if ! grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  echo "this script must run from deploy machine"
  exit 1
fi

if [ $# = 0 ]; then
  echo "sync-pulsar.sh : usage: sync-pulsar.sh [PROJ|JAR]"
  exit 1
fi

SYNC_TYPE=$1

EXCLUDE_FILES=$HOME"/bin/conf/exclude-list.txt"

SOURCE="$SPULSAR_HOME/pulsar-1.10.x/target/pulsar-$PULSAR_VERSION.jar"
if [ $SYNC_TYPE = "PROJ" ]; then
  SOURCE="$PULSAR_HOME"
fi

DESTINATION="vincent@$MASTER:~/pulsar-$PULSAR_VERSION"

echo "rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION"

if [ -e "$SOURCE" ]; then
  echo "rsync ..."
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES "$PULSAR_HOME/bin" $DESTINATION
else
  echo "$SOURCE does not exist"
  exit 1
fi

