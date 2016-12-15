#!/bin/bash

if [ $PLATFORM != 'OSX' ]; then
  EXIT_CODE=1
  return
fi

# Load RVM into a shell session *as a function*
if [ -f "$HOME/.rvm/scripts/rvm" ]; then
  source "$HOME/.rvm/scripts/rvm" # Load RVM as a function
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
fi

export CELLAR_PATH="/usr/local/Cellar"

function brew-version() {
  app_path="${CELLAR_PATH}/$1"
  if [ -d $app_path ]; then
    ls -t $app_path | no-color | head -n 1
  else
    echo "not-installed"
  fi
}
