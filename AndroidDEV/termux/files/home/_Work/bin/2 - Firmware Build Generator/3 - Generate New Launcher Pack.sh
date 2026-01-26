#!/system/bin/sh

sh "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.launcher/launcher-03-full [A] Backup Config.sh"
sh "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.launcher/launcher-03-full [B] WIP export + restore.sh"
sh "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.launcher/launcher-03-full [C] export P2P Pack.sh"

echo "Novo pacote da launcher official gerado com sucesso!"


if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
    # come back to menu 
    path=$( cd "${0%/*}" && pwd -P )
    cd $path
    x
fi

