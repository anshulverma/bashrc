#!/bin/bash

if is-not-installed nginx && [ ! -d "/etc/nginx" ]; then
  EXIT_CODE=1
  return
fi

# set up path
export PATH=$PATH:/etc/nginx/sbin
