#!/bin/bash

if [[ -n ${TMUX} ]];then
  TERM=screen-256color
fi

# source iterm2 shell integration if available
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
