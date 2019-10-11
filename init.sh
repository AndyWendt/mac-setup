#!/bin/bash

ansible-playbook ./init.yml

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


# Enable Night Shift
# https://github.com/LukeChannings/.config/blob/master/install.macos#L418-L438

CORE_BRIGHTNESS="/var/root/Library/Preferences/com.apple.CoreBrightness.plist"

ENABLE='{
  CBBlueReductionStatus =     {
    AutoBlueReductionEnabled = 1;
    BlueLightReductionDisableScheduleAlertCounter = 3;
    BlueLightReductionSchedule =         {
      DayStartHour = 7;
      DayStartMinute = 0;
      NightStartHour = 7;
      NightStartMinute = 1;
    };
    BlueReductionEnabled = 0;
    BlueReductionMode = 1;
    BlueReductionSunScheduleAllowed = 1;
    Version = 1;
  };
}'

sudo defaults write $CORE_BRIGHTNESS "CBUser-0" "$ENABLE"
sudo defaults write $CORE_BRIGHTNESS "CBUser-$(dscl . -read $HOME GeneratedUID | sed 's/GeneratedUID: //')" "$ENABLE"


# Menu bar: Add Bluetooth, AirPort (WiFi), Battery
defaults write com.apple.systemuiserver menuExtras -array \
	"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
	"/System/Library/CoreServices/Menu Extras/Battery.menu" \
	"/System/Library/CoreServices/Menu Extras/Volume.menu"

# https://github.com/bramus/freshinstall/blob/master/steps/1.macos-settings.sh
# https://www.tech-otaku.com/mac/setting-the-date-and-time-format-for-the-macos-menu-bar-clock-using-terminal/
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm"; killall SystemUIServer

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -bool true; killall SystemUIServer



# Set Lock Message to show on login screen
# sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText -string "Found me? Shoot a mail to $email to return me. Thanks."


# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true


# Don't trade spaces
# defaults write com.apple.dock mru-spaces -bool false


# Change shell

chsh -s /usr/local/bin/fish

