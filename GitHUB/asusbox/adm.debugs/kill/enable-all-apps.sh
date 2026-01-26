#!/system/bin/sh


appList=`pm list packages -3 | /system/bin/busybox sed -e 's/.*://' | /system/bin/busybox sort \
| /system/bin/busybox grep -v "com.retroarch" \
| /system/bin/busybox grep -v "ru.elron.gamepadtester" \
| /system/bin/busybox grep -v "com.chiarly.gamepad"`
# echo "$appList"
for loop in $appList; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### ativando app > $loop"
    pm enable $loop
done
