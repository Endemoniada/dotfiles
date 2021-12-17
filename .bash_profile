#!/usr/bin/env bash

###
# SYSTEM
###

if [[ -d ~/bin ]]; then
    export PATH=~/bin:$PATH
fi

# Add Homebrew sbin to path
export PATH="/usr/local/sbin:$PATH"

# Add gnu coreutils to path
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Add gnu find to path
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"

# Add gnu sed to path
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# Add openssl to path
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


if [[ "$(uname -s)" == "Darwin" ]]; then
    Darwin=true
elif [[ "$(uname -s)" == "Linux" ]]; then
    Linux=true
fi


# Load dotfiles:
for file in ~/.{bash_prompt,bash_aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


###
# SCRIPTS
###

#Git auto-complete
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash;
    export GIT_PS1_SHOWDIRTYSTATE=true
fi

# Bash completion
if [[ $(command -v brew) && -f $(brew --prefix)/etc/bash_completion ]]; then
    source $(brew --prefix)/etc/bash_completion
fi

# Python virtual environments
export WORKON_HOME=$HOME/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

# https://opensource.com/article/19/5/python-3-default-mac#what-to-do
# https://opensource.com/article/19/6/python-virtual-environments-mac
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  source ${HOME}/.pyenv/versions/3.7.7/bin/virtualenvwrapper.sh
fi

# Disable macos zsh wawrning
export BASH_SILENCE_DEPRECATION_WARNING=1


###
# DROP-IN FILES
###

if [[ -d ~/.bashrc.d ]]; then
    for file in ~/.bashrc.d/*; do
        source "${file}"
    done
    unset file
fi
