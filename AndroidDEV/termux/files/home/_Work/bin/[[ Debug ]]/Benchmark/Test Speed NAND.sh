path=$( cd "${0%/*}" && pwd -P )
clear
export TZ=UTC−03:00
toolx="/system/bin/busybox"


echo "testando velocidade de gravação NAND"
$toolx dd if=/dev/zero of=/sdcard/test1.img bs=300M count=1


echo "testando velocidade de leitura Nand"
$toolx time $toolx dd if=/sdcard/test1.img of=/dev/null bs=8k


if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi



