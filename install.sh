#!/usr/bin/env bash

# Make sure we exit as soon as something goes wrong
set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: install.sh <home_directory>"
    exit 1
fi

HOMEDIR=$1
if [[ ! -d "$HOMEDIR" ]]; then
    echo "Cannot find path: ${HOMEDIR}"
    echo "Exiting..."
    exit 1
fi
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"  # https://stackoverflow.com/a/246128/10586098

FILES="bashrc bash_profile profile bash_aliases bash_prompt tmux.conf vimrc gitconfig"
BINFILES="getbatt.sh"
ATOM_FILES="config.cson keymap.cson"

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# Usage: `ask [Y|N]`
# Supplied parameter will decide the default answer
# Default is No`
ask () {
  default=$(echo "${1:0:1}" | awk '{print toupper($0)}')
  if [[ "$default" == "Y" ]]; then
    choices="[Y/n]"
  else
    choices="[y/N]"
  fi
  read -r -p "${choices}> " answer
  if [[ "$answer" == "" ]]; then
    answer=$default
  fi
  echo "${answer:0:1}" | awk '{print toupper($0)}'
}

action () {
    echo "${BOLD}${1}${NORMAL}"
}

inst_dotfiles () {
    echo "Install symlinks to dotfiles?"
    if [[ "$(ask Y)" == "Y" ]]; then
        echo

        # create symlinks (will create backup of old dotfiles)
        for FILE in ${FILES}; do
            if [[ -f "${HOMEDIR}/.${FILE}" && ! -h "${HOMEDIR}/.${FILE}" ]]; then
                action "Making backup of existing file: .${FILE}"
                mv -v "${HOMEDIR}/.${FILE}" "${HOMEDIR}/.${FILE}.bak"
            fi
            action "Creating symlink to .$FILE in ${HOMEDIR} directory."
            ln -svf "${HERE}/.${FILE}" "${HOMEDIR}/.${FILE}"
        done

        # Download Git Auto-Completion
        echo -n "${BOLD}Downloading git-completion...${NORMAL}"
        curl -s "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" > "${HOMEDIR}"/.git-completion.bash
        echo "${BOLD} Done${NORMAL}"
    fi
    echo
}

inst_binfiles () {
    echo "Create ${HOMEDIR}/bin and install symlinks to binaries?"
    if [[ "$(ask Y)" == "Y" ]]; then
        echo

        if [[ ! -d "${HOMEDIR}/bin" ]]; then
            action "Creating ${HOMEDIR}/bin ..."
            mkdir "${HOMEDIR}/bin"
        fi
        for FILE in ${BINFILES}; do
            if [[ -f "${HOMEDIR}/bin/${FILE}" && ! -h "${HOMEDIR}/bin/${FILE}" ]]; then
                action "Making backup of existing file: ${FILE}"
                mv -v "${HOMEDIR}/bin/${FILE}" "${HOMEDIR}/bin/${FILE}.bak"
            fi
            action "Creating symlink to $FILE in ${HOMEDIR}/bin."
            ln -svf "${HERE}/bin/${FILE}" "${HOMEDIR}/bin/${FILE}"
        done
    fi
    echo
}

inst_homebrew () {
    # Only automatically run the brew install script if operating system is a Mac
    if [[ "$(uname -s)" == "Darwin" ]]; then

        echo "Install Homebrew?"
        if [[ "$(ask N)" == "Y" ]]; then
            echo

            # Only run this if brew is NOT installed
            if [[ ! $(command -v brew) ]]; then
                # Run the Homebrew Script
                action "Running Homebrew installation script..."
                "$HERE"/brew.sh
            fi
        fi
        echo
    fi
}

inst_atom () {
    # Only automatically run the brew install script if operating system is a Mac
    if [[ "$(uname -s)" == "Darwin" ]]; then

        echo "Install Atom packages?"
        if [[ "$(ask N)" == "Y" ]]; then
            echo

            # Only run this if Atom/apm is installed
            if [[ $(command -v apm) ]]; then
                # Run the Atom Script
                action "Running Atom packages installation script..."
                "$HERE"/atom.sh
            fi
        fi
        echo

        echo "Install Atom configuration?"
        if [[ "$(ask Y)" == "Y" ]]; then
            echo

            action "Installing Atom configuration files..."
            # TODO: show diff and ask for confirmation
            # diff -u --suppress-common-lines
            if [[ ! -d "${HOMEDIR}/.atom" ]]; then
                mkdir "${HOMEDIR}/.atom"
            fi
            for FILE in ${ATOM_FILES}; do
                if [[ -f "${HOMEDIR}/.atom/${FILE}" ]]; then
                    action "Making backup of existing file: .${FILE}"
                    mv -v "${HOMEDIR}/.atom/${FILE}" "${HOMEDIR}/.atom/${FILE}.bak"
                fi
                action "Copying file to .$FILE in home directory."
                cp -v "${HERE}/atom/${FILE}" "${HOMEDIR}/.atom/${FILE}"
            done
        fi
        echo
    fi
}

inst_fonts () {
    # Only automatically run the brew install script if operating system is a Mac
    if [[ "$(uname -s)" == "Darwin" ]]; then

        echo "Install fonts?"
        if [[ "$(ask Y)" == "Y" ]]; then
            echo

            # Install user fonts
            action "Installing user fonts in ~/Library/Fonts/ ..."
            cp -vn "${HERE}"/fonts/* ~/Library/Fonts/ || :  # Ignore errors: https://serverfault.com/a/153893
        fi
        echo
    fi
}

inst_tmux () {
    echo "Install Tmux Plugin Manager?"
    if [[ "$(ask Y)" == "Y" ]]; then
        echo

        action "Installing Tmux Plugin Manager..."
        if [[ ! -d "${HOMEDIR}"/.tmux/plugins ]]; then
            mkdir -p "${HOMEDIR}"/.tmux/plugins
        fi
        if [[ ! -d "${HOMEDIR}/.tmux/plugins/tpm" ]]; then
            git clone https://github.com/tmux-plugins/tpm "${HOMEDIR}"/.tmux/plugins/tpm
        fi

        echo
        action "INFO: If you have reloaded your tmux config, press PREFIX+I to install the plugin"
    fi
    echo
}


action "Starting Dotfiles Installation..."
echo

inst_dotfiles
inst_binfiles
inst_homebrew
inst_atom
inst_fonts
inst_tmux

action "All done!"
