#bin

# environment
BIN=$HOME"/bin"
DEV_HOSTNAME_FILE="$BIN/conf/devs"

MASTER="master"

# script config
DATA_UI_HOME=$HOME"/workspace/monitor-ui"

if ! grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  echo "this script must run from deploy machine"
  exit 1
fi

EXCLUDE_FILES=$HOME"/bin/conf/exclude-list.txt"

SOURCE=$DATA_UI_HOME
DESTINATION="www-data@$MASTER:~/"

rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION

