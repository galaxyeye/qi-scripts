#bin 

function rpps() {
  rsh $1 ~/satellite/bin/satellite pps
}

echo 'running process : '

echo
echo 'satellite : '
rpps satellite
echo
echo 'satellite2 : '
rpps satellite2
echo
echo 'satellite3 : '
rpps satellite3
echo
echo 'satellite4 : '
rpps satellite4
echo
echo 'satellite5 : '
rpps satellite5
echo
echo 'satellite6 : '
rpps satellite6

