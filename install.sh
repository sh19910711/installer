#!/bin/sh

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io
[ -z ${PACKAGE_NAME} ] && PACKAGE_NAME=usage
echo BASE_URL: ${BASE_URL}
echo PACKAGE_NAME: ${PACKAGE_NAME}

if [ -z ${COMMON_SCRIPT} ]; then
  export COMMON_SCRIPT=`mktemp /tmp/XXXXXXXXXXXX`
  if ! curl -o ${COMMON_SCRIPT} ${BASE_URL}/lib/common.sh; then
    exit 1
  fi
fi
source ${COMMON_SCRIPT}

# autoconf
packages_autoconf=
autoconf_installs=autoconf
autoconf_deps=

sub_usage() {
  echo
  echo "Usage: curl -o - ${BASE_URL}/install.sh | PACKAGE_NAME={PACKAGE_NAME} sh"
  echo
  echo "packages"
  for package in ${!packages_*}; do
    # Package name
    package_name=${package#*_}
    echo "    name: ${package_name}"
    # Installers
    installs=`eval 'echo $'${package_name}'_installs'`
    for install in ${installs}; do
      echo "        installer: ${install}"
    done
    # Dependencies
    deps=`eval 'echo $'${package_name}'_deps'`
    for dep in ${deps}; do
      echo "        dep: ${dep}"
    done
    echo
  done
  echo
}

call_installer() {
  installs=`eval 'echo $'${PACKAGE_NAME}'_installs'`
  deps=`eval 'echo $'${PACKAGE_NAME}'_deps'`
  echo call_installer
  echo ${installs}
  echo ${deps}
  for install in ${deps}; do
    curl -o - ${BASE_URL}/lib/install/${install}.sh | sh
  done
  for install in ${installs}; do
    curl -o - ${BASE_URL}/lib/install/${install}.sh | sh
  done
}

call_installer

