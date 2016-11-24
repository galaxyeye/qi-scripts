#bin 

# if no args specified, show usage
if [ `whoami` != "root" ]; then
  echo "Usage: sync2jdk"
  echo "This script must be run as root user"
  exit 1
fi

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

 . "$bin"/detect-env.sh

JAVA_HOME_8=/usr/lib/jvm/java-8-sun

if [ ! -d "$JAVA_HOME_8" ]; then
  echo "project directory $JAVA_HOME_8 does not exists"
  exit 1
fi

TARGET_HOSTNAMES=$SLAVES
SOURCE_DIR=$JAVA_HOME_8
TARGET_DIR=/usr/lib/jvm/

function sync2one() {
  EXEC_CALL="rsync --update -raz --progress --exclude-from "$EXCLUDE_FILES" "$SOURCE_DIR" "$1":$TARGET_DIR

  echo $EXEC_CALL
  exec $EXEC_CALL &
}

for TARGET_HOST in $TARGET_HOSTNAMES
do
  sync2one $TARGET_HOST
done

