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

SOURCE_DIR=$HOME"/$PROJECT_NAME"
if $IS_DEV_HOST; then
  SOURCE_DIR=$HOME"/workspace/$PROJECT_NAME"
fi

if [ ! -d "$SOURCE_DIR" ]; then
  echo "project directory $SOURCE_DIR does not exists"
  exit 1
fi

TARGET_DIR="~"
TARGET_HOSTNAMES=$SLAVES

function sync2one() {
  EXEC_CALL="rsync --update -raz --progress --exclude-from "$EXCLUDE_FILES" "$SOURCE_DIR" "$SLAVE_USER@"$1":$TARGET_DIR

  echo $EXEC_CALL
  exec $EXEC_CALL &
}

for TARGET_HOST in $TARGET_HOSTNAMES
do  
  echo 
  echo "---------------------------"
  sync2one $TARGET_HOST
done

