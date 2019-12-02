#!/usr/bin/env bash

###
# SYSTEM
###

if [[ -d ~/bin ]]; then
    export PATH=~/bin:$PATH
fi

# Add Homebrew sbin to path
export PATH="/usr/local/sbin:$PATH"

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
#export WORKON_HOME=/tmp/foo/.virtualenvs
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
if [[ $(command -v brew) && -f $(brew --prefix)/bin/virtualenvwrapper.sh ]]; then
    source $(brew --prefix)/bin/virtualenvwrapper.sh
fi

# Disable macos zsh wawrning
export BASH_SILENCE_DEPRECATION_WARNING=1


# if [[ "$Darwin" ]]; then
#   # Scripts and variables for various applications installed through homebrew
#   if [[ $(command -v brew) ]]; then
#       # Git Bash completion
#       if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
#           source $(brew --prefix)/etc/bash_completion
#       fi
#       GIT_PS1_SHOWDIRTYSTATE=true
#       if [[ -f $(brew --prefix)/etc/bash_completion.d/git-prompt.sh ]]; then
#           source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
#           bashgitprompt='$(__git_ps1)'
#       fi
#
#       # Python virtual environments:
#       # https://github.com/registerguard/registerguard.github.com/wiki/Install-python,-virtualenv,-virtualenvwrapper-in-a-brew-environment
#       export WORKON_HOME=$HOME/.virtualenvs
#       #export WORKON_HOME=/tmp/foo/.virtualenvs
#       export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
#       export PIP_VIRTUALENV_BASE=$WORKON_HOME
#       export PIP_RESPECT_VIRTUALENV=true
#
#       # Python VirtualEnv wrapper
#       if [[ -f $(brew --prefix)/bin/virtualenvwrapper.sh ]]; then
#           source $(brew --prefix)/bin/virtualenvwrapper.sh
#       fi
#   #    export PIP_REQUIRE_VIRTUALENV=true
#
#       # Byobu configuration
#       export BYOBU_PREFIX=$(brew --prefix)
#   fi
# fi
# if [[ $Linux ]]; then
#   # Scripts and variables for various applications installed through homebrew
#     # Git Bash completion
#     if [[ -f /usr/share/bash_completion ]]; then
#         source /usr/share/bash_completion
#     fi
#     GIT_PS1_SHOWDIRTYSTATE=true
# #    if [[ -f /usr/share/git/completion/git-completion.bash ]]; then
# #        source /usr/share/git/completion/git-completion.bash
# #       bashgitprompt='$(__git_ps1 " (%s)")'
# #    fi
#
#     # Python VirtualEnv wrapper
#     if [[ -f /usr/bin/virtualenvwrapper.sh ]]; then
#         source /usr/bin/virtualenvwrapper.sh
#     fi
#     export PIP_REQUIRE_VIRTUALENV=true
# fi

# Homebrew API key
#export HOMEBREW_GITHUB_API_TOKEN=""
