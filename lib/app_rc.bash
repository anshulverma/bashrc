#!/bin/bash

# Load all application configurations
for app in `find $LIB_DIR/app -name "*.bash" -type f`; do
  loadScript $app &
done

# wait for all apps to be loaded
wait
