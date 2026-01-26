#!/system/bin/sh
path="$( cd "${0%/*}" && pwd -P )"
clear

source "$path/.functions.sh"



PKG="acr.browser.barebones"
UnHideApp

# aqui eu escrevo o html ou copio atualizo e marco a url

# carregando arquivo offline informação ao cliente
ACRURL="file:///sdcard/info/index.html"
ACRInfo

# Apps to check, e desativar com prioridade
DisablePriorityApps

# desativar todos os apps em seguida
disableAllApps


if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi



