#!/bin/bash

echo -n "Enter your email and press [ENTER]: "
read email

echo -n "Enter your name and press [ENTER]: "
read name

git config --global user.email "$email"
git config --global user.name "$name"

brew cask install slack
brew cask install authy
brew cask install iterm2
brew cask install jetbrains-toolbox
brew cask install sequel-pro
brew cask install visual-studio-code

chmod 0600 ~/.ssh/id_rsa

# dock: left, autohide, and quick reappear
defaults write com.apple.dock orientation -string left && killall Dock
defaults write com.apple.dock autohide-delay -float 0; killall Dock
defaults write com.apple.dock autohide -bool true; killall Dock

# Remove all of the stupid default apps they leave in the dock
defaults write com.apple.dock persistent-apps -array

defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# set touchbar default to FKeys
defaults write com.apple.touchbar.agent PresentationModeGlobal functionKeys; sudo pkill TouchBarServer

defaults write com.apple.loginwindow LoginHook `pwd`/keymappings.sh
