#bin 

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

 . "$bin"/detect-env.sh

if ! grep -q "`hostname`" $DEV_HOSTNAME_FILE; then
  echo "this script must run from deploy machine"
  exit 1
fi

echo "Start sync bin to the following machines : "
echo $MASTER" "$SLAVES

DATE=`date +%s`
# FILE_PREFIX=$DATE.$RANDOM
FILE_PREFIX=$USER
SOURCE_DIR=~/workspace/warps-solr/solr

if [ ! -d "$SOURCE_DIR" ]; then
  echo "project directory $SOURCE_DIR does not exists"
  exit 1
fi

SOURCE_FILE_EXCLUDE=(
"*~"
"licenses/README.committers.txt"
"**/*.pid"
"**/.git/*"
"**/data/"
"**/logs/*"
"**/*shard*_replica*"
"**/zoo_data/*"
"**/classes/"
"**/*.sh"
"**/ivy.xml"
"**/build.xml"
"**/bin/"
"**/*.iml"
"**/*.ipr"
"**/*.iws"
"**/pom.xml"
"**/*pom.xml.template"
"server/etc/test/"
)

[ -e /tmp/rsync ] && rm -r /tmp/rsync
mkdir -p /tmp/rsync

echo '--------------'
EXCLUDE_FILES="/tmp/rsync/$FILE_PREFIX.excludes.txt"
touch $EXCLUDE_FILES
ARRAY_LENGTH=${#SOURCE_FILE_EXCLUDE[@]}
for (( i=0; i<ARRAY_LENGTH; i++ ))
do
  pattern=${SOURCE_FILE_EXCLUDE[$i]}
  # echo "$pattern"
  echo $pattern >> $EXCLUDE_FILES
done

echo `wc -l $EXCLUDE_FILES`

declare -a SYNC_FILES=(
$SOURCE_DIR/LICENSE.txt
$SOURCE_DIR/NOTICE.txt
$SOURCE_DIR/README.txt
$SOURCE_DIR/CHANGES.txt
$SOURCE_DIR/LUCENE_CHANGES.txt
$SOURCE_DIR/bin
$SOURCE_DIR/server
$SOURCE_DIR/contrib
$SOURCE_DIR/dist
)

for f in "${SYNC_FILES[@]}"
do
rsync --update -raz --copy-unsafe-links --exclude-from $EXCLUDE_FILES --progress $f $MASTER_USER@$MASTER:/home/hduser/warps-solr-6.1.0
done

# sync to slaves
#for SLAVE in $SLAVES; do
  # sync2one $INCLUDE_LIST $EXCLUDE_FILES $SLAVE_USER $SLAVE
#done

