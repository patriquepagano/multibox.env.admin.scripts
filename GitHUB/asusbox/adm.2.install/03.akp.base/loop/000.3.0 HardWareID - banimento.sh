# rk30sdk=2f7ebd80446d5af0=C6626C8FAA72 box dev 10.0.0.100
# rk30sdk=eebf1d74a9420b09=A81803BF952A box dev 102
# rk30sdk=2967411471246256=A81805C3E470 box taramis
# rk30sdk=0c21973ba9ee3b16=A81803BFD45A;Internacionais;A Boliviano reseller
# rk30sdk=d9e4c0161a42e1bc=A2884CEF8A70;Internacionais;US Florida Melbourne
# rk30sdk=68da431a4cb079a4=A81702CE6D4F;Internacionais;PT Leiria Nazaré ( este ainda continua utilizando mesmo cpu e mac )
# ;Internacionais;BO Cochabamba Cochabamba
# rk30sdk=0c2d864754c450b4=22DF714E166E;Internacionais;AU New South Wales Sydney
# ;Internacionais;AE Abu Dhabi Al Ain City
# rk30sdk=774aa5bc9daae031=9E581D43F5A4 ; dayana que ligou para proeletronic

BlockListDevices="
rk30sdk=2967411471246256=A81805C3E470
rk30sdk=dc838b5d12567e87=F0CEEEEA30A9
rk30sdk=48eb0f5085ee6981=A82009A360FD
rk30sdk=774aa5bc9daae031=9E581D43F5A4
"
checkUserAcess=`echo "$BlockListDevices" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ ! "$checkUserAcess" == "" ]; then
# residuos do firmware antigo 2.4ghz
/system/bin/busybox mount -o remount,rw /system
rm /system/media/bootanimation.zip
rm /system/app/quickboot.apk
rm /system/app/notify.apk
rm /system/app/me.kuder.diskinfo.apk
rm /system/app/com.mixplorer.apk
rm /system/app/com.menny.android.anysoftkeyboard_1.10.606.apk
rm /system/app/com.anysoftkeyboard.languagepack.brazilian_4.0.516.apk
rm /system/p2pWebUi.v2.0.log
rm /system/Firmware_Info
rm -rf /system/asusbox
# chaveando o root
echo -n 'FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd' > /system/.pin
chmod 644 /system/.pin

# instalando a launcher 
####################### AKP Results >>> Thu Jun  3 17:02:11 BRT 2021
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="akpb.003"
app="dxidev.toptvlauncher2"
versionNameOnline="Thu Jun  3 16:06:36 BRT 2021"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/03.akp.base/akpb.003/AKP/akpb.003.AKP"
AKPouDTF="AKP"
CheckAKPinstallP2P

# movendo app para system
apkFile=$(busybox find /data/app -type f -name "*" -name "base.apk" | grep dxidev.toptvlauncher2)
/system/bin/busybox mount -o remount,rw /system
cp "$apkFile" /system/app/launcher.apk
chmod 644 /system/app/launcher.apk

########################################################
# Init services
rm /system/bin/init.21027.sh
rm /system/bin/init.80.900x.sh
rm /system/bin/init.update.boot.sh
rm /system/etc/init/init.21027.rc
rm /system/etc/init/init.update.boot.rc
rm /system/etc/init/init.80.900x.rc

# boot padrão geral da box
rm /system/etc/init/initRc.drv.01.01.97.rc
rm /system/bin/initRc.drv.01.01.97

########################################################
# binários mágicos
/system/bin/busybox mount -o remount,rw /system
rm /system/bin/busybox
rm /system/usr/lib/p7zip/7za
rm /system/usr/lib/libz.so.1.2.11
rm /system/usr/bin/bash
rm /system/usr/bin/curl
rm /system/usr/bin/lighttpd
rm /system/usr/bin/php-cgi
rm /system/usr/bin/rsync
rm /system/usr/bin/rsync-ssl
rm /system/usr/bin/screen
rm /system/usr/bin/transmission-create
rm /system/usr/bin/transmission-remote
rm /system/usr/bin/transmission-edit
rm /system/usr/bin/transmission-show
rm /system/usr/bin/transmission-daemon
rm /system/usr/bin/wget
rm /system/usr/bin/fdisk
rm /system/usr/bin/gdisk
rm /system/usr/bin/mkfs.ext4
rm /system/usr/bin/parted
rm /system/bin/aria2c
# isto é o binario do syncthing
rm /system/bin/initRc.drv.05.08.98

# resetar a box hard reset
am broadcast -a android.intent.action.MASTER_CLEAR
sleep 70
fi


USBLOGCALL="HardWareID - banimento"
OutputLogUsb


