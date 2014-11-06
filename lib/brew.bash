#!/bin/bash

if [ $PLATFORM != 'OSX' ]; then
  EXIT_CODE=1
  return
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export CELLAR_PATH=/Users/ansverma/.workspace/homebrew/Cellar
