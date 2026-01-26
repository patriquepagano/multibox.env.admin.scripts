#!/system/bin/sh

# marcar o software original
#/system/bin/busybox mount -o remount,rw /system

SoftVersion="/system/softversion"




SoftVersion="${0%/*}/softversion"


if [ ! -e $SoftVersion ] ; then
echo "Dispositivo = `getprop ro.product.device`" >> $SoftVersion 2>&1
echo "Placa = `getprop ro.product.board`" >> $SoftVersion 2>&1
echo "Fabricante = `getprop ro.product.manufacturer`" >> $SoftVersion 2>&1
echo "cpu = `getprop ro.product.cpu.abi`" >> $SoftVersion 2>&1
echo "Modelo = `getprop ro.product.model`" >> $SoftVersion 2>&1
echo "Nome = `getprop ro.product.name`" >> $SoftVersion 2>&1
echo "fingerprint = `getprop ro.build.fingerprint`" >> $SoftVersion 2>&1
echo "date.utc = `getprop ro.build.date.utc`" >> $SoftVersion 2>&1
echo "description = `getprop ro.build.description`" >> $SoftVersion 2>&1
fi

clear
cat $SoftVersion

exit









# BusyBox information
# (c) 2015 Anton Skshidlevsky <meefik@gmail.com>, GPLv3

busybox printf "System:\n"
DEVICE=$(getprop ro.product.model)
busybox printf "* device: $DEVICE\n"
ANDROID=$(getprop ro.build.version.release)
busybox printf "* android: $ANDROID\n"
ARCH=$(busybox uname -m)
busybox printf "* architecture: $ARCH\n"

busybox printf "\nFree space:\n"
DATA_FREE=$(busybox df -Ph /data | busybox grep -v ^Filesystem | busybox awk '{print $4}')
busybox printf "* /data: $DATA_FREE\n"
SYSTEM_FREE=$(busybox df -Ph /system | busybox grep -v ^Filesystem | busybox awk '{print $4}')
busybox printf "* /system: $SYSTEM_FREE\n"

busybox printf "\nLatest BusyBox:\n"
BB_BIN=$(busybox which busybox)
BB_VERSION=$(busybox | busybox head -1 | busybox awk '{print $2}')
busybox printf "* version: $BB_VERSION\n"
BB_APPLETS=$(busybox --list | busybox wc -l)
busybox printf "* applets: $BB_APPLETS items\n"
BB_SIZE=$(busybox stat -c '%s' $BB_BIN)
busybox printf "* size: $BB_SIZE bytes\n"
BB_MD5=$(busybox md5sum $BB_BIN | busybox awk '{print $1}')
busybox printf "* md5: $BB_MD5\n"

busybox printf "\nInstalled BusyBox:\n"
BB_BIN=""
if busybox test -e "$INSTALL_DIR/busybox"
then
    BB_PATH="$INSTALL_DIR"
    BB_BIN="$BB_PATH/busybox"
elif busybox test -e "/system/bin/busybox"
then
    BB_PATH="/system/bin"
    BB_BIN="$BB_PATH/busybox"
elif busybox test -e "/system/xbin/busybox"
then
    BB_PATH="/system/xbin"
    BB_BIN="$BB_PATH/busybox"
fi
if busybox test -e "$BB_BIN"
then
    busybox printf "* location: $BB_PATH\n"
    BB_VERSION=$($BB_BIN | busybox head -1 | busybox awk '{print $2}')
    busybox printf "* version: $BB_VERSION\n"
    BB_APPLETS=$($BB_BIN --list | busybox wc -l)
    busybox printf "* applets: $BB_APPLETS items\n"
    BB_SIZE=$(busybox stat -c '%s' $BB_BIN)
    busybox printf "* size: $BB_SIZE bytes\n"
    BB_MD5=$(busybox md5sum $BB_BIN | busybox awk '{print $1}')
    busybox printf "* md5: $BB_MD5\n"
else
    busybox printf "* not installed\n"
fi
