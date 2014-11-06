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

function print_git_branch() {
  git branch &>/dev/null;
  if [ $? -eq 0 ]; then
    git status | grep "nothing to commit" > /dev/null 2>&1;
    if [ "$?" -eq "0" ]; then
      # clean repository - nothing to commit
      echo -e "$Green$(__git_ps1 "(%s)")${ResetColor} ";
    else
      # changes to working tree
      echo -e "$IRed$(__git_ps1 "(%s)")${ResetColor} ";
    fi
  fi
}

# Test connection type:
if [ -n "${SSH_CONNECTION}" ]; then
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
elif [[ ${USER} != $(logname) ]]; then
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

# Now we construct the prompt.
PROMPT_COMMAND="history -a"
case ${TERM} in
  *term | rxvt | linux)
    PS1="\$(print_git_branch)"
    # User@Host (with connection type info):
    PS1=${PS1}"\[${SU}\]\u\[${ResetColor}\]@\[${CNX}\]\h\[${ResetColor}\]"
    # PWD (with 'job' info):
    PS1=${PS1}":\$(load_color)\$(get_current_path)${ResetColor}"
    # ending character '#' with load color
    PS1=${PS1}" \$(job_color)#${ResetColor} "
    ;;
  *)
    PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
    ;;
esac
