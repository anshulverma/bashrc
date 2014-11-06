#!/bin/bash

function bashrc_version() {
  if test -d $BASH_RC_BASEDIR/.git; then
    git --git-dir=$BASH_RC_BASEDIR/.git --work-tree=$BASH_RC_BASEDIR describe
  elif test -n "$(basename $BASH_RC_BASEDIR | sed 's/bashrc-//')"; then
    echo "v"$(basename $BASH_RC_BASEDIR | sed 's/bashrc-//')
  fi
}

cat <<EOF
Welcome to host ${HOSTNAME}
Current time is $(date)

For more information about this configuration,
please visit https://github.com/anshulverma/bashrc

EOF

echo -e "Configuration version ${BRed}$(bashrc_version)${ResetColor} \
running BASH ${BRed}${BASH_VERSION%.*}${ResetColor}\n"

function _exit() {              # Function to run upon exit of shell.
  echo -e "${BRed}Hasta la vista, baby${ResetColor}"
}
trap _exit EXIT
