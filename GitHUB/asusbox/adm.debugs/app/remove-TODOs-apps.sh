#!/system/bin/sh

remove=`pm list packages -3 | /system/bin/busybox sed -e 's/.*://' | /system/bin/busybox sort \
| /system/bin/busybox grep -v "com.termux" \
| /system/bin/busybox grep -v "com.evozi.injector" \
| /system/bin/busybox grep -v "berserker.android.apps.sshdroid"`
# echo "$remove"
for loop in $remove; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Desistalando app > $loop"
    pm uninstall $loop
done


# | /system/bin/busybox grep -v -f /data/local/tmp/APPList \

