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
call_deps m4

# install autoconf
if [ ! -x ${BIN_DIR}/m4 ]; then
  echo install m4: start
  pushd .
  curl -o - http://ftp.jaist.ac.jp/pub/GNU/m4/m4-${m4_version}.tar.gz | tar zxf -
  cd m4-${m4_version}
  ./configure --prefix=${SRC_DIR}/m4-${m4_version} \
    && make \
    && make install
  popd
  exec_do ln -s ${SRC_DIR}/m4-${m4_version}/bin/* ${BIN_DIR}
  echo install m4: finish
fi
