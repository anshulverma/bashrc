#!/bin/bash

function latest_key() {
  echo `ls -1 | tail -n 2 | head -n 1`
}

if [ -z "$SSH_AUTH_SOCK" ] ; then
  echo "Starting ssh-agent..."
  eval `ssh-agent -s`
  ssh-add $(latest_key)
fi
