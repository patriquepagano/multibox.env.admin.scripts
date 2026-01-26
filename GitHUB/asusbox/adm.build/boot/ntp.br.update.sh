#!/system/bin/sh

TZ="UTC−03:00"
export TZ
CheckCurl=`/system/bin/curl "http://127.0.0.1/ntpUpdate.php"`

unixtime=`echo -n "$CheckCurl" | busybox cut -d '|' -f 1`
dateHuman=`echo -n "$CheckCurl" | busybox cut -d '|' -f 2`


/system/bin/busybox date -s "@$unixtime"

# echo -n "$unixtime" > /data/trueDT/peer/Sync/ntp.date.epoch.live
# echo -n "$dateHuman" > /data/trueDT/peer/Sync/ntp.date.live



# exit

# /system/bin/busybox date -s @232078240



