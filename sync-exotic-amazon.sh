#bin

# environment
BIN=$HOME"/bin"
DEV_HOSTNAME_FILE="$BIN/conf/devs"

CRAWLER1="crawler1"

# script config
EXOTIC_AMAZON_HOME=$HOME"/workspace/exotic-amazon-pro"
EXOTIC_AMAZON_VERSION=`cat $EXOTIC_AMAZON_HOME/VERSION`

if ! grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  echo "this script must run from deploy machine"
  exit 1
fi

if [ $# = 0 ]; then
  echo "sync-exotic-amazon.sh : usage: sync-exotic-amazon.sh [PROJ|JAR]"
  exit 1
fi

SYNC_TYPE=$1

EXCLUDE_FILES=$HOME"/bin/conf/exclude-list.txt"

SOURCE="$EXOTIC_AMAZON_HOME/"
DESTINATION="vincent@$CRAWLER1:~/exotic-amazon-pro/$EXOTIC_AMAZON_VERSION"
if [ $SYNC_TYPE = "JAR" ]; then
  SOURCE="$EXOTIC_AMAZON_HOME/target/exotic-amazon-$EXOTIC_AMAZON_VERSION.jar"
  DESTINATION="vincent@$CRAWLER1:~/exotic-amazon-pro/$EXOTIC_AMAZON_VERSION/target"
fi

# ssh vincent@$CRAWLER1 mkdir -p $DESTINATION

echo "rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION"

if [ -e "$SOURCE" ]; then
  echo "rsync ..."
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION
  # rsync --update -raz --progress --exclude-from $EXCLUDE_FILES "$EXOTIC_AMAZON_HOME/bin" $DESTINATION
else
  echo "$SOURCE does not exist"
  exit 1
fi

