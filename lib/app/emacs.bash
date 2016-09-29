#!/bin/bash

if [ ! -z "$(which emacs)" ] && [ $PLATFORM == 'OSX' ] && $(brew_installed "emacs")
then
  # Make sure newer emacs is picked up
  alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
else
  EXIT_CODE=1
  return
fi
