# TMUX
if true; then
  if which tmux 2>&1 >/dev/null; then
      #if not inside a tmux session, and if no session is started, start a new session
      test -z "$TMUX" && (tmux -2 -u attach || tmux -2 -u new-session)
  fi
fi

export PATH="$HOME/.cargo/bin:$PATH"
