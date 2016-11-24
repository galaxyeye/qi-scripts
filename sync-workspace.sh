#bin

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

 . "$bin"/detect-env.sh

if ! grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  echo "this script must run from deploy machine"
  exit 1
fi

DESTINATION="$MASTER_USER@$MASTER:/mnt/data/hduser/archive/"

EXCLUDE_FILES=$HOME"/bin/conf/workspace-exclude-list.txt"
SOURCE="$HOME/workspace"
echo $SOURCE
rsync --update -raz --progress --exclude-from $EXCLUDE_FILES $SOURCE $DESTINATION

SOURCE="$HOME/bin"
echo $SOURCE
rsync --update -raz --progress $SOURCE $DESTINATION

SOURCE="$HOME/Documents"
echo $SOURCE
rsync --update -raz --progress $SOURCE $DESTINATION

