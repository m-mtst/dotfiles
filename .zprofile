# TMUX
if which tmux 2>&1 >/dev/null; then
    #if not inside a tmux session, and if no session is started, start a new session
    test -z "$TMUX" && (tmux -2 -u attach || tmux -2 -u new-session)
fi

if [ `uname` != "Darwin" ]; then
  AGENT_SOCK_FILE="/tmp/ssh-agent-$USER"
  SSH_AGENT_FILE="$HOME/.ssh-agent-info"
  if test $SSH_AUTH_SOCK ; then
    if [ $SSH_AUTH_SOCK != $AGENT_SOCK_FILE ] ; then
      ln -sf $SSH_AUTH_SOCK $AGENT_SOCK_FILE
      export SSH_AUTH_SOCK=$AGENT_SOCK_FILE
    fi
  else
    test -f $SSH_AGENT_FILE && source $SSH_AGENT_FILE
    if ! ssh-add -l >& /dev/null ; then
      ssh-agent > $SSH_AGENT_FILE
      source $SSH_AGENT_FILE
      ssh-add
    fi
  fi
  #source ~/.start-ssh-agent.zsh
fi
