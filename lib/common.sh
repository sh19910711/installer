#!/bin/sh

echo common.sh: start

export USER_PREFIX=${HOME}/local
export BIN_DIR=${USER_PREFIX}/bin
export SRC_DIR=${USER_PREFIX}/src
export TMP_DIR=`mktemp -d /tmp/XXXXXXXXXXXXXXXXXXXXXXXX`

_mkdir() {
  if [ ! -d $1 ]; then
    mkdir $1
  fi
}

exec_do() {
  [ ! -z ${FLAG_DEBUG_MODE} ] && echo [exec_do] $@
  $@
}

exec_do _mkdir ${USER_PREFIX}
exec_do _mkdir ${BIN_DIR}
exec_do _mkdir ${SRC_DIR}

