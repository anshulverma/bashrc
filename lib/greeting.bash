#!/bin/bash

function bashrc_version() {
  if test -d $BASH_RC_BASEDIR/.git; then
    pushd $BASH_RC_BASEDIR > /dev/null
    tag="$(git describe --tags --abbrev=0)"
    num_patches="$(git rev-list ${tag}..HEAD --count)"
    dirty=""
    if [ ! -z "$(git status -s)" ]; then
      dirty="*"
    fi
    echo "${tag}.${num_patches}${dirty}"
    popd > /dev/null
  elif test -n "$(basename $BASH_RC_BASEDIR | sed 's/bashrc-//')"; then
    echo "v"$(basename $BASH_RC_BASEDIR | sed 's/bashrc-//')
  fi
}

if [ "$QUIET_MODE" != "true" ]; then
  bash_echo -e "Welome to ${BYellow}${HOSTNAME}${ResetColor}"
  cat <<EOF
Current time is $(date)

For more information about this configuration,
please visit https://github.com/anshulverma/bashrc

EOF
fi

bash_echo -e "Configuration version ${BRed}$(bashrc_version)${ResetColor} \
running BASH ${BRed}${BASH_VERSION%.*}${ResetColor}\n"

function _exit() {              # Function to run upon exit of shell.
  bash_echo -e "${BRed}Hasta la vista, baby${ResetColor}"
}
trap _exit EXIT
