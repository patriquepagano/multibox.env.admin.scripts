#!/system/bin/sh
clear

#rm -rf /storage/emulated/0/Download/icons
mkdir -p /storage/emulated/0/Download/icons


ssh="/data/data/com.termux/files/usr/bin/ssh"
sshpass="/data/data/com.termux/files/usr/bin/sshpass"
rsync="/data/data/com.termux/files/usr/bin/rsync"
IP="10.0.0.91"
user="gambatte"
pass="admger9pqt"


# copia apk por apk comparando se tem novos, mas não exclui os antigos
#/system/bin/busybox find "/data/app/com.cetusplay.remoteservice-1" -type f -name "base.apk" \
/system/bin/busybox find "/data/app/" -type f -name "base.apk" \
| /system/bin/busybox grep -v "/data/app/com.android.vending*" \
| /system/bin/busybox grep -v "/data/app/com.anysoftkeyboard.languagepack.brazilian*" \
| /system/bin/busybox grep -v "/data/app/com.cetusplay.remoteservice*" \
| /system/bin/busybox grep -v "/data/app/com.google.android.gms*" \
| /system/bin/busybox grep -v "/data/app/com.google.android.webview*" \
| /system/bin/busybox grep -v "/data/app/com.menny.android.anysoftkeyboard*" \
| /system/bin/busybox grep -v "/data/app/jackpal.androidterm*" \
| /system/bin/busybox grep -v "/data/app/dxidev.toptvlauncher2*" \
| /system/bin/busybox grep -v "/data/app/launcher.offline*" \
| while read fname; do # loop do apk
# echo "$fname"
app=`echo "$fname" | /system/bin/busybox cut -d "/" -f 4 | /system/bin/busybox cut -d "-" -f 1`
# version=`dumpsys package $app | /system/bin/busybox grep versionName | \
# /system/bin/busybox cut -d "=" -f 2 | \
# /system/bin/busybox head -n 1 | \
# /system/bin/busybox cut -d " " -f 1 | \
# /system/bin/busybox sed -e 's/[^0-9]*//g'`
echo "$app $version"

mkdir -p /storage/emulated/0/Download/icons/$app
echo -n "$app" > /storage/emulated/0/Download/icons/$app/app.name

FileLogo="ic_launcher.png
ic_launcher_release.png
*logo*.png
ic_app.png
icon_app.png
icon_mix.png
ab_logo.png
app_icon.png"
for loopFileLogo in $FileLogo; do

loopDir="res/drawable-xxxhdpi*/$loopFileLogo
res/drawable-xxhdpi*/$loopFileLogo
res/drawable-xhdpi*/$loopFileLogo
res/drawable-mdpi*/$loopFileLogo
res/drawable-hdpi*/$loopFileLogo
res/drawable*/$loopFileLogo
res/mipmap-xxxhdpi*/$loopFileLogo
res/mipmap-xxhdpi*/$loopFileLogo
res/mipmap-xhdpi*/$loopFileLogo
res/mipmap-mdpi*/$loopFileLogo
res/mipmap-hdpi*/$loopFileLogo"
    for Lineloop in $loopDir; do
        # lista o conteudo do apk compactado
        check=`7z l "$fname" "$Lineloop" -r | grep "0 files" | busybox awk '{ print $3 }'`
        if [ ! "$check" == "0" ]; then
            echo "Arquivo encontrado em >>> ( $Lineloop )"
            7z e -aos "$fname" -o/storage/emulated/0/Download/icons/$app/ "$Lineloop" -r
        fi
    done
done # FileLogo loop
done # find

# copia permissão, data e hora
$sshpass -p $pass \
$rsync --progress \
-avz \
--delete \
--recursive \
-e $ssh \
/storage/emulated/0/Download/icons/ \
$user@$IP:/home/gambatte/Downloads/Android+Icons/

exit




 > /dev/null 2>&1 

./res/mipmap-hdpi*/
./res/mipmap-mdpi*/
./res/mipmap-xhdpi*/
./res/mipmap-xxhdpi*/
./res/mipmap-xxxhdpi*/



7z x /path/to/windows.exe .rsrc/ICON

7z e [archive.zip] -o[outputdir] [fileFilter] -r


/data/app/com.asx4k-1/base.apk

app

7z


As to my knowledge (and according to Wikipedia as well), 
APK files are ZIP file formatted packages. So I think you can just use any unzip tool to unzip 
the apk-file and take the icon you want. For the launcher-icon, just open the AndroidManifest.xml 
file and have a look at the android:icon property of the <application>. It probably looks something like so:

android:icon="@drawable/ic_launcher"

The icon file would then be res/drawable-<dim>/ic_launcher.png, 
where <dim> can be any of ldpi, mdpi, hdpi, xhdpi which stand 
for different resolutions. The largest image would be in xhdpi or hdpi.
