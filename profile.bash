#!/bin/bash

# call init before anything to get ready for setup
source $BASEDIR/init.bash

# call init before anything to get ready for setup
source $BASEDIR/util.bash

startTime=$(currentTime)

# set constants
source $BASEDIR/constants.bash

# initialize colors
source $BASEDIR/colors.bash

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
loadScript $BASEDIR/brew.bash

# setup prompt
loadScript $BASEDIR/git.bash

# setup prompt
loadScript $BASEDIR/prompt.bash

# install custom aliases
loadScript $BASEDIR/alias.bash

# set up all applications run configurations
source $BASEDIR/app_rc.bash

endTime=$(currentTime)
echo ""
echo "Total time taken: $(expr $endTime - $startTime) msec"
