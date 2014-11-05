#!/bin/bash

# find DISPLAY
function get_xserver() {
  case $TERM in
    xterm )
      XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )
      # Ane-Pieter Wieringa suggests the following alternative:
      #  I_AM=$(who am i)
      #  SERVER=${I_AM#*(}
      #  SERVER=${SERVER%*)}
      XSERVER=${XSERVER%%:*}
      ;;
    aterm | rxvt)
      # Find some code that works here. ...
      ;;
  esac
}

if [ -z ${DISPLAY:=""} ]; then
  get_xserver
  if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) ||
          ${XSERVER} == "unix" ]]; then
    DISPLAY=":0.0"             # Display on local host.
  else
    DISPLAY=${XSERVER}:0.0     # Display on remote host.
  fi
fi

export DISPLAY

# set up PLATFORM variable
function get_platform() {
  case "$OSTYPE" in
    solaris*) echo "SOLARIS" ;;
    darwin*)  echo "OSX" ;;
    linux*)   echo "LINUX" ;;
    bsd*)     echo "BSD" ;;
    *)        echo "unknown: $OSTYPE" ;;
  esac
}

export PLATFORM=$(get_platform)

#-------------------------------------------------------------
# Some settings
#-------------------------------------------------------------

#set -o nounset     # These  two options are useful for debugging.
#set -o xtrace
alias debug="set -o nounset; set -o xtrace"

ulimit -S -c 0      # Don't want coredumps.
set -o notify
set -o noclobber
set -o ignoreeof


# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.

# Disable options:
shopt -u mailwarn
unset MAILCHECK        # Don't want my shell to warn me of incoming mail.
