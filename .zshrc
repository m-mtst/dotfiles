autoload -U colors
colors
autoload -Uz compinit
compinit
zstyle ':completion:*' list-colors "${LS_COLORS}" # 補完候補のカラー表示
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*:default' menu select=1 # 補完候補を矢印キーで選択
zstyle ':completion:history-words:*' list no 
zstyle ':completion:history-words:*' menu yes
zstyle ':completion:history-words:*' remove-all-dups yes
setopt listpacked #補完リストを詰めて表示
setopt hist_ignore_all_dups # 既にヒストリにあるコマンド行は古い方を削除
setopt auto_cd # cd入力いらず
#setopt auto_pushd # ディレクトリの一覧表示
setopt nolistbeep # 補完時にbeepしない
setopt nonomatch
setopt print_exit_value # 戻り値が0以外の場合終了コードを表示
setopt auto_param_slash # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs
setopt auto_param_keys # カッコの対応などを自動的に補完
setopt list_types # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt extended_history # ヒストリに実行時間も保存する
setopt rm_star_wait # 10 秒間反応しなくなり、頭を冷ます時間が与えられる
typeset -U path # $PATHの重複排除

# cdのたびにls
if [[ `uname` = "Darwin" ]]; then
  function chpwd() { gls --color=auto }
else
  function chpwd() { ls --color=auto }
fi

HISTSIZE=100
SAVEHIST=100

PROMPT="%B%(?.%F{green}.%F{red})%~%#%f%b "

# http://d.hatena.ne.jp/mollifier/20090814/p1
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*' formats '[%b]%c%u'
zstyle ':vcs_info:*' actionformats '[%b|%a]%c%u'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%F{green}%1(v|%1v|)@${HOST}%f"

bindkey -d
bindkey '\e[1~' beginning-of-line #Home,Endキーを動作させる
bindkey '\e[4~' end-of-line 
#bindkey '^h' zaw-history

alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"
alias grep="grep --color=auto -EIn --exclude='tags'"
alias tmux="tmux -2 -u"
alias tl="tmux ls"
alias tn="tmux new -s"
alias ta="tmux a -d -t"
alias vim="vim -p"
alias vi="vim"
alias v="vi"
if [ `uname` = "Darwin" ]; then
  alias ls="gls --color=auto"
else
  alias ls="ls --color=auto"
fi
alias ll="ls -l"
alias lhl="ls -hl"
alias df="df -Th"
alias r=ruby
alias p=python
alias sl=ls
alias be="bundle exec"
alias py="python"

# typo
alias eixt="exit"
alias exti="exit"
alias iv="vi"

# git
alias g="git"
alias gs="git status"
alias gc="git checkout"
alias gb="git branch"
alias gd="git diff"
alias gwd"git diff --word-diff"
alias gdd="gd develop"
alias gdm="gd master"
alias gdt="gd trunk"
alias gl="git log"
alias glp="git log -p"
alias gp="git pull --rebase"
alias gr="git remote -v"

alias -s txt=cat
alias -s rb=ruby
alias -s pl=perl
alias -s py=python
alias -s yml=vim
alias -s git="git clone"
alias -s go="go run"

if which apt-get > /dev/null 2>&1; then
  alias diff="colordiff -u" # unified format
else
  alias diff="diff -u" # unified format
fi 

if which pygmentize > /dev/null 2>&1; then
  alias ccat='pygmentize -O style=vim -f console256 -g' # colorized cat
fi

if which apt-get > /dev/null 2>&1; then
  alias as="apt-cache search"
  alias ai="sudo apt-get install"
  alias ar="sudo apt-get autoremove"
  alias au="sudo apt-get update && sudo apt-get dist-upgrade && ar -y"
fi

if which htop > /dev/null 2>&1; then
  alias top="htop"
fi

if which bundle > /dev/null 2>&1; then
  alias jbundle="jruby -S bundle"
fi

if which jwhois > /dev/null 2>&1; then
  # whoisの文字化け回避
  function whois() {
    jwhois $* | iconv -f ISO-2022-JP -t UTF-8
  }
fi

# Gitのルートディレクトリへ簡単に移動できるようにする関数
# http://qiita.com/ponko2@github/items/d5f45b2cf2326100cdbc
function root() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    cd `pwd`/`git rev-parse --show-cdup`
  fi
}

function we() {
  wget $1
  tar -xvf $(basename $1)
}

# crontabの-eを禁止, -rは確認を強制
function crontab() {
  if [[ $1 = -e ]]; then
    echo "\"crontab -e\" is dangerous and strictly prohibited."
    echo "Use \"crontab file\"."
    return 1
  elif [[ $1 = -r ]]; then
    command crontab -ri
  else
    command crontab $@
  fi
}

if [[ -f ~/.tmuxinator/tmuxinator.zsh ]]; then
  source ~/.tmuxinator/tmuxinator.zsh
fi

if [[ `uname` != "Darwin" ]]; then
  AGENT_SOCK_FILE="/tmp/ssh-agent-$USER"
  SSH_AGENT_FILE="$HOME/.ssh-agent-info"
  if test $SSH_AUTH_SOCK ; then
    if [[ $SSH_AUTH_SOCK != $AGENT_SOCK_FILE ]] ; then
      ln -sf $SSH_AUTH_SOCK $AGENT_SOCK_FILE
      export SSH_AUTH_SOCK=$AGENT_SOCK_FILE
    fi
  else
    if [[ -f $SSH_AGENT_FILE ]]; then
      source $SSH_AGENT_FILE
    else
      ssh-agent > $SSH_AGENT_FILE
      source $SSH_AGENT_FILE
      ssh-add
    fi
  fi
fi

if [[ `uname` = "Darwin" ]]; then
  if [[ -e "$HOME/Downloads/dircolors-solarized" ]]; then
    eval $(gdircolors $HOME/Downloads/dircolors-solarized/dircolors.ansi-universal)
  fi
else
  if [[ -e "$HOME/download/dircolors-solarized" ]]; then
    eval $(dircolors $HOME/download/dircolors-solarized/dircolors.ansi-universal)
  fi
fi

if [[ -n "$LS_COLORS" ]]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^h' peco-select-history

source ~/.zplug/init.zsh

#zplug "zsh-users/zsh-syntax-highlighting"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

ls
