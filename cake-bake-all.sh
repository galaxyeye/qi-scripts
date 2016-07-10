#bin 

BIN=$HOME/bin
TABLES=$BIN/conf/cake-bake-tables.txt
CAKE_HOME=/usr/bin/cake
CAKE_HOME=/home/vincent/workspace/qiwur-ui2/bin

# if no args specified, show usage
# if [ $# = 0 ]; then
#   echo "cake-bake-tables"
#   echo "TODO : add CAKE_HOME config and tables config"
#   exit 1
# fi

while read TABLE
do
    echo "$TABLE"
	# $CAKE_HOME/cake bake all $TABLE

	echo -n "Are you sure [Y/n]? "
	read line
	case "$line" in 
		n|N) echo "smth"
		;;
    	y|Y) echo "smth"
		;;
	esac

done < $TABLES

