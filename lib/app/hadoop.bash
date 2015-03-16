#!/bin/bash

if [ -z "$(which hdfs)" ] || [ $PLATFORM != 'OSX' ]; then
  EXIT_CODE=1
  return
fi

# Hadoop settings
export HADOOP_HOME=${HADOOP_HOME:-"/usr/local/Cellar/hadoop/2.4.1"}
export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"$HADOOP_HOME/libexec/etc/hadoop"}

# PIG
export PIG_HOME=${PIG_HOME:-"/usr/local/Cellar/pig/0.12.0"}
