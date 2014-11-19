#!/bin/bash

fortune=$(which fortune)
if [ ! -z "$fortune" ] && [ -x "$fortune" ] && [ "$QUIET_MODE" != "true" ]; then
  case $PLATFORM in
    OSX) $fortune ascii-art computers riddles
         ;;
    *)
         $fortune
  esac
fi
