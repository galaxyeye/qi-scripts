#bin 

DEV_HOSTNAME="regulus"
PROJECT_NAME="$1"

# if no args specified, show usage
if [ $# = 0 ]; then
  echo "Usage: sync_master project_name"
  exit 1
fi

MASTER_HOSTNAME="galaxyeye"
SLAVES="slave1 slave2 slave3"
EXCLUDE_FILES=$HOME"/bin/exclude-list.txt"
TARGET_DIR="~"
LOGIN_USERNAME="hduser"

TARGET_HOSTNAMES=$SLAVES
if [ "`hostname`" = "$DEV_HOSTNAME" ]; then
  TARGET_HOSTNAMES=$MASTER_HOSTNAME
  SOURCE_DIR=$HOME"/workspace/$PROJECT_NAME"
fi

if [ ! -d "$SOURCE_DIR" ]; then
  echo "project directory $SOURCE_DIR does not exists"
  exit 1
fi

EXEC_CALL="rsync --update -raz --progress --exclude-from "$EXCLUDE_FILES" "$SOURCE_DIR" "$LOGIN_USERNAME@"$1":$TARGET_DIR

for TARGET_HOST in $TARGET_HOSTNAMES
do
  echo $EXEC_CALL
  # exec $EXEC_CALL
done


