#bin 

BIN=$HOME"/bin"
DEV_HOSTNAME=`cat $BIN/conf/dev`
MASTER=`cat $BIN/conf/master`
SLAVES=`cat $BIN/conf/slaves`
SATELLITES=`cat $BIN/conf/satellites`

MASTER_USER=`cat $BIN/conf/master-user`
SLAVE_USER=`cat $BIN/conf/slave-user`
SATELLITE_USER=`cat $BIN/conf/satellite-user`

EXCLUDE_FILES=$BIN"/conf/exclude-list.txt"

SOURCE_DIR=$BIN

if [ `hostname` != "$DEV_HOSTNAME" ]; then
  echo "this script must run from deploy machine"
  exit 1
fi

echo "Start sync bin to the following machines : "
echo $MASTER" "$SLAVES" "$SATELLITES

rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_DIR $MASTER_USER@$MASTER:~/

for SLAVE in $SLAVES; do
  echo $SLAVE" :"
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_DIR $SLAVE_USER@$SLAVE:~/
done

for SATELLITE in $SATELLITES; do
  echo $SATELLITE" :"
  rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE_DIR $SATELLITE_USER@$SATELLITE:~/
done

