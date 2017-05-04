#bin

SYNC_TYPE=JOB

# Start daemons.
# Run this on master node.
function printUsage() {
  echo "usage: sync-pulsar.sh [options] <COMMAND>"
  echo
  echo "where COMMAND is one of:"
  echo "  local        Sync pulsar in local mode"
  echo "  job          Sync pulsar packaged job"
  echo "  jetty        Sync pulsar jetty server"
  echo "  pmaster      Sync pulsar PMaster war"
  echo
  echo "Options: "
  echo "  -v, --verbose    Talk more"
  echo "  -h, --help       The help text"
  exit 1
}

while [ $# -gt 1 ]
do
case $1 in
    -v|--verbose)
        VERBOSE=1
        shift
        ;;
    -h|--help)
        SHOW_HELP=true
        shift
        ;;
    -*)
        echo "Unrecognized option : $1"
        echo "Try 'pulsar --help' for more information."
        exit 0
        ;;
    *)
        # command begins
        break
        ;;
esac
done

if [[ $SHOW_HELP ]]; then
  printUsage;
  exit 0
fi

SYNC_TYPE=$1
shift

SYNC_TYPES=("local" "job" "jetty" "pmaster")
if ! [[ ${SYNC_TYPES[*]} =~ "$SYNC_TYPE" ]]; then 
  printUsage
  exit 0
fi

# environment
BIN=$HOME"/bin"
DEV_HOSTNAME_FILE="$BIN/conf/devs"

MASTER="master"

# script config
PULSAR_HOME=$HOME"/workspace/warps-pulsar"
PULSAR_VERSION=`cat $PULSAR_HOME/VERSION`

if ! grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  echo "this script must run from deploy machine"
  exit 1
fi

EXCLUDE_FILES=$HOME"/bin/conf/exclude-list.txt"
OPTIONS=(--update -raz --progress --exclude-from $EXCLUDE_FILES)

if [[ $SYNC_TYPE == "jetty" ]] || [[ $SYNC_TYPE == "pmaster" ]]; then
  SOURCE="$PULSAR_HOME/pulsar-server/target/pulsar-server-$PULSAR_VERSION"
  DESTINATION="hduser@$MASTER:~"
  
  if [ $SYNC_TYPE == "jetty" ]; then
    OPTIONS=(${OPTIONS[@]} --exclude=*.war)
  fi

  # echo "rsync ${OPTIONS[@]}" $SOURCE $DESTINATION
  rsync "${OPTIONS[@]}" $SOURCE $DESTINATION

  exit 0
elif [[ $SYNC_TYPE == "local" ]]; then
  SOURCE="$PULSAR_HOME/pulsar-distribution/target/pulsar-distribution-$PULSAR_VERSION"
else
  SOURCE="$PULSAR_HOME/pulsar-distribution/target/pulsar-distribution-$PULSAR_VERSION-job.jar"
fi

DESTINATION="hduser@$MASTER:~/pulsar-$PULSAR_VERSION/"
if [ -e "$SOURCE" ]; then
  rsync ${OPTIONS[@]} $SOURCE $DESTINATION
  rsync ${OPTIONS[@]} "$PULSAR_HOME/bin" $DESTINATION
  rsync ${OPTIONS[@]} "$PULSAR_HOME/conf" $DESTINATION
  rsync ${OPTIONS[@]} "$PULSAR_HOME/VERSION" $DESTINATION
  # ssh hduser@$MASTER mkdir "~/pulsar-$PULSAR_VERSION/logs"
else
  echo "$SOURCE does not exist"
  exit 1
fi

