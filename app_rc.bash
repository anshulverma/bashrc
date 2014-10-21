#!/bin/bash

# Load all application configurations
for file in `find $BASEDIR/app -name "*.bash" -type f`; do
  filename=`basename $file | sed 's/.bash$//'`
  echo -ne "setting up $filename...."
  startTime=`date +%s`
  source $file
  timeTaken=$(expr `date +%s` - $startTime)
  echo -e "${Green}done${ResetColor} [${timeTaken} msec]"
done
