#!/system/bin/sh

echo "Need to disable boot from asusbox server, and automatic update;
1) disable power button
2) enable power button
enter to continue."
read bah


# desativando o botão de power no controle
# este arquivo é o mesmo para as placas de tvbox 2.4ghz ou 5.8ghz
# altera apenas se necessário
file="/system/usr/keylayout/110b0030_pwm.kl"

if [ "$bah" == "1" ]; then
    /system/bin/busybox mount -o remount,rw /system
    busybox sed -i -e 's/key 116.*/key 116   HOME/g' $"$file"
fi

if [ "$bah" == "2" ]; then
    /system/bin/busybox mount -o remount,rw /system
    busybox sed -i -e 's/key 116.*/key 116   POWER/g' $"$file"
fi




