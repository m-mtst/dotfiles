#if [[ -z $ZSHENV_LOADED ]]; then
  #export ZSHENV_LOADED=1
  #export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
  export LANG="ja_JP.UTF-8"
  export LC_ALL=$LANG
  export LC_CTYPE=$LANG
  #export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"
  export EDITOR="vim"
  export LESSCHARSET=utf-8 # Macでgit logした時の文字化け対策
  #export GOROOT=$HOME/go
  export GOPATH=$HOME/gopkg

#  export OS_USERNAME="masaki"
#  export OS_PASSWORD="c0nnecti0n"
#  export OS_TENANT_NAME="AS4"
#  export OS_PROJECT_NAME="AS4"
#  export OS_AUTH_URL="http://otb.ft.nttcloud.net:5000/v2.0"
  export ANSIBLE_NOCOWS=1

  path=(
    /usr/local/sbin
    /usr/local/go/bin(N-/)
    $GOPATH/bin(N-/)
    $HOME/.gem/ruby/2.5.0/bin(N-/)
    $path
    $HOME/ruby_trunk/bin(N-/)
    $HOME/google-cloud-sdk/bin(N-/)
    $HOME/bin(N-/)
    $HOME/java/bin(N-/)
  )
#fi
