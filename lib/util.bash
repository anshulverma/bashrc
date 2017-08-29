#!/bin/bash

# get current time in milliseconds
function current_time() {
  gdate +%s.%N # use gnu date
}

# get ellapsed time from the first argument
function elapsed_time() {
  start_time=$1
  echo "$(current_time) - $start_time" \
    | bc \
    | awk -F"." '{ print $1"."substr($2,1,3) }'
}

# ask user for y/n input
# example use:
# if ask "are you sure?"; then
#   do_something
# fi
function ask() {
  query="$@"
  while true; do
    echo -n "$query" '[y/n] ' ; read ans
    case "$ans" in
      y*|Y*) return 0 ;;
      n*|N*) return 1 ;;
      *) echo "invalid input, please type 'y' for yes and 'n' for no" ;;
    esac
  done
}

function bash_echo() {
  if [ "$QUIET_MODE" != "true" ]; then
    echo $1 $2
  fi
}

function bash_printf() {
  if [ "$QUIET_MODE" != "true" ]; then
    printf "$@"
  fi
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
# if it is greater than 32 chars
#
# usage:
# ellipsify_path /usr/apps/tr/name
# result:
# /us/ap/tr/name
function shorten_path() {
  # replace home path with "~"
  path=$(echo $1 | sed "s;$HOME;~;")

  # do not shorten path if it is shorter than 32 chars
  if [ ${#path} -lt 32 ]; then
    echo $path
    return
  fi

  short_path=
  for part in $(split_path $path); do
    trimmed_part=$(echo $part | cut -c -2)

    if [ -z "$short_path" ] && [ "$trimmed_part" == '~' ]; then
      short_path=$trimmed_part
    elif [ $part == $(basename $1) ]; then
      short_path=${short_path}"/"${part}
    else
      short_path=${short_path}"/"${trimmed_part}
    fi
  done
  echo $short_path
}

# check if you are running in a docker container
function running_in_docker() {
  $(test -f '/.dockerinit')
}

# check if you are running in a vagrant box
function running_in_vagrant() {
  [ "$USER" == "vagrant" ] || [ "$ENV_TYPE" == "vagrant" ]
}

# start a process and restart it if it crashes
# if the exit code was `0` then it means the process exited gracefully
# in such a case, we assume that the user wanted to shut it down and do nothing
RUN_FOREVER_BASE=$HOME"/.run-forever"
function run-forever() {

  args=()
  background_mode=false
  while [ ${#} -gt 0 ]
  do
    OPTERR=0
    OPTIND=1;
    getopts "dh" opt

    case "$opt" in
      d) background_mode=true ;;
      h) echo """Usage:
run-forever [-d] <command>

-d : Run the command process as a daemon
-h : Print this help"""
         return;;
      \?) args+=("$1") ;;
      *) echo "Invalid option: -$opt" >&2 ;;
    esac
    shift
    [ "" != "$OPTARG" ] && shift
  done
  [ ${#args[@]} -gt 0 ] && set "" "${args[@]}" && shift

  command=$@

  safe_filename=$(python -c "print ''.join([ c if c.isalnum() else '_' for c in '$command' ])")
  log_file="$RUN_FOREVER_BASE/${safe_filename}"

  if [ ! -d "$RUN_FOREVER_BASE" ]
  then
    mkdir -p $RUN_FOREVER_BASE
  fi

  if $background_mode
  then
    run-forever-internal "$command" "$log_file" >> "${log_file}.out" 2>> "${log_file}.err" &

    echo "started program '$command' in the background"
    echo "you can find the log files for this program at ${log_file}.{out,log}"
  else
    run-forever-internal "$command" "$log_file"
  fi
}

# this is for internal use
# used to start the run-forever process
function run-forever-internal() {
  command=$1
  log_file=$2

  run_id=$(awk -v min=5 -v max=999999 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')

  echo "$(date) | ${run_id} | program '$command' starting" >> "$log_file.log"

  until eval "$command"; do
    exit_code=$?
    if [ "$exit_code" -eq "1" ] # currently a hack to handle CTRL-C
    then
      echo "$(date) | ${run_id} | program '$command' terminated forcefully" >> "$log_file.log"
      return
    fi

    echo "$(date) | ${run_id} | program '$command' crashed with code $exit_code. Respawning..." >> "$log_file.log"
    sleep 1
  done

  echo "$(date) | ${run_id} | program '$command' exited gracefully" >> "$log_file.log"
}

# check if a brew package is installed
# Usage:
# if brew_installed "package-name"; then
#   do something
# fi
function brew_installed() {
  if [ -d "${CELLAR_PATH}/$1" ]; then
    return 0
  else
    return 1
  fi
}

# check if bash rc config is dirty (i.e. not in sync with git)
# Usage:
# if bashrc_dirty; then
#   do something
# fi
function bashrc_dirty() {
  if [ ! -z "$(git --git-dir=$BASH_RC_BASEDIR/.git --work-tree=$BASH_RC_BASEDIR status -s)" ]; then
    return 0
  else
    return 1
  fi
}

# get version for this bashrc config as per latest git tag.
# Last character determines the status of bashrc repo:
#   d -- git repository is not in sync with remote (dirty)
#   c -- git repository is in sync with remote (clean)
#   m -- manually installed by downloading a tarball (manual)
function bashrc_version() {
  if test -d $BASH_RC_BASEDIR/.git; then
    pushd $BASH_RC_BASEDIR > /dev/null
    tag="$(git describe --tags --abbrev=0)"
    num_patches="$(git rev-list ${tag}..HEAD --count)"
    dirty=$(bashrc_dirty && echo "d" || echo "c")
    echo "${tag}.${num_patches}${dirty}"
    popd > /dev/null
  elif test -n "$(basename $BASH_RC_BASEDIR | sed 's/bashrc-//')"; then
    echo "v"$(basename $BASH_RC_BASEDIR | sed 's/bashrc-//')"m"
  fi
}

# get value of a variable by name
function value-by-name() {
  echo ${!1}
}

# check if a custom rc was configured
# example use:
# if __installed "brew"; then
#   do_something
# fi
function __installed() {
  var="__$(echo $1 | tr '[:lower:]' '[:upper:]')_INSTALLED"
  flag=$(value-by-name $var)
  if [ $flag == 1 ]; then
    return 0
  else
    return 1
  fi
}

# negates the __installed function above
# similar usage
function __not_installed() {
  if __installed $1; then
    return 1
  else
    return 0
  fi
}

# check if a command does not exists
# Usage:
# if is-not-installed git; then
#   do something
# fi
function is-not-installed() {
  ! is-installed $1
}

# check if a command exists
# Usage:
# if is-installed git; then
#   do something
# fi
function is-installed() {
  hash $1 2>/dev/null
}
