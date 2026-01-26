#!/system/bin/sh
clear
TZ=UTC−03:00
export TZ

/system/bin/busybox date -h

#/system/bin/busybox date -s 2010.02.17-19:14:32

#/system/bin/busybox date -s 0112 23:45:00


# https://www.epochconverter.com/

epochDate=1611022770
/system/bin/busybox date -s "@$epochDate"
/system/bin/busybox date

exit

