#bin 

DEV_HOSTNAME="regulus"
MASTER="master"
SLAVES="slave1 slave2 slave3"

# if no args specified, show usage
if [ $# = 0 ]; then
  echo "Usage: sync2slave project_name"
  exit 1
fi

PROJECT_NAME="$1"
SOURCE_DIR=$HOME"/$PROJECT_NAME"
if [ "`hostname`" = "$DEV_HOSTNAME" ]; then
  SOURCE_DIR=$HOME"/workspace/$PROJECT_NAME"
fi

if [ ! -d "$SOURCE_DIR" ]; then
  echo "project directory $SOURCE_DIR does not exists"
  exit 1
fi

~/bin/sync2master.sh $*
~/bin/sync2slave.sh $*

