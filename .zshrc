autoload -U colors
colors
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

setopt listpacked #補完リストを詰めて表示
setopt hist_ignore_all_dups # 既にヒストリにあるコマンド行は古い方を削除
#setopt share_history # 履歴の共有

setopt auto_cd # cd入力いらず
setopt auto_pushd # ディレクトリの一覧表示
setopt nolistbeep # 補完時にbeepしない
setopt nonomatch
setopt print_exit_value # 戻り値が0以外の場合終了コードを表示
setopt no_check_jobs # ジョブがあっても黙って終了する

function chpwd() { ls --color=auto } # cdのたびにls
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$HOME/.zsh-history # 履歴をファイルに保存する

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

source ~/.git-flow-completion.zsh

# Gitのルートディレクトリへ簡単に移動できるようにする関数
# http://qiita.com/ponko2@github/items/d5f45b2cf2326100cdbc
function root() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    cd `pwd`/`git rev-parse --show-cdup`
  fi
}

bindkey '\e[1~' beginning-of-line #Home,Endキーを動作させる
bindkey '\e[4~' end-of-line 
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export PATH=$HOME/.gem/ruby/2.0.0/bin:$PATH:$HOME/ruby_trunk/bin
export LANG=ja_JP.UTF8
export LC_ALL=$LANG
export LANGUAGE=$LANG
export JRUBY_OPTS="--1.9"
export EDITOR="vim"
alias h="history"
alias j="jobs -l"
alias q="exit"
alias r="ruby"
alias tmux="tmux -2 -u"
alias tl="tmux ls"
alias tn="tmux new -s"
alias ta="tmux a -t"
alias tk="tmux kill-session -t"
#alias "which"="type -a"
alias pd="popd"
alias apt-get="sudo apt-get"
alias as="apt-cache search"
alias ai="apt-get install"
alias ar="apt-get autoremove"
alias au="apt-get update && apt-get dist-upgrade && ar"
alias jbundle="jruby -S bundle"
alias top="htop"
alias vim="vim -p"
alias vi="vim"
alias ls="ls --color=auto"
alias lhl="ls -h -l"
alias ll="ls -l"
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
alias rm="rm -i"
alias mv="mv -i"
alias gpg="gpg2"
alias -s txt=cat
alias -s rb=ruby
alias -s pl=perl
alias -s sh=bash
alias -s git="git clone"
ls
