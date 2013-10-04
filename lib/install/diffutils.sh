#!/bin/bash

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io/installer

if [ -z ${COMMON_SCRIPT} ]; then
  export COMMON_SCRIPT=`mktemp /tmp/XXXXXXXXXXXX`
  if ! curl -o ${COMMON_SCRIPT} ${BASE_URL}/lib/common.sh; then
    exit 1
  fi
fi
source ${COMMON_SCRIPT}

# install diffutils
CALLED=${TMP_DIR}/diffutils-${diffutils_version}
if [ -d ${CALLED} ]; then
  exit 0
else
  exec_do _mkdir ${CALLED}
fi
if [ ! -x ${BIN_DIR}/diffutils ]; then
  # check deps
  call_deps diffutils
  echo install diffutils: start
  pushd .
  cd ${TMP_DIR}
  curl -o - http://ftp.jaist.ac.jp/pub/GNU/diffutils/diffutils-${diffutils_version}.tar.gz | tar zxf -
  if [ ${diffutils_version} = "3.2" ]; then
    curl -o 1.patch ${BASE_URL}/patch/diffutils-3.2-no-gets.patch
    patch -p1 -d ./diffutils-${diffutils_version} < ./1.patch
  fi
  cd diffutils-${diffutils_version}
  ./configure --prefix=${SRC_DIR}/diffutils-${diffutils_version} > /dev/null \
    && make ${MAKEOPTS} > /dev/null \
    && make install > /dev/null
  [ $? -ne 0 ] && exit 1
  popd
  exec_do ln -s ${SRC_DIR}/diffutils-${diffutils_version}/bin/* ${BIN_DIR}
  echo install diffutils: finish
fi
