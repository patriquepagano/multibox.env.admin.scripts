#!/system/bin/sh
function CheckIPLocal () {
WlanIP=`/system/bin/busybox ip addr show wlan0 \
| /system/bin/busybox grep "inet " \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox cut -d "/" -f 1 \
| /system/bin/busybox head -1`
LanIP=`/system/bin/busybox ip addr show eth0 \
| /system/bin/busybox grep "inet " \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox cut -d "/" -f 1 \
| /system/bin/busybox head -1`
if [ "$LanIP" == "" ]; then
export IPLocal="$WlanIP"
else
export IPLocal="$LanIP"
fi
}
function GetGeoLocalization () {
link='https://api.freegeoip.app/json/?apikey=69032740-a582-11ec-a49d-b105dbc7486e'
CheckCurl=`/system/bin/curl --silent -w "%{http_code}" -k $link -L`
export httpCode=`echo "$CheckCurl" | busybox cut -d "}" -f 2`
export ip=`echo -n "$CheckCurl" | busybox cut -d '"' -f 4 | busybox head -1`
export country=`echo -n "$CheckCurl" | busybox cut -d '"' -f 12 | busybox head -1`
export region=`echo -n "$CheckCurl" | busybox cut -d '"' -f 18 | busybox head -1`
export city=`echo -n "$CheckCurl" | busybox cut -d '"' -f 22 | busybox head -1`
if [ ! -d /data/trueDT/peer/Sync ]; then
mkdir -p /data/trueDT/peer/Sync
fi
}
FileLog="/data/trueDT/peer/Sync/LocationGeoIP.v6.atual"
checkFileInfo=$(busybox cat $FileLog | busybox tr -d '\n')
if [ "$checkFileInfo" == "" ]; then
rm $FileLog
fi
if [ "$checkFileInfo" == " | " ]; then
rm $FileLog
fi
if [ "$checkFileInfo" == "Brazil |  | " ]; then
rm $FileLog
fi
if [ ! -e "$FileLog" ]; then
for i in $(seq 1 7); do
GetGeoLocalization
if [ "$httpCode" = "200" ]; then break; fi;
sleep 3;
done;
if [ ! "$httpCode" = "200" ]; then exit; fi;    
echo "$ip | $country | $region | $city" > "/data/trueDT/peer/Sync/LocationGeoIP.v6.atual"
fi
GETipExternal=$(/system/bin/curl --silent http://canhazip.com)
FileLog="/data/trueDT/peer/Sync/LocationIP"
ExternalipLogged=$(busybox cat $FileLog.atual | busybox tr -d '\n')
if [ ! "$ExternalipLogged" == "$GETipExternal" ]; then
echo $GETipExternal > "$FileLog.atual"
for i in $(seq 1 7); do
GetGeoLocalization
if [ "$httpCode" = "200" ]; then break; fi;
sleep 3;
done;
if [ ! "$httpCode" = "200" ]; then exit; fi; 
echo "$ip | $country | $region | $city" > "/data/trueDT/peer/Sync/LocationGeoIP.v6.atual"
else
logcat -c
fi
CheckIPLocal
FileLog="/data/trueDT/peer/Sync/LocationIPlocal"
IPLocalLogged=$(busybox cat $FileLog.atual | busybox tr -d '\n')
if [ ! "$IPLocalLogged" == "$IPLocal" ]; then
echo -n $IPLocal > "$FileLog.atual"
else
logcat -c
fi
echo 'press to any button to continue'
read bah
