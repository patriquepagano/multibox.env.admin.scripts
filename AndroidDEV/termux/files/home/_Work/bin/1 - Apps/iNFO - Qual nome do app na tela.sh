#!/system/bin/sh
clear

OnScreenNow=$(dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1)

echo "$OnScreenNow"

if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi

