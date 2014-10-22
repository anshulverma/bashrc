#!/bin/bash

# Load all application configurations
find $BASEDIR/app -name "*.bash" -type f | parallel --no-notice "loadScript {}"
