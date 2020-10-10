# *************************************************************************** #

#BBBBBBBBBBBBBBBBB              AAA                SSSSSSSSSSSSSSSHHHHHHHHH     HHHHHHHHH
#B::::::::::::::::B            A:::A             SS:::::::::::::::H:::::::H     H:::::::H
#B::::::BBBBBB:::::B          A:::::A           S:::::SSSSSS::::::H:::::::H     H:::::::H
#BB:::::B     B:::::B        A:::::::A          S:::::S     SSSSSSHH::::::H     H::::::HH
#  B::::B     B:::::B       A:::::::::A         S:::::S             H:::::H     H:::::H
#  B::::B     B:::::B      A:::::A:::::A        S:::::S             H:::::H     H:::::H
#  B::::BBBBBB:::::B      A:::::A A:::::A        S::::SSSS          H::::::HHHHH::::::H
#  B:::::::::::::BB      A:::::A   A:::::A        SS::::::SSSSS     H:::::::::::::::::H
#  B::::BBBBBB:::::B    A:::::A     A:::::A         SSS::::::::SS   H:::::::::::::::::H
#  B::::B     B:::::B  A:::::AAAAAAAAA:::::A           SSSSSS::::S  H::::::HHHHH::::::H
#  B::::B     B:::::B A:::::::::::::::::::::A               S:::::S H:::::H     H:::::H
#  B::::B     B:::::BA:::::AAAAAAAAAAAAA:::::A              S:::::S H:::::H     H:::::H
#BB:::::BBBBBB::::::A:::::A             A:::::A SSSSSSS     S:::::HH::::::H     H::::::HH
#B:::::::::::::::::A:::::A               A:::::AS::::::SSSSSS:::::H:::::::H     H:::::::H
#B::::::::::::::::A:::::A                 A:::::S:::::::::::::::SSH:::::::H     H:::::::H
#BBBBBBBBBBBBBBBBAAAAAAA                   AAAAAASSSSSSSSSSSSSSS  HHHHHHHHH     HHHHHHHHH

# *************************************************************************** #

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

stty -ixon

#export DISPLAY=127.0.0.1:0

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
#export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "


export PS1="\[$(tput bold)\]\[\033[38;5;46m\]\u@\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;33m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]\$(parse_git_branch)\[\033[00m\] \\$ \[$(tput sgr0)\]"
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'

alias q='exit'

alias docs='cd ~/Documents'
alias projects='cd ~/Documents/Projects'
alias clases='cd ~/Documents/Clases'
alias courses='cd ~/Projects/Courses'

alias uptodate='sudo apt update && sudo apt upgrade'

alias ginit='git init'
alias gstatus='git status'
alias glogg='git log --oneline --graph'
alias glog='git log'
alias gadd='git add .'
alias gcomm='git commit'
alias gpush='git push '
alias gstash='git stash'
alias greseth='git reset --hard'
alias gcout='git checkout '

alias v='vim'
alias vf='vifm'
alias txm='tmux new -s Main'
alias pdfo='evince '
alias pdft='pandoc -s -V geometry:margin=1in -o '

alias vbash='vim ~/.bashrc'
alias vvim='vim ~/.vimrc'

alias jbtools='cd /opt/jetbrais-toolbox'

alias clwar='clear'
alias clewr='clear'
alias ext='exit'
