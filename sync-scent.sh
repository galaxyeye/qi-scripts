#bin 

DEV_HOSTNAME="regulus"
MASTER="master"
SLAVES="slave1 slave2 slave3"

EXCLUDE_FILES=$HOME"/bin/exclude-list.txt"
SOURCE_FILES=$HOME"/workspace/scent/runtime/local/*"

if [ `hostname` != "$DEV_HOSTNAME" ]; then
  echo "this script must run from deploy machine"
  exit 1
fi

rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_FILES hduser@master:~/scent/
rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_FILES hduser@slave2:~/scent/

