export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
export GEM_HOME="$HOME/.gem/ruby/2.5.0"
export LANG="ja_JP.UTF-8"
export LC_ALL=$LANG
export LC_CTYPE=$LANG
export EDITOR="vim"
export LESSCHARSET=utf-8 # Macでgit logした時の文字化け対策
export GOROOT=$HOME/go
export GOPATH=$HOME/gopkg

path=(
  $GOROOT/bin(N-/)
  $GOPATH/bin(N-/)
  $HOME/.gem/ruby/2.5.0/bin(N-/)
  $path
  $HOME/ruby_trunk/bin(N-/)
  $HOME/bin(N-/)
  $HOME/.yarn/bin(N-/)
  $HOME/arcanist/arcanist/bin(N-/)
)
