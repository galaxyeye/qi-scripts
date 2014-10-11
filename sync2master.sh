#bin 

DEV_HOSTNAME="regulus"
MASTER="master"
SLAVES="slave1 slave2 slave3"

PROJECT_NAME="$1"

# if no args specified, show usage
if [ $# = 0 ]; then
  echo "Usage: sync2master project_name"
  exit 1
fi

EXCLUDE_FILES=$HOME"/bin/exclude-list.txt"
SOURCE_DIR=$HOME"/workspace/$PROJECT_NAME"
TARGET_DIR="~"
LOGIN_USERNAME="hduser"
TARGET_HOSTNAMES=$MASTER

if [ ! -d "$SOURCE_DIR" ]; then
  echo "project directory $SOURCE_DIR does not exists"
  exit 1
fi

function sync2one() {
  EXEC_CALL="rsync --update -raz --progress --exclude-from "$EXCLUDE_FILES" "$SOURCE_DIR" "$LOGIN_USERNAME@"$1":$TARGET_DIR

  echo $EXEC_CALL
  exec $EXEC_CALL &
}

for TARGET_HOST in $TARGET_HOSTNAMES
do
  sync2one $TARGET_HOST
done

