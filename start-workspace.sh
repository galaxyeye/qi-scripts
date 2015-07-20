#bin

HBASE_HOME=~/programs/hbase-0.98.8
# SOLR_HOME=~/programs/solr-4.10.3
# SATELLITE_HOME=~/workspace/satellite
# SCENT_HOME=~/workspace/qiwur-scent-1.0.0-src
# NUTCH_HOME=~/workspace/apache-nutch-2.3.0-src

# enter the home directory
cd 

echo "start eclipse..."
/opt/luna/eclipse 2> /dev/null  &
sleep 3

echo "start firefox..."
firefox 2> /dev/null &
sleep 1

# echo "start ibus..."
# we use fcitx to support sogou pinyin
# ibus-daemon 2> /dev/null &
# sleep 1

# echo "start chrome..."
# chromium-browser 2> /dev/null &
# sleep 3

echo "start gedit..."
gedit 2> /dev/null &
sleep 1

echo "ssh to qiwur.com"
gnome-terminal -e "ssh hduser@qiwur.com"
sleep 1

echo "start mysql workbench"
/usr/bin/mysql-workbench 2> /dev/null &
sleep 1

SATELLITE="$SATELLITE_HOME/bin/phantomjs"
if [ -x $SATELLITE ]; then
    echo "start satellite..."
    $SATELLITE --load-images=false src/server.js 2> /dev/null &
    sleep 3
fi

HBASE="$HBASE_HOME/bin/start-hbase.sh"
if [ -x $HBASE ]; then
    echo "start hbase"
    $HBASE
    sleep 3
fi

SOLR="$SOLR_HOME/bin/solr"
if [ -d $SOLR ]; then
    echo "start solr"
    $SOLR start
    sleep 3
fi

SCENT="$SCENT_HOME/bin/scent"
if [ -x $SCENT ]; then
  echo "start scent..."
  gnome-terminal --tab -e "$SCENT scentserver"
  sleep 3
  gnome-terminal --tab -e "less logs/scent.log"
fi

NUTCH="$NUTCH_HOME/runtime/local/bin/nutch"
if [ -x $NUTCH ]; then
    # TODO : wait for hbase available
    sleep 5
    echo "start nutch server"
    
    gnome-terminal --tab -e "$NUTCH nutchserver"
    sleep 3
fi

cd
echo "press any key to exit:"
read key

