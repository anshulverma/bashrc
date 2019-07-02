#!/bin/bash

if is-not-installed hg; then
  EXIT_CODE=1
  return
fi

if [ $PLATFORM == 'OSX' ]; then
  hg_version=`\ls $CELLAR_PATH/mercurial/ | tr ' ' '\n' | tail -n 1`

  # git auto complete
  source $CELLAR_PATH/mercurial/${hg_version}/etc/bash_completion.d/hg-completion.bash

  #   /opt/facebook/hg/share
  #   source /path/to/scm-prompt
  #   export PS1="\$(_scm_prompt " (%s)")\u@\h:\W\$ "
fi

# useful mercurial aliases
alias hg-bisect-log='hg log -r "bisect(good) or bisect(bad)" --template "{node|short} {bisect}\\n"'
