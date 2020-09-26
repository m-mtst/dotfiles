if which tmux 2>&1 >/dev/null; then
  test -z "$TMUX" && (tmux -2 -u attach || tmux -2 -u new-session)
fi
