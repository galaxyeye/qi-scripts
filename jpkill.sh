#bin 

# if no args specified, show usage
if [ $# = 0 ]; then
  echo "jpkill : usage: jpkill [-signal] [pattern]"
  echo "kill java process by name pattern"
  exit 1
fi

SIGNAL="-15" # TERM
PATTERN=$1
if [ $# = 2 ] ; then
  SIGNAL=$1
  PATTERN=$2
fi

PID=`jps | grep "$PATTERN" | cut -d" " -f1`

if [ "$PID" != "" ] ; then
  kill $SIGNAL $PID
fi

