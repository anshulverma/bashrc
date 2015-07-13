#!/bin/bash

BASHRC_DIR="$HOME/.bashrc.d"
BIN_DIR="${BASHRC_DIR}/bin"

function bin_not_installed {
  if [ -d "${BIN_DIR}" ]; then
    return 1
  else
    return 0
  fi
}

function install_bin {
  tmp_file=$(mktemp -t bin-XXXX.tar.gz)

  # get latest bin
  curl -L https://github.com/anshulverma/bin/archive/master.tar.gz -s -o $tmp_file
  mkdir -p $BIN_DIR
  tar -xf $tmp_file --strip-components=1 -C $BIN_DIR

  rm -rf $tmp_file
}

function setup_bin {
  if bin_not_installed; then
    install_bin
  fi

  export PATH="$PATH:${BIN_DIR}/scripts"
  export PATH="$PATH:${BIN_DIR}/applescripts"
}

if [ ! -d "$BASHRC_DIR" ]; then
  mkdir -p $BASHRC_DIR
fi

setup_bin
