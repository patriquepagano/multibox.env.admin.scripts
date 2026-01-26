#!/system/bin/sh

export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
# Binário
app="transmission"
apkSection="000.snib-"
FileName="B.003"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname $0)

cmdCheck='/system/bin/transmission-remote -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
#cmdCheck='versionBinLocal=`/system/bin/busybox md5sum "/system/bin/transmission-remote"`'
eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/bin/transmission-create
/system/bin/transmission-daemon
/system/bin/transmission-edit
/system/bin/transmission-remote
/system/bin/transmission-show
/system/lib/libminiupnpc.so
/system/lib/libcrypto.so.1.1
/system/lib/libcurl.so
/system/lib/libevent-2.1.so
/system/lib/libnghttp2.so
/system/lib/libssl.so.1.1
/system/lib/libz.so.1
/system/lib/libz.so.1.2.11
/system/usr/share/transmission"

scriptOneTimeOnly="
# fix do libz
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/lib/libz.so.1.2.11 /system/lib/libz.so.1
"

# ImgAlert='
# if [ ! "$cronRunning" == "yes" ]; then
#     Imgfile=/sdcard/Android/data/asusbox/.imgMsg/02.transmission.jpg
#     while [ 1 ]; do
#         echo "ADM DEBUG ########################################################"
#         echo "ADM DEBUG ### abrindo imagem alerta transmission"        
#         am force-stop com.not.aa_image_viewer
#         # abre o arquivo de imagem
#         am start --user 0 \
#         -n com.not.aa_image_viewer/com.not.aa.ImageDetailActivity \
#         -a android.intent.action.VIEW -d file://$Imgfile
#         if [ $? = 0 ]; then break; fi;
#         sleep 1
#     done;
# fi
# '

scriptAtBoot=''
### Tasks ###############################################################################
# compressTarget

rcloneUploadFileList









