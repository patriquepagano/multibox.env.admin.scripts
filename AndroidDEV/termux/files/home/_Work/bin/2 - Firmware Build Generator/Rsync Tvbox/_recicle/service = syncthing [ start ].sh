#!/system/bin/sh
clear

HOME="/data/trueDT/peer"
# necessário criar a pasta para o screen funcionar
mkdir -p $HOME
screen -dmS Syncthing "/storage/DevMount/GitHUB/asusbox/adm.build/boot/initRc.drv.05.08.98{START}.sh"
screen -wipe
