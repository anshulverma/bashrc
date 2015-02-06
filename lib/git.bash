#!/bin/bash

if [ -z "$(which git)" ]; then
  EXIT_CODE=1
  return
fi

if [ $PLATFORM == 'OSX' ]; then
  git_version=`git --version | sed 's/[a-z ]*//g'`

  # git auto complete
  source $CELLAR_PATH/git/${git_version}/etc/bash_completion.d/git-completion.bash

  # git prompt
  source $CELLAR_PATH/git/${git_version}/etc/bash_completion.d/git-prompt.sh
fi
