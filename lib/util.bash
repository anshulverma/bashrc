#!/bin/bash

# get current time in milliseconds
function current_time() {
  echo $(($(date +%s%N)/1000000))
}

# load a script and measure time taken
function load_script() {
  startTime=$(current_time)

  # execute script
  file=$1
  EXIT_CODE=0
  source $file

  # find out the status code from exit code
  case $EXIT_CODE in
    0) code="DONE";
       color=$Green;
       ;;
    *) code="ERROR";
       color=$Red
  esac

  # print status
  appName=$(cprint "`basename $file | sed 's/.bash$//'`" $BWhite)
  status=$(cprint $code $color)
  timeTaken=$(expr $(current_time) - $startTime)
  echo -e "....................\r$appName\r\033[20C$status [${timeTaken} msec]"
}
