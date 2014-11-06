#!/bin/bash

if [ -z "$(which java)" ]; then
  EXIT_CODE=1
  return
fi

export JAVA_HOME=${JAVA_HOME:-"$(/usr/libexec/java_home -v 1.7)"}
export GROOVY_HOME=${GROOVY_HOME:-"/usr/local/opt/groovy/libexec"}
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=2048m"
