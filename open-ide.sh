#bin

BIN=$HOME"/bin"

IDE="$1"

usage="Usage: open-ide.sh <phpstorm|webstorm|idea|eclipse>"

# if no args specified, show usage
if [ $# -eq 0 ]; then
  echo $usage
  exit 1
fi

PHPSTORM="/opt/phpstorm/bin/phpstorm.sh"
WEBSTORM="/opt/webstorm/bin/webstorm.sh"
PYCHARM="/opt/pycharm/bin/pycharm.sh"
IDEA="/opt/idea/bin/idea.sh"
ECLIPSE="/opt/eclipse/mars/eclipse"

EXEC_CALL=""
if [ "$IDE" = "phpstorm" ] ; then
  EXEC_CALL=$PHPSTORM
elif [ "$IDE" = "webstorm" ] ; then
  EXEC_CALL=$WEBSTORM
elif [ "$IDE" = "PYCHARM" ] ; then
  EXEC_CALL=$PYCHARM
elif [ "$IDE" = "idea" ] ; then
  EXEC_CALL=$IDEA
elif [ "$IDE" = "eclipse" ] ; then
  EXEC_CALL=$ECLIPSE
else
  echo $usage
  exit 1
fi

echo $EXEC_CALL
exec $EXEC_CALL > /dev/null 2>&1 &

