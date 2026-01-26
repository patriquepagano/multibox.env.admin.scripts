#!/system/bin/sh

OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1`
am force-stop $OnScreenNow

