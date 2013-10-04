#!/bin/sh

echo common.sh: start

export USER_PREFIX=${HOME}/local
export BIN_DIR=${USER_PREFIX}/bin
export LIB_DIR=${USER_PREFIX}/lib
export SRC_DIR=${USER_PREFIX}/src
export TMP_DIR=`mktemp -d /tmp/XXXXXXXXXXXXXXXXXXXXXXXX`
export PATH=${BIN_DIR}/bin:${PATH}

_mkdir() {
  if [ ! -d $1 ]; then
    mkdir $1
  fi
}

exec_do() {
  [ ! -z ${FLAG_DEBUG_MODE} ] && echo [exec_do] $@
  $@
}

call_installer() {
  installs=`eval 'echo $'${1}'_installs'`
  deps=`eval 'echo $'${1}'_deps'`
  for install in ${installs}; do
    curl -o - ${BASE_URL}/lib/install/${install}.sh?`date '+%s'` | bash
  done
}

call_deps() {
  installs=`eval 'echo $'${1}'_installs'`
  deps=`eval 'echo $'${1}'_deps'`
  for install in ${deps}; do
    curl -o - ${BASE_URL}/lib/install/${install}.sh?`date '+%s'` | bash
  done
}

exec_do _mkdir ${USER_PREFIX}
exec_do _mkdir ${BIN_DIR}
exec_do _mkdir ${SRC_DIR}

# m4
export packages_m4=
export m4_version=1.4.17
export m4_installs=m4
export m4_deps=

# make
export packages_make=
export make_version=3.82
export make_installs=make
export make_deps=

# autoconf
export packages_autoconf=
export autoconf_version=2.69
export autoconf_installs=autoconf
export autoconf_deps=m4

# git
export packages_git=
export git_version=1.8.4
export git_installs=git
export git_deps=autoconf

