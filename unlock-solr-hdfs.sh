#!/usr/bin/env bash

BIN=$HOME"/bin"

HDFS_BASE_DIR=hdfs://galaxyeye:9000/solr-6.1.0

COLLECTIONS=(ec_0901 
information_0815_integration_test 
information_0915_integration_test 
information_1001_integration_test 
information_1101_integration_test 
information_1121_integration_test 
information_native_0724 
novel_native_0808
)

for COLLECTION in "${COLLECTIONS[@]}"; do
  CORE_NODES=(core_node1 core_node2 core_node3 core_node4)

  for CORE_NODE in "${CORE_NODES[@]}"; do
    F="$HDFS_BASE_DIR/$COLLECTION/$CORE_NODE/data/index/write.lock"
    hadoop fs -test -f $F
    if [ $?==0 ]; then
      hadoop fs -rm $F
    fi
  done

done

hadoop fs -rm hdfs://galaxyeye:9000/solr-6.1.0/ec_0901/core_node2/data/index.20161105120437207/write.lock
hadoop fs -rm hdfs://galaxyeye:9000/solr-6.1.0/information_native_0724/core_node3/data/index.20160807214200195/write.lock
hadoop fs -rm hdfs://galaxyeye:9000/solr-6.1.0/information_native_0724/core_node2/data/index.20160807214201177/write.lock

hadoop fs -rm hdfs://galaxyeye:9000/solr-6.1.0/information_1101_integration_test/core_node1/data/index.20161121163451622/write.lock
hadoop fs -rm hdfs://galaxyeye:9000/solr-6.1.0/information_1101_integration_test/core_node4/data/index.20161123175340603/write.lock
hadoop fs -rm hdfs://galaxyeye:9000/solr-6.1.0/information_1101_integration_test/core_node3/data/index.20161121210945526/write.lock
hadoop fs -rm hdfs://galaxyeye:9000/solr-6.1.0/information_1101_integration_test/core_node2/data/index.20161123175339375/write.lock

