#!/usr/bin/env bash

###
# ALIASES
###

# Git
# You must install Git first
alias gs='git status -sb'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add .'
alias gc='git commit -m' # requires you to type a commit message
alias gp='git pull'
alias gf='git fetch'
alias gl="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gco='git checkout'
alias grb='git rebase'

# Python
alias pyclean='find . -name "*.pyc" -delete'

# Standard ls alises
if [[ "$(uname -s)" == "Darwin" && "$(which ls)" != "/usr/local/opt/coreutils/libexec/gnubin/ls" ]]; then
    ls_color="-G"
else
    ls_color="--color=auto"
fi
alias ls="ls ${ls_color}"
alias ll='ls -l'
alias la='ll -a'
alias lh='ll -h'
alias l='ll'
alias fuck='sudo $(fc -ln -1)'
alias please='sudo -E'

if [[ "$(uname -s)" == "Darwin" ]]; then
    alias sleeplog='pmset -g log | grep -e " Sleep  " -e " Wake  "'
fi
