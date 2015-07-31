#bin

# environment
DEV_HOSTNAME="regulus"
MASTER="master"

# script config
DATA_UI_HOME=$HOME"/workspace/qiwur-data-ui"

if [ `hostname` != "$DEV_HOSTNAME" ]; then
  echo "this script must run from deploy machine"
  exit 1
fi

EXCLUDE_FILES=$HOME"/bin/exclude-list.txt"

SOURCE=$DATA_UI_HOME
DESTINATION="www-data@$MASTER:~/"

rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION

