#!/bin/bash

BASEDIR=`pwd`

# load util functions
source ./lib/util.bash

# create new bashrc to load custom config
backupAndWriteNew $HOME/.bashrc <<EOF
BASEDIR=$BASEDIR
export BASH_RC_BASEDIR=$BASEDIR
source $BASEDIR/bootstrap.bash

EOF

# create new bash_profile to load custom .bashrc
backupAndWriteNew $HOME/.bash_profile <<EOF
# load bashrc in login shell
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

EOF
