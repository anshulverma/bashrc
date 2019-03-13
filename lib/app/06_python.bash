#!/bin/bash

if is-not-installed python; then
  EXIT_CODE=1
  return
fi

# pip bash completion start
_pip_completion()
{
  COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                           COMP_CWORD=$COMP_CWORD \
                           PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

# setup pyenv in path
export PATH="$(pyenv root)/shims:$PATH"

# set up python startup script
export PYTHONSTARTUP=$BIN_DIR/scripts/pythonstartup.py
