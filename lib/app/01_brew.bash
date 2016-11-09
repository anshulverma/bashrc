#!/bin/bash

if [ $PLATFORM != 'OSX' ]; then
  EXIT_CODE=1
  return
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export CELLAR_PATH="/usr/local/Cellar"

function brew-version() {
  app_path="${CELLAR_PATH}/$1"
  if [ -d $app_path ]; then
    ls -t $app_path | no-color | head -n 1
  else
    echo "not-installed"
  fi
}
