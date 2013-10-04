#!/bin/sh

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io

if [ -z ${COMMON_SCRIPT} ]; then
  export COMMON_SCRIPT=`mktemp /tmp/XXXXXXXXXXXX`
  if ! curl -o ${COMMON_SCRIPT} ${BASE_URL}/lib/common.sh; then
    exit 1
  fi
fi
source ${COMMON_SCRIPT}

# install autoconf
# http://ftp.jaist.ac.jp/pub/GNU/autoconf/autoconf-2.69.tar.gz
if [ ! -x ${BIN_DIR}/autoconf ]; then
  echo install autoconf: start
  pushd .
  exec_do cd ${TMP_DIR}
  curl -o - http://ftp.jaist.ac.jp/pub/GNU/autoconf/autoconf-2.69.tar.gz | tar zxf -
  exec_do cd autoconf-*
  ./configure --prefix=${SRC_DIR}/autoconf-2.69 \
    && make \
    && make install
  popd
  exec_do ln -s ${SRC_DIR}/autoconf-2.69/bin/* ${BIN_DIR}
  echo install autoconf: finish
fi
