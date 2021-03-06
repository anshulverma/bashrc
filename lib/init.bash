#!/bin/bash

# append PATH
export PATH="/usr/local/bin:$PATH"                          # make sure brew's scripts are picked up
export PATH="$PATH:/opt/openresty/nginx/sbin"               # add nginx
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" # really want to use coreutils
export PATH="/$HOME/.local/bin:$PATH"                       # locally installed bin folder

if [ -f "$HOME/.bashrc_init" ]; then
  source $HOME/.bashrc_init
fi

if [ "$QUIET_MODE" != "true" ]; then # forced quiet mode
  QUIET_MODE=${QUIET_MODE:-true}
  if `tty > /dev/null`; then
    QUIET_MODE=false
  fi
fi
