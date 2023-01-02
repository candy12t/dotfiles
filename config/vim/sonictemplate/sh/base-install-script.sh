#! /bin/bash

set -eu

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

version=0.1
tarball="sample-${version}.tar.gz"
archivedir="sample-${version}"

prefix="/usr/local"

if [ ! -f "${tarball}" ]; then
  wget "url" -O "${tarball}"
fi

if [ -e "${archivedir}" ]; then
  rm -rf "${archivedir}"
fi

tar zxvf "${tarball}"
cd "${archivedir}"

./configure \
  --prefix="${prefix}"

make && make install

rm -rf "${archivedir}"

exit 0;
