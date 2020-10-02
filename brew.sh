#!/usr/bin/env bash

# Install Homebrew
echo "Installing Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

if [[ ! $(command -v brew) ]]; then
    echo "Homebrew not installed, cannot continue!"
    exit
fi

echo "Installing Homebrew Formulae..."
brew install bash
brew install bash-completion
brew install coreutils
brew install findutils
brew install git
brew install gnu-sed
brew install helm
brew install htop
brew install pwgen
brew install pyenv
brew install python
brew install shellcheck
brew install tmux
brew install vim
brew install watch
brew install wget
brew install xz
brew install zlib

echo "Installing Homebrew casks..."
brew tap homebrew/cask
brew cask install 1password
brew cask install atom
brew cask install bettertouchtool
brew cask install daisydisk
brew cask install discord
brew cask install divvy
brew cask install dropbox
brew cask install firefox
brew cask install istat-menus
brew cask install keepingyouawake
brew cask install scroll-reverser
brew cask install telegram
brew cask install the-unarchiver
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install workflowy

# Install Source Code Pro Font
echo "Installing Fonts..."
brew tap homebrew/cask-fonts
brew cask install font-source-code-pro
