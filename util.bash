#!/bin/bash

# get current time in milliseconds
function currentTime() {
  echo $(($(date +%s%N)/1000000))
}

# load a script and measure time taken
function loadScript() {
  startTime=$(currentTime)

  # need colors to display pretty output
  source $BASH_RC_BASEDIR/colors.bash

  # extract the name of the script
  file=$1
  appName=`basename $file | sed 's/.bash$//'`
  echo -ne `pad -c "." -l 40 $(cprint $appName $BWhite)`

  EXIT_CODE=0
  sh $file

  # find out the status code from exit code
  case $EXIT_CODE in
    0) code="DONE";
       color=$Green;
       ;;
    1) code="NOT_INSTALLED";
       color=$Yellow;
       ;;
    2) code="NOT_FOUND";
       color=$Yellow;
       ;;
    *) code="ERROR";
       color=$Red
  esac

  status=`pad -c " " -l 31  "$(cprint $code $color)"`
  timeTaken=`pad -c " " -l 4 "$(expr $(currentTime) - $startTime)"`
  echo -e "$status[${timeTaken} msec]"
}

export -f currentTime
export -f loadScript
