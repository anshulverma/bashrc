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

overallStartTime=$(date +%s.%N)

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
  local_profile_start_time=$(current_time)
  source "$HOME/.profile"
  bash_echo "Local profile loaded in $(elapsed_time $local_profile_start_time)s"
  bash_echo ""
fi

# set up all applications run configurations
source $LIB_DIR/app_rc.bash

# display time taken to load bashrc
# TODO: remove the hardcoded 0 below
bash_echo -e "\nTotal time taken: 0$(elapsed_time $overallStartTime)s\n"

source $LIB_DIR/finalize.bash
