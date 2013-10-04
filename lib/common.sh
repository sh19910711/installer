#!/bin/sh

echo common.sh: start

export USER_PREFIX=${HOME}/local
export BIN_DIR=${USER_PREFIX}/bin
export INCLUDE_DIR=${USER_PREFIX}/include
export LIB_DIR=${USER_PREFIX}/lib
export SRC_DIR=${USER_PREFIX}/src
[ -z ${TMP_DIR} ] && export TMP_DIR=`mktemp -d /tmp/XXXXXXXXXXXXXXXXXXXXXXXX`
export PATH=${BIN_DIR}:${PATH}

_mkdir() {
  if [ ! -d $1 ]; then
    mkdir $1
  fi
}

exec_do() {
  [ ! -z ${FLAG_DEBUG_MODE} ] && echo [exec_do] $@
  $@
}

_rehash() {
  if [ ! -z "${BASH_VERSION}" ]; then
    hash -r
  else
    rehash
  fi
}

call_installer() {
  installs=`eval 'echo $'${1}'_installs'`
  deps=`eval 'echo $'${1}'_deps'`
  for install in ${installs}; do
    echo "    dep: ${install}"
    curl -o - ${BASE_URL}/lib/install/${install}.sh?`date '+%s'` | bash
    exec_do _rehash
  done
}

call_deps() {
  installs=`eval 'echo $'${1}'_installs'`
  deps=`eval 'echo $'${1}'_deps'`
  for install in ${deps}; do
    echo "    dep: ${install}"
    curl -o - ${BASE_URL}/lib/install/${install}.sh?`date '+%s'` | bash
    exec_do _rehash
  done
}

exec_do _mkdir ${USER_PREFIX}
exec_do _mkdir ${BIN_DIR}
exec_do _mkdir ${SRC_DIR}
exec_do _mkdir ${LIB_DIR}
exec_do _mkdir ${INCLUDE_DIR}

# all
export packages_all=
export all_version=1.4.17
export all_installs='
m4
make
gettext
autoconf
git
tar
coreutils
curl
patch
ruby
'
export all_deps=''

# m4
export packages_m4=
export m4_version=1.4.17
export m4_installs='m4'
export m4_deps='make'

# rbenv
export packages_rbenv=
export rbenv_version=0.4.0
export rbenv_installs='rbenv'
export rbenv_deps='git make'

# ruby
export packages_ruby=
export ruby_version=2.0.0-p247
export ruby_installs='ruby'
export ruby_deps='rbenv'

# diffutils
export packages_diffutils=
export diffutils_version=3.2
export diffutils_installs='diffutils'
export diffutils_deps='make'

# gmp
export packages_gmp=
export gmp_version=5.1.3
export gmp_installs='gmp'
export gmp_deps='tar make'

# patch
export packages_patch=
export patch_version=2.7.1
export patch_installs='patch'
export patch_deps='diffutils make'

# tar
export packages_tar=
export tar_version=1.26
export tar_installs='tar'
export tar_deps='diffutils patch curl make'

# curl
export packages_curl=
export curl_version=7.32.0
export curl_installs='curl'
export curl_deps='make'

# coreutils
export packages_coreutils=
export coreutils_version=8.21
export coreutils_installs='coreutils'
export coreutils_deps='tar make'

# make
export packages_make=
export make_version=3.82
export make_installs='make'
export make_deps=''

# gettext
export packages_gettext=
export gettext_version=0.18.3.1
export gettext_installs='gettext'
export gettext_deps=''

# autoconf
export packages_autoconf=
export autoconf_version=2.69
export autoconf_installs='autoconf'
export autoconf_deps='make m4'

# git
export packages_git=
export git_version=1.8.4
export git_installs='git'
export git_deps='make autoconf gettext coreutils'

