export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
export GEM_HOME="$HOME/.gem/ruby/2.6.0"
export LANG="ja_JP.UTF-8"
export LC_ALL=$LANG
export LC_CTYPE=$LANG
export EDITOR="vim"
export LESSCHARSET=utf-8 # Macでgit logした時の文字化け対策
export GOROOT=/usr/local/go
export GOPATH=$HOME/gopkg
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/m-pipe/gcp-key.json
export CLOUDSDK_PYTHON=python3

path=(
  /usr/local/go/bin(N-/)
  /usr/local/opt/libpq/bin(N-/)
  /usr/local/opt/curl/bin(N-/)
  $GOROOT/bin(N-/)
  $GOPATH/bin(N-/)
  $HOME/.gem/ruby/2.7.0/bin(N-/)
  $HOME/.cargo/bin(N-/)
  $path
  $HOME/ruby_trunk/bin(N-/)
  $HOME/bin(N-/)
  $HOME/.yarn/bin(N-/)
  $HOME/webrtc/depot_tools(N-/)
)
