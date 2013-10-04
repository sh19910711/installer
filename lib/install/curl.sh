#!/bin/bash

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io/installer

if [ -z ${COMMON_SCRIPT} ]; then
  export COMMON_SCRIPT=`mktemp /tmp/XXXXXXXXXXXX`
  if ! curl -o ${COMMON_SCRIPT} ${BASE_URL}/lib/common.sh; then
    exit 1
  fi
fi
source ${COMMON_SCRIPT}

# install curl
CALLED=${TMP_DIR}/curl-${curl_version}
if [ -d ${CALLED} ]; then
  exit 0
else
  exec_do _mkdir ${CALLED}
fi
# https://curlhub.com/curl/curl/archive/v1.8.4.tar.gz
if [ ! -x ${BIN_DIR}/curl ]; then
  # check deps
  call_deps curl
  echo install curl: start
  pushd .
  cd ${TMP_DIR}
  wget -O - http://curl.haxx.se/download/curl-${curl_version}.tar.gz | tar zxf -
  cd curl-${curl_version}
  autoconf
  ./configure --prefix=${SRC_DIR}/curl-${curl_version} > /dev/null \
    && make > /dev/null \
    && make install > /dev/null
  [ $? -ne 0 ] && exit 1
  ln -s ${SRC_DIR}/curl-${curl_version}/bin/* ${BIN_DIR}
  popd
  echo install curl: finish
fi
