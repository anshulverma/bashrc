#!/bin/bash

if [ ! -z "$(which emacs)" ] && [ $PLATFORM == 'OSX' ] && $(brew_installed "emacs")
then
  # Make sure newer emacs is picked up
  alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
else
  EXIT_CODE=1
  return
fi

# make sure mural (a fast, fuzzy typeahead) binary is in PATH
MURAL_PATH="$HOME/.mural"
if [ -d "$MURAL_PATH" ]; then
  export PATH=$PATH:$MURAL_PATH
fi
