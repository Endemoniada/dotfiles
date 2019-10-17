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

FILES="bashrc bash_profile bash_aliases bash_prompt"

# create symlinks (will create backup of old dotfiles)
for FILE in ${FILES}; do
    if [[ -f "${HOMEDIR}/.${FILE}" && ! -h "${HOMEDIR}/.${FILE}" ]]; then
        echo "Making backup of existing file: .${FILE}"
        mv "${HOMEDIR}/.${FILE}" "${HOMEDIR}/.${FILE}.bak"
    fi
    echo "Creating symlink to .$FILE in home directory."
    ln -sf "${HERE}/.${FILE}" "${HOMEDIR}/.${FILE}"
done

# Download Git Auto-Completion
curl "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" > "${HOMEDIR}"/.git-completion.bash

# Only automatically run the brew install script if brew is not already installed, and system is a Mac
if [[ "$(uname -s)" == "Darwin" && ! $(command -v brew) ]]; then
    # Run the Homebrew Script
    echo "Running Homebrew installation script ..."
    "$HERE"/brew.sh
fi
