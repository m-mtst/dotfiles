autoload -U colors
colors
autoload -U compinit
compinit
zstyle ':completion:*' list-colors "${LS_COLORS}" # 補完候補のカラー表示
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*:default' menu select=1 # 補完候補を矢印キーで選択
setopt listpacked #補完リストを詰めて表示
setopt hist_ignore_all_dups # 既にヒストリにあるコマンド行は古い方を削除
setopt auto_cd # cd入力いらず
setopt auto_pushd # ディレクトリの一覧表示
setopt nolistbeep # 補完時にbeepしない
setopt nonomatch
#setopt correct
setopt print_exit_value # 戻り値が0以外の場合終了コードを表示
setopt auto_param_slash # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_keys # カッコの対応などを自動的に補完
setopt list_types # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt extended_history   # ヒストリに実行時間も保存する
setopt rm_star_wait # 10 秒間反応しなくなり、頭を冷ます時間が与えられる

# cdのたびにls
if [ `uname` = "Darwin" ]; then
  function chpwd() { ls -vG } 
else
  function chpwd() { ls --color=auto } 
fi

HISTSIZE=100
SAVEHIST=100

PROMPT="%B%(?.%F{green}.%F{red})%~%#%f%b "
PROMPT2="%_%%"
SPROMPT="%r is correct? [n,y,a,e]: "

#zshプロンプトにモード表示####################################
function zle-line-init zle-keymap-select {
  case $KEYMAP in
    vicmd)
    PROMPT="%B%F{blue}%~%#%f%b "
    ;;
    main|viins)
    PROMPT="%B%(?.%F{green}.%F{red})%~%#%f%b "
    ;;
  esac
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

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
RPROMPT="%1(v|%F{green}%1v%f|)"

# C-^ で一つ上のディレクトリへ
function cdup() {
  echo
  cd ..
  zle reset-prompt
}

#bindkey -v # vim mode
bindkey '\e[1~' beginning-of-line #Home,Endキーを動作させる
bindkey '\e[4~' end-of-line 
zle -N cdup
bindkey '^^' cdup

alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"
alias grep="grep --color=auto -EIn --exclude='tags'"
alias tmux="tmux -2 -u"
alias tl="tmux ls"
alias tn="tmux new -s"
alias ta="tmux a -t"
alias tk="tmux kill-session -t"
alias vim="vim -p"
alias vi="vim"
alias iv="vi"
if [ `uname` = "Darwin" ]; then
  alias ls="ls -vG"
else
  alias ls="ls --color=auto"
fi
alias ll="ls -l"
alias lhl="ls -h -l"
alias df="df -h"
alias gs="git status"
alias gc="git checkout"
alias gb="git branch"
alias gd="git diff"
alias gdt="gd trunk"
alias gdm="gd master"
alias gl="git log"
alias gp="git pull --rebase"
alias gr="git remote -v"
alias gf="git flow"
alias be="bundle exec"
alias -s txt=cat
alias -s rb=ruby
alias -s pl=perl
alias -s yml=vim
alias -s git=git

function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.xz) tar xJvf $1;;
    *.zip) unzip $1;;
    *.gz) gzip -dc $1;;
    *.bz2) bzip2 -dc $1;;
    *.Z) uncompress $1;;
  esac
}

alias -s {tgz,tbz,gz,bz2,xz,zip,Z}=extract

if which pygmentize > /dev/null 2>&1; then
  alias ccat='pygmentize -O style=vim -f console256 -g' # colorized cat
fi

if which apt-get > /dev/null 2>&1; then
  alias as="apt-cache search"
  alias ai="sudo apt-get install"
  alias ar="sudo apt-get autoremove"
  alias au="sudo apt-get update && sudo apt-get dist-upgrade && ar"
fi

if which htop > /dev/null 2>&1; then
  alias top="htop"
fi

if which gpg > /dev/null 2>&1; then
  alias gpg="gpg2"
fi

if which git flow > /dev/null 2>&1; then
  source ~/.git-flow-completion.zsh
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



# crontabの-eを禁止, -rは確認を強制
function crontab() {
  if [ $1 = -e ]; then
    echo "\"crontab -e\" is dangerous and strictly prohibited."
    echo "Use \"crontab file\"."
    return 1
  elif [ $1 = -r ]; then
    command crontab -ri
  else
    command crontab $@
  fi
}

ls
