export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
export GEM_HOME="$HOME/.gem/ruby/2.1.0"
export LANG="ja_JP.UTF-8"
export LC_ALL=$LANG
export LC_CTYPE=$LANG
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"
export JRUBY_OPTS="--1.9"
export EDITOR="vim"
export LESSCHARSET=utf-8 # Macでgit logした時の文字化け対策
export GOROOT=$HOME/go
export GOPATH=$HOME/gopkg
export ZSHENV_LOADED=1
export RUBYGEMS_GEMDEPS="-" # http://qiita.com/ymmtmdk/items/374d5319e8d5c9ab2ff4

path=(
  $GOROOT/bin(N-/)
  $GOPATH/bin(N-/)
  $HOME/.gem/ruby/2.2.0/bin(N-/)
  #/usr/local/bin
  $path
  $HOME/ruby_trunk/bin(N-/)
  $HOME/google-cloud-sdk/bin(N-/)
  $HOME/bin(N-/)
)
