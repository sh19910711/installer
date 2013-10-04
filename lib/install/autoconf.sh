#!/bin/bash

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io/installer

if [ -z ${COMMON_SCRIPT} ]; then
  export COMMON_SCRIPT=`mktemp /tmp/XXXXXXXXXXXX`
  if ! curl -o ${COMMON_SCRIPT} ${BASE_URL}/lib/common.sh; then
    exit 1
  fi
fi
source ${COMMON_SCRIPT}

# install autoconf
CALLED=${TMP_DIR}/autoconf-${autoconf_version}
if [ -d ${CALLED} ]; then
  exit 0
else
  exec_do _mkdir ${CALLED}
fi
PREFIX=${SRC_DIR}/autoconf-${autoconf_version}
if [ ! -x ${PREFIX}/bin/autoconf ]; then
  # check deps
  call_deps autoconf
  echo install autoconf: start
  pushd .
  exec_do cd ${TMP_DIR}
  curl -o - http://ftp.jaist.ac.jp/pub/GNU/autoconf/autoconf-${autoconf_version}.tar.gz | tar zxf -
  exec_do cd autoconf-${autoconf_version}
  ./configure --prefix=${PREFIX} > /dev/null \
    && make > /dev/null \
    && make install > /dev/null
  [ $? -ne 0 ] && exit 1
  popd
  exec_do ln -s ${PREFIX}/bin/* ${BIN_DIR}
  echo install autoconf: finish
fi
