#bin

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

 . "$bin"/detect-env.sh

function call_rtail_all() {
  echo
  echo
  echo "-------------------------------------------------------------------"
  echo "$1 : "
  rsh $1 $bin/tail-all-logs.sh
}

call_rtail_all master

for SLAVE in $SLAVES; do
  call_rtail_all "$SLAVE"
done

