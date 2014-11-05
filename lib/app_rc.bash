#!/bin/bash

# Load all application configurations
for app in `find $LIB_DIR/app -name "*.bash" -type f`; do
  load_script $app
done
