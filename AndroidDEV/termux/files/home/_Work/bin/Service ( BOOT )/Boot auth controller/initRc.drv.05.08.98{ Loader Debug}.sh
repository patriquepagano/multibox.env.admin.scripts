#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )

cp "$path/initRc.drv.05.08.98{START}.sh" "/data/local/tmp/debugSyncthing.sh"
chmod 700 "/data/local/tmp/debugSyncthing.sh"

HOME="/data/trueDT/peer"
screen -dmS Syncthing "/data/local/tmp/debugSyncthing.sh"

screen -ls
sleep 5
netstat -ntlup


