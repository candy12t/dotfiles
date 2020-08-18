#! /bin/bash

for f in $(cd $(dirname $0); pwd)/.??*
do
	echo "$f"
	ln -s $f $HOME/
done
