#bin 

echo 'Set system locale to support en_US.UTF-8 and zh_CN.UTF-8'
echo 'This script must run under supper user'

function qiwur_rset_locale() {
   echo 'Set locale for '$1
   rsh $1 locale
   rsh $1 locale-gen en_US.UTF-8
   rsh $1 locale-gen zh_CN.UTF-8
   rsh $1 update-locale

   sleep 3
   echo '\n'
}

qiwur_rset_locale master
qiwur_rset_locale slave1
qiwur_rset_locale slave2
qiwur_rset_locale slave3

echo 'Done.'

