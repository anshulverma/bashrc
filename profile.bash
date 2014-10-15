#!/bin/bash

# call init before anything to get ready for setup
source $BASEDIR/init.bash

# set contants
source $BASEDIR/constants.bash

# append PATH
export PATH="$PATH:~/bin/scripts"                           # add custom scripts
export PATH="/usr/local/bin:$PATH"                          # make sure brew's scripts are picked up
export PATH="$PATH:/opt/openresty/nginx/sbin"               # add nginx
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" # really want to use coreutils

# append MANPATH
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# setup prompt
source $BASEDIR/prompt.bash

# install custom aliases
source $BASEDIR/alias.bash

# custom configurations for git
source $BASEDIR/gitrc.bash

# set up node
source $BASEDIR/node.bash

# set up big data
source $BASEDIR/big_data.bash

# set up ssh
source $BASEDIR/ssh.bash
