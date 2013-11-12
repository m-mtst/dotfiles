#Start tmux on every shell login
#https://wiki.archlinux.org/index.php/Tmux#Start_tmux_on_every_shell_login
if which tmux >& /dev/null; then
    #if not inside a tmux session, and if no session is started, start a new session
    test -z "$TMUX" && (tmux -2 -u attach || tmux -2 -u new-session)
fi

source ~/.start-ssh-agent.zsh
