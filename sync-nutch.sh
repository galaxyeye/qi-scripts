#bin 

DEV_HOSTNAME="regulus"
MASTER="master"
SLAVES="slave1 slave2 slave3"

EXCLUDE_FILES=$HOME"/bin/exclude-list.txt"
SOURCE_DIR=$HOME"/workspace/apache-nutch-2.3.0-src/runtime/local"

if [ `hostname` != "$DEV_HOSTNAME" ]; then
  echo "this script must run from deploy machine"
  exit 1
fi

rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_DIR hduser@master:~/nutch-2.3.0

