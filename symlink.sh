#!/bin/sh

set -e -u -x

source_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
for dotfile in `find .* -maxdepth 0`; do
  if [ $dotfile != '.' ] && [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.config' ]
  then
    ln -Ffs "$source_dir/$dotfile" $HOME
  fi
done

for dotfile in `find .config/* -maxdepth 0`; do
  if [ $dotfile != '.' ] && [ $dotfile != '..' ]
  then
    ln -Ffs "$source_dir/$dotfile" "$HOME/.config"
  fi
done
