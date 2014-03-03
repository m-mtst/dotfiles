#!/bin/sh
source_path=`readlink -f $0`
source_dir=`dirname $source_path`
echo $source_path > /var/log/foo.log
cd $source_dir
for dotfile in `find .* -maxdepth 0`; do
  if [ $dotfile != '.' ] && [ $dotfile != '..' ] && [ $dotfile != '.git' ]
  then
    ln -Ffs "$source_dir/$dotfile" $HOME
  fi
done
