#!/bin/bash

if [ "$QUIET_MODE" != "true" ]; then
  bash_echo -e "Welome to ${BYellow}${HOSTNAME}${ResetColor}"
  cat <<EOF
Current time is $(date)

For more information about this configuration,
please visit https://github.com/anshulverma/bashrc

EOF
fi

bash_echo -e "Configuration version ${BRed}${BASH_RC_VERSION}${ResetColor} \
running BASH ${BRed}${BASH_VERSION%.*}${ResetColor}\n"

function _exit() {              # Function to run upon exit of shell.
  bash_echo -e "${BRed}Hasta la vista, baby${ResetColor}"
}
trap _exit EXIT
