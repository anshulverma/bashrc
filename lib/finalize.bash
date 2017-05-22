#!/bin/bash

if is-installed fortune && [ -x "$fortune" ] && [ "$QUIET_MODE" != "true" ]; then
  case $PLATFORM in
    OSX) $fortune ascii-art computers riddles
         ;;
    *)
         $fortune
  esac
fi
