#!/bin/bash

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io/installer

if [ -z ${COMMON_SCRIPT} ]; then
  export COMMON_SCRIPT=`mktemp /tmp/XXXXXXXXXXXX`
  if ! curl -o ${COMMON_SCRIPT} ${BASE_URL}/lib/common.sh; then
    exit 1
  fi
fi
source ${COMMON_SCRIPT}

# install tar
CALLED=${TMP_DIR}/tar-${tar_version}
if [ -d ${CALLED} ]; then
  exit 0
else
  exec_do _mkdir ${CALLED}
fi
if [ ! -x ${BIN_DIR}/tar ]; then
  # check deps
  call_deps tar
  echo install tar: start
  pushd .
  exec_do cd ${TMP_DIR}
  curl -o - http://ftp.jaist.ac.jp/pub/GNU/tar/tar-${tar_version}.tar.gz | tar zxf -
  # patch.1
  if [ ${tar_version} = "1.26" ]; then
    exec_do curl -o 1.patch http://git.buildroot.net/buildroot/plain/package/tar/tar-1.26-no-gets.patch
    patch -p1 -d tar-${tar_version} < ./1.patch
  fi
  exec_do cd tar-${tar_version}
  ./configure --prefix=${SRC_DIR}/tar-${tar_version} > /dev/null \
    && make ${MAKEOPTS} > /dev/null \
    && make install > /dev/null
  [ $? -ne 0 ] && exit 1
  popd
  exec_do ln -s ${SRC_DIR}/tar-${tar_version}/bin/* ${BIN_DIR}
  echo install tar: finish
fi
