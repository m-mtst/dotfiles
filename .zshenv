export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
export GEM_HOME="$HOME/.gem/ruby/2.1.0"
export RUBYLIB=$GEM_HOME
export LANG="ja_JP.UTF8"
export LC_ALL=$LANG
export LANGUAGE=$LANG
export JRUBY_OPTS="--1.9"
export EDITOR="vim"

# $LS_COLORS
if [ ! "$LS_COLORS" -a -f /etc/DIR_COLORS ]; then
  eval $(dircolors /etc/DIR_COLORS)
fi

path=(
  $HOME/.gem/ruby/2.1.0/bin(N-/)
  /usr/local/bin
  $path
  $HOME/ruby_trunk/bin(N-/)
)
