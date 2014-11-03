#!/bin/bash

if [ ! -z "$BASH_CONFIG_INITIALIZED" ]; then
  echo "bash config already initialized...skipping" 1>&2
  return
fi
BASH_CONFIG_INITIALIZED=1

LIB_DIR=$BASEDIR/lib

# call init before anything to get ready for setup
source $LIB_DIR/init.bash

# call init before anything to get ready for setup
source $LIB_DIR/util.bash

overallStartTime=$(($(date +%s%N)/1000000))

# set constants
source $LIB_DIR/constants.bash

# initialize colors
source $LIB_DIR/colors.bash

# append MANPATH
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Load the default .profile
[[ -s "$HOME/.profile" ]] && \
  echo "Loading local profile..."
  localProfileStartTime=$(currentTime); \
  source "$HOME/.profile"; \
  localProfileEndTime=$(currentTime); \
  echo "Local profile loaded in $(expr $localProfileEndTime - $localProfileStartTime) msec"; \
  echo ""

# setup homebrew
loadScript $LIB_DIR/brew.bash

# setup prompt
loadScript $LIB_DIR/git.bash

# setup prompt
loadScript $LIB_DIR/prompt.bash

# install custom aliases
loadScript $LIB_DIR/alias.bash

# set up all applications run configurations
source $LIB_DIR/app_rc.bash

endTime=$(currentTime)

echo ""
echo "Total time taken: $(expr $endTime - $overallStartTime) msec"
