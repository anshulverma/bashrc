#!/bin/bash

function bashrc_version() {
  git --git-dir=$BASH_RC_BASEDIR/.git --work-tree=$BASH_RC_BASEDIR describe
}

cat <<EOF
Welcome to host ${HOSTNAME}.
Current time is $(date)

For more information about this configuration,
please visit https://github.com/anshulverma/bashrc

EOF

echo -e "Configuring version ${BRed}$(bashrc_version)${ResetColor} \
running BASH ${BRed}${BASH_VERSION%.*}${ResetColor}\n"

function _exit() {              # Function to run upon exit of shell.
  echo -e "${BRed}Hasta la vista, baby${ResetColor}"
}
trap _exit EXIT
