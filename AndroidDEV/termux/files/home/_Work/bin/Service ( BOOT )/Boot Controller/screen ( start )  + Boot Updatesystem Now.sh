#!/system/bin/sh
clear

echo "Boot UpdateSystem.sh NOW
press ok to continue"
read bah
if [ "$bah" == "ok" ]; then
"$HOME/_Work/bin/.stop/1 STOP ALL HERE !!!.sh"
fi

echo "
abra outro terminal no IP novo da lan e digite:
screen -r DebugBOOT

"

rm /data/asusbox/LauncherLock

screen -wipe
screen -dmS DebugBOOT "/storage/DevMount/GitHUB/asusbox/adm.3.Online/asusboxA1/boot/armeabi-v7a/UpdateSystem.sh"








