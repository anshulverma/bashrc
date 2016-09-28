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

overallStartTime=$(ruby -e 'puts (Time.now.to_f * 1000).to_i')

# set constants
source $LIB_DIR/constants.bash

# initialize colors
source $LIB_DIR/colors.bash

# environmental config
source $LIB_DIR/environment.bash

# greet the user with a welcome message and some session info
source $LIB_DIR/greeting.bash

# Load the default .profile
if [ -f "$HOME/.profile" ]; then
  bash_echo "Loading local profile..."
  localProfileStartTime=$(current_time)
  source "$HOME/.profile"
  localProfileEndTime=$(current_time)
  bash_echo "Local profile loaded in $(expr $localProfileEndTime - $localProfileStartTime) msec"
  bash_echo ""
fi

bash_echo -e "Setting up bash environment..."

# setup homebrew
load_script $LIB_DIR/brew.bash

# setup git
load_script $LIB_DIR/git.bash

# setup prompt
load_script $LIB_DIR/prompt.bash

# install custom aliases
load_script $LIB_DIR/alias.bash

# set up all applications run configurations
source $LIB_DIR/app_rc.bash

# display time taken to load bashrc
endTime=$(current_time)

bash_echo -e "\nTotal time taken: $(expr $endTime - $overallStartTime) msec\n"

source $LIB_DIR/finalize.bash
