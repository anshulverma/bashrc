#!/bin/bash

if [ -z "$(which docker)" ] || [ $PLATFORM != 'OSX' ]; then
  EXIT_CODE=1
  return
fi

# docker setup
function getDockerIP() {
  boot2docker ip 2>/dev/null
}

export DOCKER_IP=$(getDockerIP)
eval `boot2docker shellinit 2>/dev/null`
