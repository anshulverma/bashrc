#!/bin/bash

alias timestamp='date +%s'
alias estart='/usr/local/bin/elasticsearch -D es.config=/usr/local/Cellar/elasticsearch/0.19.4/config/elasticsearch.yml -p $ESDIR/$(timestamp).pid'
alias estop='for f in `ls $ESDIR/*.pid`; do kill -TERM `cat $f`; rm -rf $f; done;'
alias head1="awk 'BEGIN{blank=0}{if (NF == 0) {blank=1} if (blank==0) {print blank}}'"

function httph {
  curl -iksD - $1 -o /dev/null
}

alias e='emacsclient'

alias j6='export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)'
alias j7='export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...

alias hg-rsync='hg qref && hg qpop && rsync -azvP ~/recs/r3/.hg/patches/ ubee:recs/r3/.hg/patches/ && hg qpush'

alias .='pwd'
alias ..='cd .. && .'
alias ...='cd ../.. && .'

# Docker
alias docker-rm-all="docker rm \$(docker ps -a -q)"
alias docker-kill-all="docker kill \$(docker ps -a -q)"
function docker-exec() {
  container_id=$(docker_container_id $1)
  docker exec -it $container_id bash
}
function docker-kill() {
  container_id=$(docker_container_id $1)
  docker kill $container_id
}
function docker-inspect() {
  container_id=$(docker_container_id $1)
  docker inspect $container_id
}
function docker-ip() {
  docker inspect -f '{{.NetworkSettings.IPAddress}}' $@
}
function docker-cleanup() {
  if ask "remove stopped containers?"; then
    echo "removing stopped containers..."
    docker rm -v `docker ps -a -q -f status=exited`
  else
    echo "not removing stopped containers"
  fi
  if ask "remove dangling images?"; then
    echo "removing dangling images..."
    docker rmi $(docker images -q -f dangling=true)
  else
    echo "not removing dangling images"
  fi
}

# prevent accidentally clobbering files
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# short to force clobber
alias rmf='rm -f'
alias cpf='cp -f'
alias mvf='mv -f'

alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'

# disk info
alias du='du -kh'
alias df='df -kTh'

# git
alias gca='git commit -am'

### tmux

# force 256-color support
alias tmux="tmux -2 a"

# Split watch into a separate window
function tmw {
  tmux split-window -dh "$*"
}

###

### utils

alias htop="sudo htop"

###

### chrome

function chrome {
  url="http://google.com"
  if [ ! -z "$1" ]; then
    url=$1
  fi
  echo $url
  open -a Google\ Chrome "$url"
}

###
