#!/bin/bash

# Load all application configurations
for app in `find $BASEDIR/app -name "*.bash" -type f`; do
  loadScript $app
done
