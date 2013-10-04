#!/bin/bash

[ -z ${BASE_URL} ] && BASE_URL=http://sh19910711.github.io/installer
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

usage() {
  echo
  echo "Usage: curl -o - ${BASE_URL}/install.sh | PACKAGE_NAME={PACKAGE_NAME} sh"
  echo
  echo "packages"
  for package in ${!packages_*}; do
    # Package name
    package_name=${package#*_}
    echo "    name: ${package_name}"
    # Version
    version=`eval 'echo $'${package_name}'_version'`
    echo "        version: ${version}"
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

if [  ${PACKAGE_NAME} = "usage" ]; then
  usage
else
  call_installer ${PACKAGE_NAME}
fi

