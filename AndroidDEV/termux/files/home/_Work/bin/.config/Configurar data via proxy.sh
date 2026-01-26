#!/system/bin/sh

TZ=UTC−03:00
export TZ

Dir=$(dirname $0)

url="https://time.is/pt_br/Unix_time_converter"

curl -ko $Dir/getTime $url
epochDate=`/system/bin/busybox cat $Dir/getTime | /system/bin/busybox grep 'id="unix_time" value="' | /system/bin/busybox cut -d '"' -f 8`
/system/bin/busybox date -s "@$epochDate"
rm $Dir/getTime
date




