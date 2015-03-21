#bin 

# if no args specified, show usage
if [ $# = 0 ]; then
  ssh
  exit 1
fi

parallel-ssh -i -h ~/.pssh/slaves $*

