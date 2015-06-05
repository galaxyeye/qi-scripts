#bin 

DEV_HOSTNAME="regulus"
MASTER="master"
SLAVES="slave1 slave2 slave3"
SATELLITES="satellite satellite2 satellite3"

EXCLUDE_FILES=$HOME"/bin/exclude-list.txt"
SOURCE_DIR=$HOME"/bin"

if [ `hostname` != "$DEV_HOSTNAME" ]; then
  echo "this script must run from deploy machine"
  exit 1
fi

rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_DIR hduser@master:~/
rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_DIR hduser@slave1:~/
rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_DIR hduser@slave2:~/
rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_DIR hduser@slave3:~/

rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_DIR vincent@satellite:~/
rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_DIR vincent@satellite2:~/
rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_DIR vincent@satellite3:~/

exit 0

