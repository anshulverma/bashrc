#!/bin/bash

if [[ -n ${TMUX} ]];then
  TERM=screen-256color
fi

# source iterm2 shell integration if available
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

Z_SH=`brew --prefix`/etc/profile.d/z.sh
if [ -f "$Z_SH" ] ; then
  # enable easy switching between directories
  source $Z_SH
fi
