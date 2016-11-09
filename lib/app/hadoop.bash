#!/bin/bash

if __not_installed brew || [ -z "$(which hdfs)" ] || [ $PLATFORM != 'OSX' ]; then
  EXIT_CODE=1
  return
fi

export HADOOP_VERSION="$(brew-version hadoop)"
export PIG_VERSION="$(brew-version pig)"
export HIVE_VERSION="$(brew-version hive)"

export HADOOP_HOME=${HADOOP_HOME:-"/usr/local/Cellar/hadoop/${HADOOP_VERSION}"}
export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"$HADOOP_HOME/libexec/etc/hadoop"}

export PIG_HOME=${PIG_HOME:-"/usr/local/Cellar/pig/${PIG_VERSION}"}

export HIVE_HOME=${HIVE_HOME:-"/usr/local/Cellar/hive/${HIVE_VERSION}"}
