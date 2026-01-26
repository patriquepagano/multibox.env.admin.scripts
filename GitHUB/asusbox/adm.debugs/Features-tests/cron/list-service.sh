#!/system/bin/sh


/system/bin/busybox ps \
| /system/bin/busybox grep "/system/bin/busybox crond" \
| /system/bin/busybox grep -v "grep" \

