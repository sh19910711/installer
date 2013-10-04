#!/bin/bash

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io/installer

if [ -z ${COMMON_SCRIPT} ]; then
  export COMMON_SCRIPT=`mktemp /tmp/XXXXXXXXXXXX`
  if ! curl -o ${COMMON_SCRIPT} ${BASE_URL}/lib/common.sh; then
    exit 1
  fi
fi
source ${COMMON_SCRIPT}

# install m4
CALLED=${TMP_DIR}/m4-${m4_version}
if [ -d ${CALLED} ]; then
  exit 0
else
  exec_do _mkdir ${CALLED}
fi
if [ ! -x ${BIN_DIR}/m4 ]; then
  # check deps
  call_deps m4
  echo install m4: start
  pushd .
  cd ${TMP_DIR}
  curl -o - http://ftp.jaist.ac.jp/pub/GNU/m4/m4-${m4_version}.tar.gz | tar zxf -
  cd m4-${m4_version}
  ./configure --prefix=${SRC_DIR}/m4-${m4_version} > /dev/null \
    && make > /dev/null \
    && make install > /dev/null
  [ $? -ne 0 ] && exit 1
  popd
  exec_do ln -s ${SRC_DIR}/m4-${m4_version}/bin/* ${BIN_DIR}
  echo install m4: finish
fi
