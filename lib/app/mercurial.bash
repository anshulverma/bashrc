#!/bin/bash

if [ -z "$(which hg)" ]; then
  EXIT_CODE=1
  return
fi

if [ $PLATFORM == 'OSX' ]; then
  hg_version=`\ls $CELLAR_PATH/mercurial/ | tr ' ' '\n' | tail -n 1`

  # git auto complete
  source $CELLAR_PATH/mercurial/${hg_version}/etc/bash_completion.d/hg-completion.bash
fi
