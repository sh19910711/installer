#!/bin/bash

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io/installer

if [ -z ${COMMON_SCRIPT} ]; then
  export COMMON_SCRIPT=`mktemp /tmp/XXXXXXXXXXXX`
  if ! curl -o ${COMMON_SCRIPT} ${BASE_URL}/lib/common.sh; then
    exit 1
  fi
fi
source ${COMMON_SCRIPT}

# install make
CALLED=${TMP_DIR}/make-${make_version}
if [ -d ${CALLED} ]; then
  exit 0
else
  exec_do _mkdir ${CALLED}
fi
if [ ! -x ${BIN_DIR}/make ]; then
  # check deps
  call_deps make
  echo install make: start
  pushd .
  cd ${TMP_DIR}
  # http://ftp.jaist.ac.jp/pub/GNU/make/make-3.82.tar.gz
  curl -o - http://ftp.jaist.ac.jp/pub/GNU/make/make-${make_version}.tar.gz | tar zxf -
  cd make-${make_version}
  ./configure --prefix=${SRC_DIR}/make-${make_version} > /dev/null \
    && make ${MAKEOPTS} > /dev/null \
    && make install > /dev/null
  [ $? -ne 0 ] && exit 1
  popd
  exec_do ln -s ${SRC_DIR}/make-${make_version}/bin/* ${BIN_DIR}
  echo install make: finish
fi
