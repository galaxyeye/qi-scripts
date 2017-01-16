#bin 


function __is_crawl_loop_stopped {
  STOP=0
  if [ -e ".STOP" ] || [ -e ".KEEP_STOP" ]; then
   if [ -e ".STOP" ]; then
     mv .STOP ".STOP_EXECUTED_`date +%Y%m%d.%H%M%S`"
   fi

    STOP=1
  fi

  (( $STOP==1 )) && return 0 || return 1
}

if ( __is_crawl_loop_stopped ); then
   echo "STOP file found - escaping loop"
   exit 0
fi

