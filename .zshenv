export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
export GEM_HOME="$HOME/.gem/ruby/2.1.0"
export LANG="ja_JP.UTF-8"
export LC_ALL=$LANG
export LC_CTYPE=$LANG
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"
export JRUBY_OPTS="--1.9"
export EDITOR="vim"
export LESSCHARSET=utf-8 # Macでgit logした時の文字化け対策

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
