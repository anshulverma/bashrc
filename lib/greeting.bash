#!/bin/bash

echo -e "$(date)\n"

echo -e "Welcome to ${BWhite}${HOSTNAME}${ResetColor}"

echo -e "For more information about this configuration,\n\
please visit https://github.com/anshulverma/bashrc\n"

echo -e "Running BASH version ${BRed}${BASH_VERSION%.*}${ResetColor} \
- on DISPLAY ${BRed}$DISPLAY${ResetColor}\n"

function _exit() {              # Function to run upon exit of shell.

  echo -e "${BRed}Hasta la vista, baby${ResetColor}"
}
trap _exit EXIT
