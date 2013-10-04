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
if [ ! -x ${BIN_DIR}/gettext ]; then
  # check deps
  call_deps gettext
  echo install gettext: start
  pushd .
  cd ${TMP_DIR}
  # http://ftp.jaist.ac.jp/pub/GNU/gettext/gettext-3.82.tar.gz
  curl -o - http://ftp.jaist.ac.jp/pub/GNU/gettext/gettext-${gettext_version}.tar.gz | tar zxf -
  cd gettext-${gettext_version}
  ./configure \
    --prefix=${SRC_DIR}/gettext-${gettext_version} \
    --enable-shared \
    --enable-relocatable \
    --disable-debug \
    --disable--dependency-tracking \
    --disable-java \
    --disable-csharp \
    --without-emacs \
    > /dev/null \
    && make > /dev/null \
    && make install > /dev/null
  [ $? -ne 0 ] && exit 1
  popd
  exec_do ln -s ${SRC_DIR}/gettext-${gettext_version}/bin/* ${BIN_DIR}
  echo install gettext: finish
fi
