#!/bin/bash

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io/installer

if [ -z ${COMMON_SCRIPT} ]; then
  export COMMON_SCRIPT=`mktemp /tmp/XXXXXXXXXXXX`
  if ! curl -o ${COMMON_SCRIPT} ${BASE_URL}/lib/common.sh; then
    exit 1
  fi
fi
source ${COMMON_SCRIPT}

# check deps
call_deps coreutils

# install autoconf
if [ ! -x ${BIN_DIR}/coreutils ]; then
  echo install coreutils: start
  pushd .
  cd ${TMP_DIR}
  curl -o - http://ftp.jaist.ac.jp/pub/GNU/coreutils/coreutils-${coreutils_version}.tar.xz | tar Jxf -
  cd coreutils-${coreutils_version}
  ./configure --prefix=${SRC_DIR}/coreutils-${coreutils_version} > /dev/null \
    && make > /dev/null \
    && make install > /dev/null
  [ $? -ne 0 ] && exit 1
  popd
  exec_do ln -s ${SRC_DIR}/coreutils-${coreutils_version}/bin/* ${BIN_DIR}
  echo install coreutils: finish
fi