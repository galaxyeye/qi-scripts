#bin

SATELLITE_HOME=~/workspace/satellite
SCENT_HOME=~/workspace/scent

# enter the home directory
cd 

echo "start eclipse..."
/opt/luna/eclipse 2> /dev/null  &
sleep 3

echo "start firefox..."
firefox 2> /dev/null &
sleep 1

echo "start ibus..."
ibus-daemon 2> /dev/null &
sleep 1

# echo "start chrome..."
# chromium-browser 2> /dev/null &
# sleep 3

echo "start gedit..."
gedit 2> /dev/null &
sleep 1

echo "ssh to qiwur.com"
gnome-terminal -e "ssh hduser@qiwur.com"
sleep 1

echo "start satellite..."
cd $SATELLITE_HOME
# ./bin/phantomjs --load-images=false src/server.js 2> /dev/null &
cd
sleep 3

# echo "start scent..."
# cd $SCENT_HOME
# ant
# cd runtime/local
# ./bin/scent scentserver 2> /dev/null &
# sleep 3
# gnome-terminal --tab -e "less logs/scent.log"

cd
echo "press any key to exit:"
read key
