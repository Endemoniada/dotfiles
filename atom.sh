#!/usr/bin/env bash
set -e

echo "Installing Atom themes..."
apm install atom-material-syntax \
 atom-material-syntax-dark \
 base16-eighties-dark \
 base16-eighties-one-dark \
 nord-atom-syntax \
 nord-atom-ui \
 tomorrow-night-eighties

echo "Installing Atom packages..."
apm install Sublime-Style-Column-Selection \
 ansible-vault \
 atom-csv-markdown \
 atom-overtype-mode \
 busy-signal \
 docblock-python \
 file-icons \
 git-plus \
 highlight-selected \
 intentions \
 language-diff \
 language-generic-config \
 language-powershell \
 language-rpm-spec \
 line-length-break \
 linter \
 linter-flake8 \
 linter-shellcheck \
 linter-ui-default \
 minimap \
 multi-wrap-guide \
 multifile-rename \
 python-autopep8 \
 python-black \
 python-tools \
 rulerz \
 script \
 sort-lines \
 ssh-config \
 tablr \
 trailing-spaces
