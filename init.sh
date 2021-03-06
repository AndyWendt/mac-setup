#!/bin/bash

ansible-playbook ./mac-playbook.yml

# Enable Night Shift
# https://github.com/LukeChannings/.config/blob/master/install.macos#L418-L438
# sudo defaults read com.apple.CoreBrightness.plist

# Night Shift settings don't work right now
# CORE_BRIGHTNESS="/var/root/Library/Preferences/com.apple.CoreBrightness.plist"
#CORE_BRIGHTNESS="com.apple.corebrightness"
#
#ENABLE='{
#  CBBlueLightReductionCCTTargetRaw = 2700;
#  CBBlueReductionStatus =     {
#    AutoBlueReductionEnabled = 1;
#    BlueLightReductionDisableScheduleAlertCounter = 3;
#    BlueLightReductionSchedule = {
#      DayStartHour = 7;
#      DayStartMinute = 0;
#      NightStartHour = 7;
#      NightStartMinute = 1;
#    };
#    BlueReductionAvailable = 1;
#    BlueReductionEnabled = 1;
#    BlueReductionMode = 2;
#    BlueReductionSunScheduleAllowed = 1;
#    Version = 1;
#  };
#  CoreAnalyticsTimestamps =     {
#    "com.apple.corebrightness.harmony.state" = "2019-10-12 02:33:53 +0000";
#  };
#}'

#echo "Changing night shift settings"
# sudo defaults write $CORE_BRIGHTNESS "CBUser-0" "$ENABLE"
#sudo defaults write $CORE_BRIGHTNESS "CBUser-$(dscl . -read $HOME GeneratedUID | sed 's/GeneratedUID: //')" "$ENABLE"

echo "Installing Tuple"
curl -L https://git.io/tuple-install | bash

echo "Restarting the menubar"
killall SystemUIServer

echo "Restarting touchbar"
sudo pkill TouchBarServer

echo "Restarting the Dock"
killall Dock

