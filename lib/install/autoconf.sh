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
call_deps autoconf

# install autoconf
if [ ! -x ${BIN_DIR}/autoconf ]; then
  echo install autoconf: start
  pushd .
  exec_do cd ${TMP_DIR}
  curl -o - http://ftp.jaist.ac.jp/pub/GNU/autoconf/autoconf-${autoconf_version}.tar.gz | tar zxf -
  exec_do cd autoconf-*
  ./configure --prefix=${SRC_DIR}/autoconf-${autoconf_version} \
    && make \
    && make install
  popd
  exec_do ln -s ${SRC_DIR}/autoconf-${autoconf_version}/bin/* ${BIN_DIR}
  echo install autoconf: finish
fi
