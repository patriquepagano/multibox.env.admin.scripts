#!/system/bin/sh
path="$( cd "${0%/*}" && pwd -P )"
clear

source "$path/.functions.sh"

# Reativa apps de usuario e ignora apps proibidos para usuario comum
EnableAppsExclusions

# reativa todos apps de usuario
EnablePriorityApps

# desativa o whatchdog do navegador
ACRInfoDisable

# traz a launcher para a frente
LauncherOnTop

if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi



