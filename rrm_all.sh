#bin 

# if no args specified, show usage
if [ $# = 0 ]; then
  echo "rrm_all.sh : usage: rrm_all.sh FILE"
  echo "rm all file or directory on the cluster"
  exit 1
fi

FILE = $1

rsh master rm -r $FILE
rsh slave1 rm -r $FILE
rsh slave2 rm -r $FILE
rsh slave3 rm -r $FILE

