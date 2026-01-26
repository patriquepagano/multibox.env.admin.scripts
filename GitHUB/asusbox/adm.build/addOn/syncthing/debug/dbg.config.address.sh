#!/system/bin/sh
source /data/.vars 


defaultConfig="/data/asusbox/sync/config.xml"

/system/bin/busybox sed -i -e 's/127.0.0.1/0.0.0.0/g' $defaultConfig



exit



<address>127.0.0.1:8384</address>