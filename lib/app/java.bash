#!/bin/bash

if [ -z "$(which java)" ]; then
  EXIT_CODE=1
  return
fi

if [ -x "/usr/libexec/java_home" ]; then
  export JAVA_HOME=${JAVA_HOME:-"$(/usr/libexec/java_home -v 1.7)"}
fi

export GROOVY_HOME=${GROOVY_HOME:-"/usr/local/opt/groovy/libexec"}
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=2048m"
