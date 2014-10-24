#!/bin/bash

# get current time in milliseconds
function currentTime() {
  echo $(($(date +%s%N)/1000000))
}

# load a script and measure time taken
function loadScript() {
  startTime=$(currentTime)

  # execute script
  file=$1
  EXIT_CODE=0
  source $file

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

  # print status
  appName=$(cprint "`basename $file | sed 's/.bash$//'`" $BWhite)
  status=$(cprint $code $color)
  timeTaken=$(expr $(currentTime) - $startTime)
  echo -e "$appName....$status [${timeTaken} msec]"
}

export -f currentTime
