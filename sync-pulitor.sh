#bin

# environment
BIN=$HOME"/bin"
DEV_HOSTNAME_FILE="$BIN/conf/devs"

MASTER="master"

# script config
PULITOR_HOME=$HOME"/workspace/warps-pulitor"
PULITOR_VERSION=`cat $PULITOR_HOME/VERSION`

if ! grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  echo "this script must run from deploy machine"
  exit 1
fi

EXCLUDE_FILES=$HOME"/bin/conf/exclude-list.txt"
OPTIONS=(--update -raz --progress --exclude-from $EXCLUDE_FILES)

SOURCE="$PULITOR_HOME/pulitor-mapr/target/pulitor-mapr-$PULITOR_VERSION-job.jar"
DESTINATION="hduser@$MASTER:~/pulitor-$PULITOR_VERSION/"
if [ -e "$SOURCE" ]; then
  rsync ${OPTIONS[@]} $SOURCE $DESTINATION
  rsync ${OPTIONS[@]} "$PULITOR_HOME/bin" $DESTINATION
  rsync ${OPTIONS[@]} "$PULITOR_HOME/conf" $DESTINATION
  rsync ${OPTIONS[@]} "$PULITOR_HOME/VERSION" $DESTINATION
else
  echo "$SOURCE does not exist"
  exit 1
fi

