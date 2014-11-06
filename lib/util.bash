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
    0) code="DONE"
       color=$Green
       ;;
    1) code="SKIP"
       color=$White
       ;;
    *) code="ERR "
       color=$Red
  esac

  # print status
  appName=$(cprint "`basename $file | sed 's/.bash$//'`" $BWhite)
  status=$(cprint $code $color)
  timeTaken=$(expr $(current_time) - $startTime)
  echo -e "....................\r$appName\r\033[20C$status [${timeTaken} msec]"
}

# ask user for y/n input
# example use:
# if ask "are you sure?"; then
#   do_something
# fi
function ask() {
  echo -n "$@" '[y/n] ' ; read ans
  case "$ans" in
    y*|Y*) return 0 ;;
    *) return 1 ;;
  esac
}

#-------------------------------------------------------------
# File & strings related functions:
#-------------------------------------------------------------

# Find a file with a pattern in name:
function ff() {
  find . -type f -iname '*'"$*"'*' -ls
}

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() {
  find . -type f -iname '*'"${1:-}"'*' \
       -exec ${2:-file} {} \;
}

# Find a pattern in a set of files and highlight them:
# (needs a recent version of egrep).
function fstr() {
  OPTIND=1
  local mycase=""
  local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
  while getopts :it opt
  do
    case "$opt" in
      i) mycase="-i " ;;
      *) echo "$usage"; return ;;
    esac
  done
  shift $(( $OPTIND - 1 ))
  if [ "$#" -lt 1 ]; then
    echo "$usage"
    return;
  fi
  find . -type f -name "${2:-*}" -print0 | \
    xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more
}

# Swap 2 filenames around, if they exist (from Uzi's bashrc).
function swap() {
  local TMPFILE=tmp.$$

  [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
  [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
  [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

  mv "$1" $TMPFILE
  mv "$2" "$1"
  mv $TMPFILE "$2"
}

# usage:
# split_path /some/path
function split_path() {
  split "/" $1
}

# split a string using a delimiter
# split '/' /some/path
function split() {
  local IFS=$1
  local split=
  read -ra ADDR <<< "$2"
  for part in "${ADDR[@]}"; do
    split=$split" "$part
  done
  echo $split
}

# shortens a path by trimming mid elements to 2 characters
# usage:
# ellipsify_path /usr/apps/tr/name
# result:
# /us/ap/tr/name
function shorten_path() {
  path=$(echo $1 | sed "s;$HOME;~;")
  short_path=
  for part in $(split_path $path); do
    if [ ${#part} -gt 2 ]; then
      short_part=$(echo $part | cut -c -2)
    else
      short_part=$part
    fi
    if [ -z "$short_path" ] && [ "$short_part" == '~' ]; then
      short_path=$short_part
    elif [ $part == $(basename $1) ]; then
      short_path=${short_path}"/"${part}
    else
      short_path=${short_path}"/"${short_part}
    fi
  done
  echo $short_path
}

# check if you are running in a docker container
function running_in_docker() {
  $(test -f '/proc/self/cgroup') && $(awk -F/ '$2 == "docker"' /proc/self/cgroup | read)
}
