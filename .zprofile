# TMUX
if false; then
  if which tmux 2>&1 >/dev/null; then
      #if not inside a tmux session, and if no session is started, start a new session
      test -z "$TMUX" && (tmux -2 -u attach || tmux -2 -u new-session)
  fi
fi

# ssh-agent
SOCK="/tmp/ssh-agent-$USER"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f $SOCK
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
  fi
