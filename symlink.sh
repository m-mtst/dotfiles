#!/bin/sh
cd $(dirname $0)
for dotfile in `find .* -maxdepth 0`; do
  if [ $dotfile != '.' ] && [ $dotfile != '..' ] && [ $dotfile != '.git' ]
  then
    ln -Ffs "$PWD/$dotfile" $HOME
  fi
done
