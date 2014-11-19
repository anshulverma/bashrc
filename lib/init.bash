#!/bin/bash

# append PATH
export PATH="$PATH:~/bin/scripts"                           # add custom scripts
export PATH="/usr/local/bin:$PATH"                          # make sure brew's scripts are picked up
export PATH="$PATH:/opt/openresty/nginx/sbin"               # add nginx
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" # really want to use coreutils

QUIET_MODE=${QUIET_MODE:-true}
if `tty > /dev/null`; then
  QUIET_MODE=false
fi
