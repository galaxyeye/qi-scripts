#bin 

PROJECT_NAME="$1"

# if no args specified, show usage
if [ $# = 0 ]; then
  echo "Usage: sync2slave project_name"
  exit 1
fi

BIN=$HOME"/bin"
DEV_HOSTNAME_FILE="$BIN/conf/devs"

SLAVES=`cat $BIN/conf/slaves`
SLAVE_USER=`cat $BIN/conf/slave-user`

TARGET_DIR="~"
TARGET_HOSTNAMES=$SLAVES

EXCLUDE_FILES=$HOME"/bin/exclude-list.txt"

IS_DEV_HOST=false
if grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  IS_DEV_HOST=true
fi

SOURCE_DIR=$HOME"/$PROJECT_NAME"
if $IS_DEV_HOST; then
  SOURCE_DIR=$HOME"/workspace/$PROJECT_NAME"
fi

if [ ! -d "$SOURCE_DIR" ]; then
  echo "project directory $SOURCE_DIR does not exists"
  exit 1
fi

function sync2one() {
  EXEC_CALL="rsync --update -raz --progress --exclude-from "$EXCLUDE_FILES" "$SOURCE_DIR" "$SLAVE_USER@"$1":$TARGET_DIR

  echo $EXEC_CALL
  exec $EXEC_CALL &
}

for TARGET_HOST in $TARGET_HOSTNAMES
do
  sync2one $TARGET_HOST
done

