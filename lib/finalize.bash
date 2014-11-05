#!/bin/bash

fortune=$(which fortune)
if [ ! -z "$fortune" ] && [ -x "$fortune" ]; then
  $fortune ascii-art computers riddles
fi
