export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
export GEM_HOME="$HOME/.gem/ruby/3.0.0"
export LANG="ja_JP.UTF-8"
export LC_ALL=$LANG
export LC_CTYPE=$LANG
export EDITOR="vim"
export GOROOT=/usr/local/go
export GOPATH=$HOME/gopkg
export CLOUDSDK_PYTHON=python3
export PKG_CONFIG_PATH="/Library/Frameworks/GStreamer.framework/Versions/1.0/lib/pkgconfig"

if [[ `uname` = "Darwin" ]]; then
  export DOCKER_HOST="ssh://misc"
  export GOOGLE_APPLICATION_CREDENTIALS=$HOME/m-pipe/gcp-key.json
  export LESSCHARSET=utf-8 # Macでgit logした時の文字化け対策
fi

path=(
  /usr/local/go/bin(N-/)
  /usr/local/opt/libpq/bin(N-/)
  /usr/local/opt/curl/bin(N-/)
  /Library/Frameworks/GStreamer.framework/Commands(N-/)
  $GOROOT/bin(N-/)
  $GOPATH/bin(N-/)
  $HOME/.gem/ruby/3.0.0/bin(N-/)
  $HOME/.cargo/bin(N-/)
  $path
  $HOME/ruby_trunk/bin(N-/)
  $HOME/bin(N-/)
  $HOME/.yarn/bin(N-/)
  $HOME/webrtc/depot_tools(N-/)
)
