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

# some ls aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias hg-rsync='hg qref && hg qpop && rsync -azvP ~/recs/r3/.hg/patches/ ubee:recs/r3/.hg/patches/ && hg qpush'

alias ..='cd ..'
