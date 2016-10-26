#bin 

# if no args specified, show usage
if [ $# = 0 ]; then
  ssh
  exit 1
fi

BIN=$HOME"/bin"

parallel-ssh -i -h $BIN/conf/cluster $*

