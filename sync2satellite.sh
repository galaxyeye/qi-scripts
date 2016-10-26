#bin 

PROJECT_NAME="$1"

# if no args specified, show usage
if [ $# = 0 ]; then
  echo "Usage: $0 project_name"
  exit 1
fi

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

 . "$bin"/detect-env.sh

SATELLITES=`cat $bin/conf/satellites`
SATELLITE_USER=`cat $bin/conf/satellite-user`

SOURCE_DIR=$HOME"/$PROJECT_NAME"
if $IS_DEV_HOST; then
  SOURCE_DIR=$HOME"/workspace/$PROJECT_NAME"
fi

if [ ! -d "$SOURCE_DIR" ]; then
  echo "project directory $SOURCE_DIR does not exists"
  exit 1
fi

TARGET_DIR="~"
TARGET_USER=$SATELLITE_USER
TARGET_HOSTNAMES=$SATELLITES

function sync2one() {
  TARGET_HOST=$1
  EXEC_CALL="rsync --update -raz --progress --exclude-from "$EXCLUDE_FILES" "$SOURCE_DIR" "$TARGET_USER@$TARGET_HOST:$TARGET_DIR

  echo $EXEC_CALL
  exec $EXEC_CALL &
}

for TARGET_HOST in $TARGET_HOSTNAMES
do
  echo 
  echo "---------------------------"
  sync2one $TARGET_HOST
done

