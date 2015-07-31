#bin 

BIN=$HOME"/bin"
DEV_HOSTNAME=`cat $BIN/conf/dev`

# if no args specified, show usage
if [ $# = 0 ]; then
  echo "Usage: sync2cluster project_name"
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

$HOME/bin/sync2master.sh $*
$HOME/bin/sync2slave.sh $*

