#!/bin/bash

# enable color support (dependency 'coreutils')

### Enable colors in terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

### colorize dir listing
use_color=true
if ${use_color} ; then
  # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
  if type -P dircolors >/dev/null ; then
    if [ -f ~/.dir_colors ] ; then
      eval $(dircolors -b ~/.dir_colors)
    elif [ -f /etc/DIR_COLORS ] ; then
      eval $(dircolors -b /etc/DIR_COLORS)
    else
      eval $(dircolors -b $BASEDIR/resources/dircolors)
    fi
  fi
fi

# escape color code
# also, don't use color if use_color is false
function pcolor() {
  if ${use_color} ; then
    echo "\[$1\]"
  fi
}

function print_git_branch() {
  git branch &>/dev/null;
  if [ $? -eq 0 ]; then
    git status | grep "nothing to commit" > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
      # clean repository - nothing to commit
      printf "$(pcolor $Green)$(__git_ps1 "(%s)")$(pcolor $ResetColor)"
    else
      # changes to working tree
      printf "$(pcolor $IRed)$(__git_ps1 "(%s)")$(pcolor $ResetColor)"
    fi
  fi
}

function print_username() {
  printf "$(pcolor $SU)\u$(pcolor $ResetColor)"
}

function print_hostname() {
  printf "$(pcolor $CNX)\h$(pcolor $ResetColor)"
}

function print_cwd_with_load() {
  load_color=$(load_color)
  printf "$(pcolor $load_color)$(get_current_path)$(pcolor $ResetColor)"
}

function print_end_with_job_info() {
  job_info_color=$(job_color)
  printf "$(pcolor $job_info_color)#$(pcolor $ResetColor)"
}

# Test connection type:
if running_in_docker; then
  CNX=${Yellow}       # Logged into a docker container
elif [ -n "${SSH_CONNECTION}" ]; then
  CNX=${Green}        # Connected on remote machine, via ssh (good).
elif [[ "${DISPLAY%%:0*}" != "" ]]; then
  CNX=${ALERT}        # Connected on remote machine, not via ssh (bad).
else
  CNX=${Cyan}         # Connected on local machine.
fi

# Test user type:
USER=${USER:-"$(whoami)"}
if [[ ${USER} == "root" ]]; then
  SU=${Red}           # User is root.
elif [[ ${USER} != $LOGNAME ]]; then
  SU=${BRed}          # User is not login user.
else
  SU=${Cyan}          # User is normal (well ... most of us are).
fi

# Number of CPU
if [ $PLATFORM == 'OSX' ]; then
  NCPU=$(sysctl -a | grep machdep.cpu | grep core_count | cut -c 25-)
else
  NCPU=$(grep -c 'processor' /proc/cpuinfo)
fi

SLOAD=$(( 100*${NCPU} ))        # Small load
MLOAD=$(( 200*${NCPU} ))        # Medium load
XLOAD=$(( 400*${NCPU} ))        # Xlarge load

# Returns system load as percentage, i.e., '40' rather than '0.40)'.
function load() {
  if [ $PLATFORM == 'OSX' ]; then
    local SYSLOAD=$(sysctl -n vm.loadavg | cut -d " " -f2 | tr -d '.')
  else
    local SYSLOAD=$(cut -d " " -f1 /proc/loadavg | tr -d '.')
  fi
  echo $((10#$SYSLOAD))       # Convert to decimal.
}

# Returns a color indicating system load.
function load_color() {
  local SYSLOAD=$(load)
  if [ ${SYSLOAD} -gt ${XLOAD} ]; then
    echo -en ${ALERT}
  elif [ ${SYSLOAD} -gt ${MLOAD} ]; then
    echo -en ${Red}
  elif [ ${SYSLOAD} -gt ${SLOAD} ]; then
    echo -en ${BRed}
  else
    echo -en ${BGreen}
  fi
}

# Returns a color according to running/suspended jobs.
function job_color() {
  if [ $(jobs -s | wc -l) -gt "0" ]; then
    echo -en ${BRed}
  elif [ $(jobs -r | wc -l) -gt "0" ] ; then
    echo -en ${BCyan}
  fi
}

# print current path in short form
function get_current_path() {
  shorten_path $PWD
}

function build_prompt() {
  print_git_branch
  printf ' '
  print_username
  printf '@'
  print_hostname
  printf ':'
  print_cwd_with_load
  printf ' '
  print_end_with_job_info
  printf ' '
}

export PROMPT_COMMAND='
  PS1=$(build_prompt);
'
