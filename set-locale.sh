#bin 

echo 'Set system locale to support en_US.UTF-8 and zh_CN.UTF-8'
echo 'This script must run under supper user'

locale
locale-gen en_US.UTF-8
locale-gen zh_CN.UTF-8
update-locale

echo 'Done.'

