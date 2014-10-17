#!/bin/bash

### environment variable customizations ###
export JAVA_HOME=`/usr/libexec/java_home -v 1.7`
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export CELLAR_PATH=/Users/ansverma/.workspace/homebrew/Cellar
export HISTCONTROL=ignoredups
export TMP=/tmp
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=2048m"

# docker setup
function getDockerIP() {
  boot2docker ip 2>/dev/null
}

export DOCKER_IP=$(getDockerIP)
export DOCKER_HOST=`boot2docker socket 2>/dev/null`
export DOCKER_CERT_PATH=/Users/ansverma/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
