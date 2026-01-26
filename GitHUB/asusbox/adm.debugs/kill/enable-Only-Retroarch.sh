#!/system/bin/sh


/system/bin/busybox mount -o remount,rw /system

rm /system/bin/initRc.drv.01.01.97

rm /sdcard/retroarch-enable

if [ ! -f /sdcard/retroarch-enable ]; then
remove=`pm list packages -3 | /system/bin/busybox sed -e 's/.*://' | /system/bin/busybox sort \
| /system/bin/busybox grep -v "dxidev.toptvlauncher2" \
| /system/bin/busybox grep -v "com.retroarch" \
| /system/bin/busybox grep -v "ru.elron.gamepadtester" \
| /system/bin/busybox grep -v "com.chiarly.gamepad"`
# echo "$remove"
for loop in $remove; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Desativando app > $loop"
    pm disable $loop
done
touch /sdcard/retroarch-enable
fi

# abre o retroarch
# am start --user 0 -a android.intent.action.MAIN com.retroarch/.browser.mainmenu.MainMenuActivity





