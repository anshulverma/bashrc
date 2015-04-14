
0.5 / 2015-04-14
==================

  * added more details in changelog
  * fix version in changelog

0.4.3 / 2015-04-14
==================

  * load a custom init file first to allow to override QUIET_MODE
  * added git commit add alias as 'gca'

0.4.2 / 2015-04-01
==================

  * fix version in changelog
  * Release v0.4.3
  * load a custom init file first to allow to override QUIET_MODE
  * added git commit add alias as 'gca'
  * first draft of readme file
  * fix docker config for docker version 0.17
  * ask util function loops until valid input is entered
  * improving docker-cleanup
  * added docker-cleanup alias

0.4.1 / 2015-03-16
==================

  * hadoop config should only run in OSX

0.4 / 2015-03-11
==================

  * fix prompt_status_log
  * handle xquartz for prompt in OSX
  * ignore git files in projectile
  * added git config to disable prompt for large repositories
  * exclude git files from projectile
  * added docker-inspect and docker-ip alias
  * change time command to get milliseconds
  * add debug option to prompt
  * ability to handle git or mercurial in prompt
  * fix version detection of git
  * add mercurial setting
  * disable git in prompt if running inside vagrant
  * java home is only set if binary is present
  * keeping loading of .profile simple
  * fixed vagrant check
  * set purple connection color for vagrant box
  * fixing error in bootstrap
  * adding docker-kill alias
  * adding command to enter docker container in a new TTY
  * making sure git is disabled in prompt for a docker container
  * docker-kill-all alias
  * adding nginx configuration
  * fix scp by not displaying log messages during load
  * properly escape "\u" in printf statement
  * remove "$" sign added by mistake
  * adding ability to log prompt status
  * fixing git branch spacing in prompt
  * fix prompt by properly escaping colors
  * fix OS check for docker
  * fix type in docker OS check
  * docker config is OSX specific

0.3 / 2014-11-06
==================

  * fix version extraction in greeting

0.2 / 2014-11-06
==================

  * don't shorten path if they are smaller than 32 chars
  * host name color should be yellow in docker container
  * do not load ssh keys in docker container
  * shorten path in prompt
  * fixing greeting message
  * ssh config should be skipped in for a ssh'ed session
  * fix header of greeting message
  * make fortune work on linux
  * make return display code limited to 4 letters
  * only configure git if it is inatalled
  * only configure java if it is installed
  * make hadoop config available for override
  * skip docker config if docker not installed
  * brew does not need to be configured in non-osx environments
  * add guards in node setup and made it work in linux
  * git app should be env specific
  * fixing java app for linux
  * adding java app config
  * moving brew related config in one place
  * showing version number at startup
  * fixing typo
  * adding a few more util methods
  * changing camel case names to small case
  * removing duplicate code
  * removing redundant line
  * adding configuration for less
  * some constants to control environment
  * adding more aliases
  * Create README.md
  * making prompt be smarter
  * a greeting when you login
  * fixing color codes
  * beautifying environment script
  * get platform from OS_TYPE
  * adding platform variable in environment
  * adding environment configuration script
  * add docker rm all container alias
  * add hostname in the prompt
  * put a guard against multiple initialization

0.1 / 2014-10-31
==================

  * separate functions needed to install in install.sh
  * move header and backup util to common place
  * linking login shell from non-login shell
  * fix prompt's reset color
  * handle formatting using cursor movement
  * parallel execution does not export env variables
  * moving to a cleaner stricture
  * parallelize without parallel command
  * parallel command does not transfer env variables
  * should source apps rather than run them as separate scripts
  * show status of loaded apps
  * fix typo
  * fix overall time calculation
  * measure time taken by each script and total time
  * moving ssh.bash to app dir
  * fix time calculation
  * moving more apps into the app/ folder for auto initialization
  * do not export colors
  * loading apps in parallel
  * fix green color
  * adding ability to load all app config defined in /app
  * ignoring bash history file
  * adding ability to configure apps separately
  * add docker config
  * fix ssh agent setup script
  * adding ssh-setup script
  * adding a few more cd aliases
  * renaming scripts to *.bash
  * add install script to fix path
  * initial configuration
