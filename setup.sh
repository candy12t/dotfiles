#! /bin/bash

set -eu

script_home="$(cd $(dirname $0); pwd)"
cd ${script_home}

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue

  if [ -e "$HOME/$f" ]; then
    unlink $HOME/$f
  fi
  ln -s $(cd $(dirname $0); pwd)/$f $HOME/$f
  echo "created symbolic link: $f"
done
