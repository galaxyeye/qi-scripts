#bin

echo "this script is not implemented yet"
exit 1

# if not root, su
su

apt-get update
apt-get upgrade

### install necessary softwares
apt-get install  aptitude ssh vim pkg-config g++ autoconf automake libtool cmake zlib1g-dev libssl-dev maven python default-jdk openjdk-7-jdk

### php relative
apt-get install libpcre3 libpcre3-dev php5 php5-dev php5-mysql php5-gd php5-json

#################################################################
### install offical jdk from sum
#################################################################
scp -R master:/usr/lib/jvm/java-8-sun /usr/lib/jvm/

### modify /etc/hosts to enable access var short names
vi /etc/hosts
# TODO : copy hosts file from a center repository

### add users
adduser vincent

addgroup hadoop
adduser --ingroup hadoop hduser

### add vincent to root privilege
visudo

### add ssh support for each user
ssh-keygen -t rsa -P ""
ssh-copy-id target-host-name

su vincent
ssh-keygen -t rsa -P ""
ssh-copy-id target-host-name

exit
su hduser
ssh-keygen -t rsa -P ""
ssh-copy-id target-host-name

### format hadoop data system
cd /mnt
mkdir data
cd data
chown /mnt/data data
mkdir hadoop
chown hduser:hadoop hadoop

