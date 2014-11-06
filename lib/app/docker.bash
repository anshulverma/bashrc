#!/bin/bash

if [ -z "$(which docker)" ]; then
  EXIT_CODE=1
  return
fi

# docker setup
function getDockerIP() {
  boot2docker ip 2>/dev/null
}

export DOCKER_IP=$(getDockerIP)
export DOCKER_HOST=`boot2docker socket 2>/dev/null`
export DOCKER_CERT_PATH=/Users/ansverma/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
