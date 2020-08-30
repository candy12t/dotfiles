#!/bin/bash

for f in .??*
do
	[[ "$f" == ".git" ]] && continue
	[[ "$f" == ".DS_Store" ]] && continue

	echo "$f"
	unlink $HOME/$f
	ln -s $(cd $(dirname $0); pwd)/$f $HOME/$f
done

chsh -s `which zsh`
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
curl -fsSL https://starship.rs/install.sh | bash
