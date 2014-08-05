#!/bin/sh
source_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
for dotfile in `find .* -maxdepth 0`; do
  if [ $dotfile != '.' ] && [ $dotfile != '..' ] && [ $dotfile != '.git' ]
  then
    ln -Ffs "$source_dir/$dotfile" $HOME
  fi
done
