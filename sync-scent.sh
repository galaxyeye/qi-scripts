#bin 
rsync --update -raz --progress --exclude "*.log" --exclude "*.out" /home/vincent/workspace/scent/runtime/local hduser@master:~/scent/
