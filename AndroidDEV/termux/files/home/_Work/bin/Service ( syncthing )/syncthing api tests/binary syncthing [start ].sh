#!/system/bin/sh

HOME="/data/trueDT/peer"
# necessário criar a pasta para o screen funcionar
mkdir -p $HOME
screen -dmS Syncthing "/data/asusbox/.sc/boot/initRc.drv.05.08.98{START}.sh"
screen -wipe

