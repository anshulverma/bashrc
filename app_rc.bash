#!/bin/bash

function loadApplication() {
  source $BASH_RC_BASEDIR/init.bash
  file=$1
  appName=`basename $file | sed 's/.bash$//'`
  echo -ne "setting up $(cprint $appName $BWhite)...."
  startTime=`date +%s%2N`
  source $file
  sleep 1
  timeTaken=$(expr `date +%s%2N` - $startTime)
  echo -e "$(cprint 'done' $Green) [${timeTaken} msec]"
}

export -f loadApplication

# Load all application configurations
find $BASEDIR/app -name "*.bash" -type f | parallel --no-notice "loadApplication {}"
