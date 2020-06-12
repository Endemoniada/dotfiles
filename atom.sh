#!/usr/bin/env bash
set -e

echo "Installing Atom themes..."
apm install \
atom-material-syntax \
atom-material-syntax-dark \
base16-eighties-dark \
base16-eighties-one-dark \
nord-atom-syntax \
nord-atom-ui \
tomorrow-night-eighties \

echo
echo "Installing Atom packages..."
apm install \
ansible-vault \
atom-csv-markdown \
atom-overtype-mode \
autocomplete-python \
busy-signal \
docblock-python \
file-icons \
git-plus \
highlight-selected \
intentions \
language-diff \
language-docker \
language-generic-config \
language-powershell \
language-rpm-spec \
line-length-break \
linter \
linter-flake8 \
linter-shellcheck \
linter-ui-default \
markdown-preview-plus \
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
Sublime-Style-Column-Selection \
tablr \
trailing-spaces \
