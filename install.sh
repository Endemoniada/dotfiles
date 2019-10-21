#!/usr/bin/env bash

# Make sure we exit as soon as something goes wrong
set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: install.sh <home_directory>"
    exit 1
fi

HOMEDIR=$1
# https://stackoverflow.com/a/246128/10586098
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

FILES="bashrc bash_profile profile bash_aliases bash_prompt tmux.conf vimrc"
BINFILES="getbatt.sh"

# create symlinks (will create backup of old dotfiles)
for FILE in ${FILES}; do
    if [[ -f "${HOMEDIR}/.${FILE}" && ! -h "${HOMEDIR}/.${FILE}" ]]; then
        echo "Making backup of existing file: .${FILE}"
        mv "${HOMEDIR}/.${FILE}" "${HOMEDIR}/.${FILE}.bak"
    fi
    echo "Creating symlink to .$FILE in home directory."
    ln -sf "${HERE}/.${FILE}" "${HOMEDIR}/.${FILE}"
done

if [[ ! -d "${HOMEDIR}/bin" ]]; then
    mkdir "${HOMEDIR}/bin"
fi
for FILE in ${BINFILES}; do
    if [[ -f "${HOMEDIR}/bin/${FILE}" && ! -h "${HOMEDIR}/bin/${FILE}" ]]; then
        echo "Making backup of existing file: ${FILE}"
        mv "${HOMEDIR}/bin/${FILE}" "${HOMEDIR}/bin/${FILE}.bak"
    fi
    echo "Creating symlink to $FILE in ~/bin."
    ln -sf "${HERE}/bin/${FILE}" "${HOMEDIR}/bin/${FILE}"
done

# Download Git Auto-Completion
echo -n "Downloading git-completion..."
curl -s "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" > "${HOMEDIR}"/.git-completion.bash
echo " Done"

# Only automatically run the brew install script if operating system is a Mac
if [[ "$(uname -s)" == "Darwin" ]]; then
    # Only run this if brew is NOT installed
    if [[ ! $(command -v brew) ]]; then
        # Run the Homebrew Script
        echo "Running Homebrew installation script..."
        "$HERE"/brew.sh
    fi

    # Only run this if Atom/apm is installed
    if [[ $(command -v apm) ]]; then
        # Run the Atom Script
        echo "Running Atom packages installation script..."
        "$HERE"/atom.sh
    fi
fi
