#bin

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`

 . "$bin"/detect-env.sh

$bin/ps -ef | grep solr

echo
echo 'Starting solr...'

SOLR_VERSION=6.1.0
SOLR_HOME="~/solr-$SOLR_VERSION"
# SOLR_HOME="~/workspace/warps-solr/solr"
SOLR_BIN=$SOLR_HOME/bin
SOLR_LOG_OUT=$SOLR_HOME/server/logs/solr.out

EXEC_CALL=("$RSH" "$MASTER_USER@$MASTER" "$SOLR_BIN/solr start -c > $SOLR_LOG_OUT &")
echo
echo $MASTER" :"
echo "${EXEC_CALL[@]}"

# exec "${EXEC_CALL[@]}" &

EXEC_CALL=
for SLAVE in $SLAVES; do
  EXEC_CALL=("$RSH" "$SLAVE_USER@$SLAVE" "$SOLR_BIN/solr start -c > $SOLR_LOG_OUT &")

  echo
  echo $SLAVE" :"
  echo "${EXEC_CALL[@]}"

  # exec "${EXEC_CALL[@]}" &
done

sleep 3
echo
echo "------------------------"
$bin/ps -ef | grep solr

echo
echo "done."

