#bin

function call_rtail_all() {
  echo
  echo
  echo "$1 : "
  echo
  rsh $1 ~/bin/tail_all_logs.sh
}

echo "master : "
echo

~/bin/tail_all_logs.sh

call_rtail_all hduser@master
call_rtail_all hduser@slave1
call_rtail_all hduser@slave2
call_rtail_all hduser@slave3
