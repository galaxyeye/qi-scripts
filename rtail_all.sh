#bin

function call_rtail_all() {
  echo
  echo
  echo "$1 : "
  echo
  rsh $1 ~/bin/tail_all.sh

}

echo "master : "
echo
~/bin/tail_all.sh

call_rtail_all slave1
call_rtail_all slave2
call_rtail_all slave3
