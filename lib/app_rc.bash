#!/bin/bash

basedir="${BASH_RC_BASEDIR}/build"
mkdir -p $basedir
build_file="${basedir}/startup_${BASH_RC_VERSION}.bash"

if [[ "${BASH_RC_VERSION#*d}" == "" ]] || [ ! -f $build_file ]; then
  build_start_time="$(current_time)"

  bash_printf "rebuilding startup configuration"

  rm -rf $build_file

  # initialization header
  cat <<EOF>> $build_file
dotted_line="..........................."
EOF

  # laod all application configurations in build file
  for app in `find $LIB_DIR/app -name "*.bash" -type f`; do
    app_file_name=$(basename $app | sed 's/\..*//')
    app_name="${app_file_name#*_}"
    cat <<EOF>> $build_file
function __load_${app_file_name}() {
  $(cat $app | sed '/^[ ]*$/d')
}

# reset exit code so that we can capture the status of next script
EXIT_CODE=0

start_time="\$(current_time)"
__load_${app_file_name}
time_taken="\$(elapsed_time \$start_time)"

# find out the status code from exit code
case \$EXIT_CODE in
  0) code="DONE"
     color=\$Green
     ;;
  1) code="SKIP"
     color=\$White
     ;;
  *) code="ERR "
     color=\$Red
esac

if [ "\$QUIET_MODE" != "true" ]; then
  printf "$BWhite%s$ResetColor%s\$color%s$ResetColor [%1.3fs]\n" $app_name "\${dotted_line:${#app_name}}" \$code \$time_taken
fi

EOF
    bash_printf "."
  done
  # finished building app configurations

  # TODO: remove the hardcoded 0 below
  bash_echo "done [0$(elapsed_time $build_start_time)s]"
  bash_echo ""
fi

bash_echo -e "Setting up bash environment..."
source $build_file
