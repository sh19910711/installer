#!/bin/bash

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io/installer

if [ -z ${COMMON_SCRIPT} ]; then
  export COMMON_SCRIPT=`mktemp /tmp/XXXXXXXXXXXX`
  if ! curl -o ${COMMON_SCRIPT} ${BASE_URL}/lib/common.sh; then
    exit 1
  fi
fi
source ${COMMON_SCRIPT}

# install ruby
CALLED=${TMP_DIR}/ruby-${ruby_version}
if [ -d ${CALLED} ]; then
  exit 0
else
  exec_do _mkdir ${CALLED}
fi
if [ ! -x ${SRC_DIR}/rbenv-${rbenv_version}/versions/${ruby_version}/bin/ruby ]; then
  # check deps
  call_deps ruby
  echo install ruby: start
  pushd .
  cd ${TMP_DIR}
  rbenv install ${ruby_version} && rbenv global ${ruby_version}
  popd
  echo install ruby: finish
fi
