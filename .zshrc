autoload -U colors
colors
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*:default' menu select=1 # 補完候補を矢印キーで選択
setopt listpacked #補完リストを詰めて表示
setopt hist_ignore_all_dups # 既にヒストリにあるコマンド行は古い方を削除
setopt auto_cd # cd入力いらず
setopt auto_pushd # ディレクトリの一覧表示
setopt nolistbeep # 補完時にbeepしない
setopt nonomatch
setopt correct
setopt print_exit_value # 戻り値が0以外の場合終了コードを表示
setopt auto_param_slash # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_keys # カッコの対応などを自動的に補完
setopt list_types # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt extended_history   # ヒストリに実行時間も保存する

function chpwd() { ls --classify --color=auto } # cdのたびにls

HISTSIZE=100
SAVEHIST=100

PROMPT="%B%(?.%F{green}.%F{red})%~%#%f%b "
PROMPT2="%_%%"
SPROMPT="%r is correct? [n,y,a,e]: "

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

bindkey '\e[1~' beginning-of-line #Home,Endキーを動作させる
bindkey '\e[4~' end-of-line 
alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"
alias tmux="tmux -2 -u"
alias tl="tmux ls"
alias tn="tmux new -s"
alias ta="tmux a -t"
alias tk="tmux kill-session -t"
alias jbundle="jruby -S bundle"
alias vim="vim -p"
alias vi="vim"
alias iv="vi"
alias ls="ls --classify --color=auto"
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
alias -s ym=vim

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

# Gitのルートディレクトリへ簡単に移動できるようにする関数
# http://qiita.com/ponko2@github/items/d5f45b2cf2326100cdbc
function root() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    cd `pwd`/`git rev-parse --show-cdup`
  fi
}

# whoisの文字化け回避
function whois() {
  jwhois $* | iconv -f ISO-2022-JP -t UTF-8
}

ls
