#! /bin/bash

set -eu

script_home="$(cd $(dirname $0); pwd)"
cd "${script_home}"

rm .brewfile
brew bundle dump --file=.brewfile

exit 0;
