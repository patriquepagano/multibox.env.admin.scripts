#!/system/bin/sh
clear

echo "
abra outro terminal no IP novo da lan e digite:
screen -r DebugBOOT

"

screen -wipe
screen -dmS DebugBOOT "/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/000.1-Mac.lan.clone.sh"








