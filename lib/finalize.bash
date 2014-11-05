#!/bin/bash

if [ ! -z "$(which fortune)" ] && [ -x "$(which fortune)" ]; then
  fortune ascii-art computers riddles
fi
