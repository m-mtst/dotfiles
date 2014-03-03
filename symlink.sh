#!/bin/sh
cd $_
for dotfile in `find .* -maxdepth 0`; do
  if [ $dotfile != '.' ] && [ $dotfile != '..' ] && [ $dotfile != '.git' ]
  then
    ln -Ffs "$_/$dotfile" $HOME
  fi
done
