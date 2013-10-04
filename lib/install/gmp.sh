#!/bin/bash

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io/installer

if [ -z ${COMMON_SCRIPT} ]; then
  export COMMON_SCRIPT=`mktemp /tmp/XXXXXXXXXXXX`
  if ! curl -o ${COMMON_SCRIPT} ${BASE_URL}/lib/common.sh; then
    exit 1
  fi
fi
source ${COMMON_SCRIPT}

# install gmp
CALLED=${TMP_DIR}/gmp-${gmp_version}
if [ -d ${CALLED} ]; then
  exit 0
else
  exec_do _mkdir ${CALLED}
fi
if [ ! -e ${INCLUDE_DIR}/gmp.h ]; then
  # check deps
  call_deps gmp
  echo install gmp: start
  pushd .
  cd ${TMP_DIR}
  curl -o - http://ftp.jaist.ac.jp/pub/GNU/gmp/gmp-${gmp_version}.tar.xz | tar Jxf -
  cd gmp-${gmp_version}
  ./configure --prefix=${SRC_DIR}/gmp-${gmp_version} > /dev/null \
    && make ${MAKEOPTS} > /dev/null \
    && make install > /dev/null
  [ $? -ne 0 ] && exit 1
  popd
  exec_do ln -s ${SRC_DIR}/gmp-${gmp_version}/lib/* ${LIB_DIR}
  exec_do ln -s ${SRC_DIR}/gmp-${gmp_version}/include/* ${INCLUDE_DIR}
  echo install gmp: finish
fi
