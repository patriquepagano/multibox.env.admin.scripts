# script feito manual
# clear
# /system/bin/busybox mount -o remount,rw /system
# rm /system/bin/transmission-remote

# ln -sf /system/usr/bin/transmission-create /system/bin/
# ln -sf /system/usr/bin/transmission-remote /system/bin/
# ln -sf /system/usr/bin/transmission-edit /system/bin/
# ln -sf /system/usr/bin/transmission-show /system/bin/
# ln -sf /system/usr/bin/transmission-daemon /system/bin/

CallsiteSupport () {
sitesupport="https://telegra.ph/A7-Suporte-Avan%C3%A7ado-07-25"
am start --user 0 \
    -n acr.browser.barebones/acr.browser.lightning.MainActivity \
    -a android.intent.action.VIEW -d "$sitesupport" > /dev/null 2>&1
sleep 30
}


app="transmission"
FileName="B.009.0-armeabi-v7a"

cmdCheck='/system/bin/transmission-daemon -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
eval $cmdCheck
versionBinOnline="transmission-daemon 3.00 (bb6b5a062e)"
Senha7z="S1IiSP6YHAcIYPgXz8urgne2xvKpcGFkVqYQdw3RO6nWa0JKMxTBAm158h2lxv2RXcO9cb"

if [ ! "$versionBinOnline" == "$versionBinLocal" ]; then
busybox mkdir -p /data/local/tmp
function CurlDownload () {
httpCode=`curl -w "%{http_code}" \
-o /data/local/tmp/B.009.0-armeabi-v7a.001 \
http://personaltecnico.net/Android/AsusBOX/A1/data/asusbox/B.009.0-armeabi-v7a.001 \
| busybox sed 's/\r$//'`
}
while [ 1 ]; do
	echo "Iniciando Download"
	CurlDownload
	if [ $httpCode = "200" ]; then break; fi; # check return value, break if successful (0)
	CallsiteSupport
	sleep 3
done;

am force-stop acr.browser.barebones

echo "ADM DEBUG ### extraindo 7z $app"
# extract 7z splitted
/system/bin/7z e -aoa -y -p$Senha7z "/data/local/tmp/B.009.0-armeabi-v7a.001" -oc:/data/local/tmp > /dev/null 2>&1
# extract tar
cd /
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox tar -mxvf /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
rm /data/local/tmp/$FileName* > /dev/null 2>&1

# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/transmission-create /system/bin/
ln -sf /system/usr/bin/transmission-remote /system/bin/
ln -sf /system/usr/bin/transmission-edit /system/bin/
ln -sf /system/usr/bin/transmission-show /system/bin/
ln -sf /system/usr/bin/transmission-daemon /system/bin/

fi


USBLOGCALL="install p2p bin"
OutputLogUsb

