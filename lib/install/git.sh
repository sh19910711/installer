#!/bin/bash

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io/installer

if [ -z ${COMMON_SCRIPT} ]; then
  export COMMON_SCRIPT=`mktemp /tmp/XXXXXXXXXXXX`
  if ! curl -o ${COMMON_SCRIPT} ${BASE_URL}/lib/common.sh; then
    exit 1
  fi
fi
source ${COMMON_SCRIPT}

# install git
CALLED=${TMP_DIR}/git-${git_version}
if [ -d ${CALLED} ]; then
  exit 0
else
  exec_do _mkdir ${CALLED}
fi
# https://github.com/git/git/archive/v1.8.4.tar.gz
if [ ! -x ${BIN_DIR}/git ]; then
  # check deps
  call_deps git
  echo install git: start
  pushd .
  cd ${TMP_DIR}
  wget -O - https://github.com/git/git/archive/v${git_version}.tar.gz | tar zxf -
  cd git-${git_version}
  autoconf
  ./configure --prefix=${SRC_DIR}/git-${git_version} > /dev/null \
    && make > /dev/null \
    && make install > /dev/null
  [ $? -ne 0 ] && exit 1
  ln -s ${SRC_DIR}/git-${git_version}/bin/* ${BIN_DIR}
  popd
  echo install git: finish
fi
