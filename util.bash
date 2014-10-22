#!/bin/bash

# get current time in milliseconds
function currentTime() {
  echo $(($(date +%s%N)/1000000))
}

# load a script and measure time takenf
function loadScript() {
  source $BASH_RC_BASEDIR/colors.bash
  file=$1
  appName=`basename $file | sed 's/.bash$//'`
  echo -ne "setting up $(cprint $appName $BWhite)...."
  startTime=$(currentTime)
  source $file
  timeTaken=$(expr $(currentTime) - $startTime)
  echo -e "$(cprint 'done' $Green) [${timeTaken} msec]"
}

export -f currentTime
export -f loadScript
