#! /bin/bash

set -eu

script_home="$(cd $(dirname $0); pwd)"
cd "${script_home}"

brew bundle install --file=.brewfile

exit 0;
