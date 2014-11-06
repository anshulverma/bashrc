#!/bin/bash

fortune=$(which fortune)
if [ ! -z "$fortune" ] && [ -x "$fortune" ]; then
  case $PLATFORM in
    OSX) $fortune ascii-art computers riddles
         ;;
    *)
         $fortune
  esac
fi
