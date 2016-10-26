#bin

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

 . "$bin"/detect-env.sh

for SATELLITE in $SATELLITES; do
  echo
  echo $SATELLITE" :" 

  rsh $SATELLITE_USER@$SATELLITE /home/$SATELLITE_USER/bin/pps.sh

done

