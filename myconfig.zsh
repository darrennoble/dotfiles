## uses oh-my-zsh and powerline
# https://github.com/robbyrussell/oh-my-zsh
# https://github.com/powerline/powerline
# this file goes in ~/.oh-my-zsh/custom

powerline-daemon -q
[[ -f /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh ]] && . /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
[[ -f /usr/share/powerline/bindings/zsh/powerline.zsh ]] && . /usr/share/powerline/bindings/zsh/powerline.zsh

[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# make it so I can use ctrl-s in vim
stty -ixon

#setup color vars
#autoload colors zsh/terminfo
#if [[ "$terminfo[colors]" -ge 8 ]]; then
#  colors
#fi
#for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
#    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
#    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
#    (( count = $count + 1 ))
#done

#PR_NO_COLOR="%{$terminfo[sgr0]%}"

#my alias
#alias zyp='sudo zypper -v sh'
#alias apt-get='sudo apt-get'

#alias ls='ls --color'
#alias dir='ls -l'
#alias ll='ls -l'
#alias la='ls -la'
#alias l='ls -alF'
#alias ls-l='ls -l'

#alias o='less'
alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'
alias rd=rmdir
alias md='mkdir -p'

alias rscp='rsync -aP'
alias rsmv='rsync -aP --remove-source-files'

alias psgrp='ps ax o user,pid,%cpu,%mem,vsz,rss,tty,stat,start,time,comm,group,gid'

#alias pacman='sudo pacman'
alias pacman='sudo pacmatic'
alias pmupdate='sudo systemctl start reflector.service && /usr/bin/pacman -Sy'

#alias vim='nvim'
alias vi='vim'
alias svi='sudo vim'
vs () { vim -S ~/.vim/sessions/$* }

alias setbg='feh --bg-scale ~/.config/qtile/wallpaper.jpg'

alias tmux="tmux -2"

export EDITOR="vim"
export SHELL="/usr/bin/zsh"

[[ -f  /usr/share/LS_COLORS ]] && eval `dircolors -b /usr/share/LS_COLORS`

#user functions
export fpath=( ~/.zfunc "${fpath[@]}" )
autoload -Uz a
autoload -Uz extract_archive
autoload -Uz rn
autoload -Uz vg
autoload -Uz docker-ip

#path
#export JAVA_HOME=/opt/java8
export JAVA_HOME=/usr/lib/jvm/java-8-jdk
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
export GOROOT=/usr/lib/go
export GOPATH=~/dev/go
export PATH=~/bin:/usr/bin:$PATH:$GOPATH/bin:~/.gem/ruby/current/bin  #/sbin:/usr/sbin:
#export CLASSPATH=.:/usr/share/java/log4j.jar:/usr/share/java/mysql-connector-java.jar
export WINEARCH=win32
export WINEPREFIX=~/.wine32
export TERMINAL=terminator
export TERM=xterm-256color
export CONSTANTS_HOME=~/dev/vivint/Constants

#gpg-agent startup
gpg-connect-agent /bye
#envfile="$HOME/.gnupg/gpg-agent.env"
#if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
#    eval "$(cat "$envfile")"
#else
#    eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "$envfile")"
#fi
#export GPG_AGENT_INFO  # the env file does not contain the export statement
#export SSH_AUTH_SOCK   # enable gpg-agent for ssh

#ssh agent setup
#eval $(ssh-agent|grep -v "echo Agent pid")
#eval $(ssh-agent) > /dev/null
#ssh-add > /dev/null 2>&1
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

autoload -U zmv

#zsh auto complete init
autoload -U compinit
compinit

#zsh options
setopt  autocd INC_APPEND_HISTORY HIST_EXPIRE_DUPS_FIRST CORRECT PATH_DIRS prompt_subst histignoredups extended_glob

HISTSIZE=10000
HISTFILE=${HOME}/.zsh_history
SAVEHIST=5000

# History completion on pgup and pgdown
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[5~" history-beginning-search-backward-end
bindkey "^[[6~" history-beginning-search-forward-end

##prompt
#PR_CPU=
#PR_MEM=
#PR_SWAP=

#setTitle () {
#    if [[ ${TERM} == "screen-bce" || ${TERM} == "screen" ]]; then
#        print -Pn "\033k\033\134\033k$1\033\134"
#    else
#        print -Pn "\033]0;$1\007"
#        #print -Pn "\e]30;$1\a"
#    fi
#}

myTitlePrecmd () {
    title "%m:%20<..<%~%<<" "%n@%m (%40<..<%~%<<)"
#    setTitle "%n@%m (%40<..<%~%<<)"
#    PR_CPU=$(echo $(cat /proc/cpuinfo | grep --count MHz)x $(cat /proc/cpuinfo | grep MHz | cat -n | grep "  1" | sed -e's/[^:]*: \([0-9]*\).*/\1 MHz/'))
#    PR_NUM_CPUS=$(cat /proc/cpuinfo | grep --count MHz)
#    PR_LOAD=$(uptime | sed -e's/[^l]*[^:]*: \([^,]*\), \([^,]*\), \(.*\)/\1 \2 \3/')
#    PR_1ST_LOAD=$(uptime | sed -e's/[^l]*[^:]*: \([^,]*\), \([^,]*\), \(.*\)/\1/')
#    PR_LOAD_COLOR=$PR_YELLOW
#    if (( PR_NUM_CPUS * 2 < PR_1ST_LOAD )); then
#        PR_LOAD_COLOR=$PR_RED
#    elif (( $PR_NUM_CPUS > $PR_1ST_LOAD )); then
#        PR_LOAD_COLOR=$PR_GREEN
#    fi
#    PR_MEM=$(free -m | grep Mem | sed -e's/[^0-9]*\([0-9]*\)[ ]*\([0-9]*\)[ ]*\([0-9]*\).*/\1mb \/ \2mb  \/ \3mb/')
#    PR_SWAP=$(free -m | grep Swap | sed -e's/[^0-9]*\([0-9]*\)[ ]*\([0-9]*\)[ ]*\([0-9]*\).*/\1mb \/ \2mb  \/ \3mb/')
#    setprompt
}

myTitlePreexec () {
    local cmd=${1:gs/%/%%}
    local shortTitle=${cmd[(wr)^(*=*|sudo|ssh|mosh|python|python*|-*)]}

    title "%m:$shortTitle" "%n@%m - $cmd"
#    setTitle "%n@%m - $1"
}

precmd_functions+=(myTitlePrecmd)
preexec_functions+=(myTitlePreexec)

#setprompt() {
#    setopt prompt_subst
#
#    export PS1="
#$PR_BLUE$PR_BLUE$(echo [)$PR_NO_COLOR$PR_LIGHT_CYAN$(echo CPU:) $PR_LIGHT_RED$PR_CPU $PR_LOAD_COLOR$PR_LOAD$PR_NO_COLOR$PR_BLUE$PR_BLUE] [\
#$PR_NO_COLOR$PR_LIGHT_CYAN$(echo Mem:) $PR_LIGHT_YELLOW$PR_MEM$PR_NO_COLOR$PR_BLUE$PR_BLUE] [\
#$PR_NO_COLOR$PR_LIGHT_CYAN$(echo Swap:) $PR_LIGHT_GREEN$PR_SWAP$PR_NO_COLOR$PR_BLUE$PR_BLUE]
#<$PR_NO_COLOR$PR_LIGHT_BLUE%(0?..%U)%(!.$PR_RED.$PR_LIGHT_CYAN)%n$PR_LIGHT_BLUE@$PR_GREEN%m$PR_LIGHT_BLUE:\
#$PR_LIGHT_MAGENTA%(0?..%u)%~$PR_LIGHT_BLUE>$PR_NO_COLOR "
#
#    export RPS1="$PR_LIGHT_CYAN%t$PR_NO_COLOR"
#}
#
#setprompt

# activate vivint virtual env
export VIVINT_CONFIG_DIR=$HOME/dev/vivint/Platform/ConfigFiles

#clear
#archey3

# TMUX
#if [[ -z "$TMUX" ]] ;then
#    ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
#    if [[ -z "$ID" ]] ;then # if not available create a new one
#        tmux new-session
#    else
#        tmux attach-session -t "$ID" # if available attach to it
#    fi
#fi

export NVM_DIR="/home/darren/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

function randomCow {
    cowthink -f $(find /usr/share/cows -type f | shuf -n 1) $@
}

#command_not_found_handler() {
#  local pkgs cmd="$1"
#  cowcurse
#
#  echo ''
#
#  pkgs=(${(f)"$(pkgfile -b -v -- "$cmd" 2>/dev/null)"})
#  if [[ -n "$pkgs" ]]; then
#    printf '\n%s may be found in the following packages:\n' "$cmd"
#    printf '  %s\n' $pkgs[@]
#    return 0
#  fi
#
#  return 127
#}

#precmd() {
#    local val=$?
#    if [ 0 -ne $val ] && [ 127 -ne $val ]; then
#        echo ''
#        cowcurse
#    fi
#}
