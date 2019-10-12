#!/bin/bash

ansible-playbook ./init.yml

# Enable Night Shift
# https://github.com/LukeChannings/.config/blob/master/install.macos#L418-L438
# sudo defaults read com.apple.CoreBrightness.plist

CORE_BRIGHTNESS="/var/root/Library/Preferences/com.apple.CoreBrightness.plist"

ENABLE='{
  CBBlueLightReductionCCTTargetRaw = 2700;
  CBBlueReductionStatus =     {
    AutoBlueReductionEnabled = 1;
    BlueLightReductionDisableScheduleAlertCounter = 3;
    BlueLightReductionSchedule = {
      DayStartHour = 7;
      DayStartMinute = 0;
      NightStartHour = 7;
      NightStartMinute = 1;
    };
    BlueReductionAvailable = 1;
    BlueReductionEnabled = 1;
    BlueReductionMode = 2;
    BlueReductionSunScheduleAllowed = 1;
    Version = 1;
  };
}'

sudo defaults write $CORE_BRIGHTNESS "CBUser-0" "$ENABLE"
sudo defaults write $CORE_BRIGHTNESS "CBUser-$(dscl . -read $HOME GeneratedUID | sed 's/GeneratedUID: //')" "$ENABLE"

echo "Restarting the menubar"
killall SystemUIServer

echo "Restarting touchbar"
sudo pkill TouchBarServer

echo "Restarting the Dock"
killall Dock

