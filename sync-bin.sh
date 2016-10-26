#bin 

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

 . "$bin"/detect-env.sh

if ! grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  echo "this script must run from deploy machine"
  exit 1
fi

echo "Start sync bin to the following machines : "
echo $MASTER" "$SLAVES" "$SATELLITES

SOURCE_DIR=$bin

if [ ! -d "$SOURCE_DIR" ]; then
  echo "project directory $SOURCE_DIR does not exists"
  exit 1
fi

EXEC_CALL_PREFIX=(rsync --update -raz --progress --exclude-from $EXCLUDE_FILES)

function sync2one() {
  TARGET_USER=$1
  TARGET_HOST=$2
  TARGET_DIR=/home/$TARGET_USER

  if [[ ! -d $SOURCE_DIR ]]; then
    echo "Source $SOURCE_DIR dir does not exit."
    return
  fi

  echo 
  echo "---------------------------"
  echo $TARGET_HOST" :"

  EXEC_CALL=(${EXEC_CALL_PREFIX[@]} $SOURCE_DIR $TARGET_USER@$TARGET_HOST:$TARGET_DIR)

  echo ${EXEC_CALL[@]}
  exec ${EXEC_CALL[@]} &
}

sync2one $MASTER_USER $MASTER

# sync to slaves
for SLAVE in $SLAVES; do
  sync2one $SLAVE_USER $SLAVE
done

# sync to satellites
for SATELLITE in $SATELLITES; do
  sync2one $SATELLITE_USER $SATELLITE
done

