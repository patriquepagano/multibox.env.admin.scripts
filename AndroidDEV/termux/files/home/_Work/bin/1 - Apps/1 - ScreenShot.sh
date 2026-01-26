#!/system/bin/sh
clear
path="$( cd "${0%/*}" && pwd -P )"


OnScreenNow=$(dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1)


echo "Capturando imagem da tela..."
/system/bin/screencap -p "$path/1 - ScreenShot.png"
# ignore as mensagems am extraidas do screencap é bug do app
clear

echo "App que está na frente da tela: 

$OnScreenNow

"


if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi


