#bin 
rsync --update -raz --progress --exclude "*.log" --exclude "*.out" hadoop-1.2.1 master:~/
