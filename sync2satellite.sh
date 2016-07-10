#bin 

BIN=$HOME"/bin"
DEV_HOSTNAME_FILE="$BIN/conf/devs"
SATELLITES=`cat $BIN/conf/satellites`

SATELLITE_USER=`cat $BIN/conf/satellite-user`

EXCLUDE_FILES=$BIN"/conf/exclude-list.txt"

if ! grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  echo "this script must run from deploy machine"
  exit 1
fi

PROJECT_NAME="$1"
if [ "$PROJECT_NAME" = "" ]; then
  echo "Usage : $0 <project-name>"
  exit
fi

SOURCE_DIR=$HOME"/$PROJECT_NAME"
if [ "`hostname`" = "$DEV_HOSTNAME" ]; then
  SOURCE_DIR=$HOME"/workspace/$PROJECT_NAME"
fi

echo "Start sync bin to satellites : "

for SATELLITE in $SATELLITES; do
  echo $SATELLITE" :"
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_DIR $SATELLITE_USER@$SATELLITE:~/
done

