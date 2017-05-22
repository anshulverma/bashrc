#!/bin/bash

if is-installed pdflatex && [ $PLATFORM == 'OSX' ]
then
  export PATH=$PATH:/Library/TeX/texbin
else
  EXIT_CODE=1
  return
fi
