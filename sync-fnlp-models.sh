#bin

# environment
BIN=$HOME"/bin"
DEV_HOSTNAME_FILE="$BIN/conf/devs"

MASTER="master"
SLAVES="slave1 slave2 slave3"

# script config
FNLP_VERSION=2.1
FNLP_HOME=$HOME"/workspace/fnlp-$FNLP_VERSION-src"


if ! grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  echo "this script must run from deploy machine"
  exit 1
fi

EXCLUDE_FILES=$HOME"/bin/exclude-list.txt"
SOURCE="$FNLP_HOME/models"
DESTINATION="hduser@master:/tmp/"
DESTINATION2="hduser@slave1:/tmp/"
DESTINATION3="hduser@slave2:/tmp/"
DESTINATION4="hduser@slave3:/tmp/"

if [ -e "$SOURCE" ]; then
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION2
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION3
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION4
else
  echo "$SOURCE does not exist"
  exit 1
fi

