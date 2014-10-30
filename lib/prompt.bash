#!/bin/bash

Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

# export PS1='\u@\h:\w\$ '
# export PS1="\u@\h:\w$ "
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# enable color support (dependency 'coreutils')
### Enable colors in terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

### colorize dir listing
use_color=true
if ${use_color} ; then
  # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
  if type -P dircolors >/dev/null ; then
    if [ -f ~/.dir_colors ] ; then
      eval $(dircolors -b ~/.dir_colors)
    elif [ -f /etc/DIR_COLORS ] ; then
      eval $(dircolors -b /etc/DIR_COLORS)
    else
      eval $(dircolors -b $BASEDIR/resources/dircolors)
    fi
  fi
fi

PromptResetColor="\[\033[0m\]"

DEFAULT_PROMPT="$Cyan\u:$BYellow$PathShort$PromptResetColor"
export PS1='$(git branch &>/dev/null;\
    if [ $? -eq 0 ]; then \
      echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
      if [ "$?" -eq "0" ]; then \
        # @4 - Clean repository - nothing to commit
        echo "'$Green'"$(__git_ps1 "(%s)"); \
      else \
        # @5 - Changes to working tree
        echo "'$IRed'"$(__git_ps1 "(%s)"); \
      fi) '$DEFAULT_PROMPT'\$ "; \
    else \
      # @2 - Prompt when not in GIT repo
      echo "'$DEFAULT_PROMPT'\$ "; \
    fi)'
