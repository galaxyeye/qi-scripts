#bin

BIN=$HOME"/bin"
DEV_HOSTNAMES=$BIN/conf/devs

echo $DEV_HOSTNAMES
echo `hostname`
grep -q "`hostname`" $DEV_HOSTNAMES

if ! grep -q "`hostname`" $DEV_HOSTNAMES; then
  echo "this script must run from deploy machine"
  exit 1
fi

echo "OK"
