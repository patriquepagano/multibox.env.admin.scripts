path=$( cd "${0%/*}" && pwd -P )
clear
export TZ=UTC−03:00
toolx="/system/bin/busybox"


echo "testando velocidade de gravação HDD Externo"
$toolx dd if=/dev/zero of=/storage/DevMount/test1.img bs=300M count=1


echo "testando velocidade de leitura HDD Externo"
$toolx time $toolx dd if=/storage/DevMount/test1.img of=/dev/null bs=8k


rm /storage/DevMount/test1.img

if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi



