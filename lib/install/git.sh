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
call_deps git

# install git
# https://github.com/git/git/archive/v1.8.4.tar.gz
if [ ! -x ${BIN_DIR}/git ]; then
  echo install git: start
  pushd .
  cd ${TMP_DIR}
  wget -O - https://github.com/git/git/archive/v${git_version}.tar.gz | tar zxf -
  cd git-${git_version}
  autoconf
  ./configure --prefix=${SRC_DIR}/git-${git_version} \
    && make \
    && make install
  ln -s ${SRC_DIR}/git-${git_version}/bin/* ${BIN_DIR}
  popd
  echo install git: finish
fi
