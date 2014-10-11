#bin 
rsync --update -raz --progress --exclude-from '/home/vincent/bin/exclude-list.txt' /home/vincent/workspace/apache-nutch-2.3.0-src/runtime/local hduser@master:~/nutch-2.3.0
rsync --update -raz --progress --exclude-from '/home/vincent/bin/exclude-list.txt' /home/vincent/workspace/apache-nutch-2.3.0-src/runtime/deploy hduser@master:~/nutch-2.3.0
