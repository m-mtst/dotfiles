export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
export GEM_HOME="$HOME/.gem/ruby/2.1.0"
export RUBYLIB=$GEM_HOME
export LANG="ja_JP.UTF8"
export LC_ALL=$LANG
export LANGUAGE=$LANG
export JRUBY_OPTS="--1.9"
export EDITOR="vim"

path=(
  $path
  $HOME/.gem/ruby/2.1.0/bin(N-/)
  $HOME/ruby_trunk/bin(N-/)
)
