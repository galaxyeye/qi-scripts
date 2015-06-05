#bin 

function rpps() {
  rsh $1 ~/satellite/bin/satellite pps
}

echo 'running process : '
echo
echo 'slave1 : '
rpps slave1
echo
echo 'slave2 : '
rpps slave2
echo
echo 'save3 : '
rpps slave3


echo
echo 'satellite : '
rpps satellite
echo
echo 'satellite2 : '
rpps satellite2
echo
echo 'satellite3 : '
rpps satellite3

