#bin 
rsync --update -raz --progress --exclude "*.log" --exclude "*.out" hbase-0.94.14 slave1:~/
rsync --update -raz --progress --exclude "*.log" --exclude "*.out" hbase-0.94.14 slave2:~/
rsync --update -raz --progress --exclude "*.log" --exclude "*.out" hbase-0.94.14 slave3:~/
