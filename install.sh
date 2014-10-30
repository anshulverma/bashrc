#!/bin/bash

BASEDIR=`pwd`

# get current timestamp
timestamp() {
  date +"%s"
}

# backup a file if it exists along with a timestamp
function backupFile() {
  file=$1

  # check if exists and create backup
  if [ -f $file ]; then
    ver=$(timestamp)
    backup="${file}.bak.$ver"
    echo "creating backup $backup"
    mv $file $backup
  fi
}

# backup a file and create a new one in its place with custom contents
function backupAndWriteNew() {
  file=$1

  # first, backup the file if it exists
  backupFile $1

  # add custom file header
  cat <<EOF>> $file
#!/bin/bash

# THIS FILE WAS AUTOGENERATED
# DO NOT EDIT DIRECTLY
#
# Refer to this repository for more information:
# https://github.com/anshulverma/bashrc

EOF

  # read heredoc and append to $file
  while read -r line; do
    echo "$line" >> "$file"
  done

  echo "created new $file"
}

# create new bashrc to load custom config
backupAndWriteNew $HOME/.bashrc <<EOF
BASEDIR=$BASEDIR
export BASH_RC_BASEDIR=$BASEDIR
source $BASEDIR/bootstrap.bash

EOF

# create new bash_profile to load custom .bashrc
backupAndWriteNew $HOME/.bash_profile <<EOF
# load bashrc in login shell
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

EOF
