#!/bin/bash

BASEDIR=`pwd`

timestamp() {
  date +"%s"
}

# backup old bash_profile if it already exists
if [ -f $HOME/.bash_profile ]; then
  ver=$(timestamp)
  backup="$HOME/.bash_profile.bak.$ver"
  echo "creating backup $backup"
  mv ~/.bash_profile $backup
fi

cat <<EOF>> ~/.bash_profile
#!/bin/bash

BASEDIR=$BASEDIR
export BASH_RC_BASEDIR=$BASEDIR
source $BASEDIR/lib/profile.bash

EOF
echo "created new $HOME/.bash_profile"
