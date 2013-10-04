#!/bin/bash

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io/installer

if [ -z ${COMMON_SCRIPT} ]; then
  export COMMON_SCRIPT=`mktemp /tmp/XXXXXXXXXXXX`
  if ! curl -o ${COMMON_SCRIPT} ${BASE_URL}/lib/common.sh; then
    exit 1
  fi
fi
source ${COMMON_SCRIPT}

# install rbenv
CALLED=${TMP_DIR}/rbenv-${rbenv_version}
if [ -d ${CALLED} ]; then
  exit 0
else
  exec_do _mkdir ${CALLED}
fi
if [ ! -x ${SRC_DIR}/rbenv-${rbenv_version}/bin/rbenv ]; then
  # check deps
  call_deps rbenv
  echo install rbenv: start
  pushd .
  cd ${TMP_DIR}
  exec_do git clone https://github.com/sstephenson/rbenv.git ${SRC_DIR}/rbenv-${rbenv_version}
  exec_do git clone https://github.com/sstephenson/ruby-build.git ${SRC_DIR}/rbenv-${rbenv_version}/plugins/ruby-build
  ln -s ${SRC_DIR}/rbenv-${rbenv_version}/bin/rbenv ${BIN_DIR}/rbenv
  # config
  if [ ! -z ${BASH_VERSION} ]; then
    echo 'export RBENV_ROOT=$HOME/local/src/rbenv-'${rbenv_version} >> $HOME/.bash_profile
    echo 'eval "$(rbenv init -)"' >> $HOME/.bash_profile
  fi
  popd
  echo install rbenv: finish
fi
