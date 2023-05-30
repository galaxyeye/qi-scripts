#bin

# environment
BIN=$HOME"/bin"
DEV_HOSTNAME_FILE="$BIN/conf/devs"

MASTER="master"

# script config
SCENT_HOME=$HOME"/workspace/scent-1.10.x"
SCENT_VERSION=`cat $SCENT_HOME/VERSION`

if ! grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  echo "this script must run from deploy machine"
  exit 1
fi

if [ $# = 0 ]; then
  echo "sync-scent.sh : usage: sync-scent.sh [LOCAL|JOB]"
  exit 1
fi

SYNC_TYPE=$1

EXCLUDE_FILES=$HOME"/bin/conf/exclude-list.txt"

SOURCE="$SCENT_HOME/scent-distribution/target/scent-distribution-$SCENT_VERSION-job.jar"
if [ $SYNC_TYPE = "LOCAL" ]; then
  SOURCE="$SCENT_HOME/scent-distribution/target/scent-distribution-$SCENT_VERSION"
fi

DESTINATION="vincent@$MASTER:~/scent-$SCENT_VERSION/"

if [ -e "$SOURCE" ]; then
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES "$SCENT_HOME/bin" $DESTINATION
else
  echo "$SOURCE does not exist"
  exit 1
fi

