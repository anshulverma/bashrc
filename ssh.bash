#!/bin/bash

function latest_key() {
  key_name=`ls -1 $HOME/.ssh/keys | tail -n 2 | head -n 1`
  echo "$HOME/.ssh/keys/${key_name}"
}

function all_keys() {
  echo $(latest_key)

  # iterate over all keys in $HOME/.ssh
  for key_name in `ls -1 $HOME/.ssh | grep rsa | grep -v pub`; do
    echo "$HOME/.ssh/${key_name}"
  done
}

if [ -z "$SSH_AUTH_SOCK" ]; then
  echo "Starting ssh-agent..."
  eval `ssh-agent -s`

  for key in $(all_keys); do
    ssh-add $key
  done
else
  echo "SSH agent already running"
fi
