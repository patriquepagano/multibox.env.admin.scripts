#!/system/bin/sh
clear
echo "# arguments called with ---->  ${@}     "
echo "# \$1 ---------------------->  $1       "
echo "# \$2 ---------------------->  $2       "
echo "# path to me --------------->  ${0}     "
echo "# parent path -------------->  ${0%/*}  "
echo "# my name ------------------>  ${0##*/} "
export CPU=`getprop ro.product.cpu.abi`

echo "detectado $CPU para o modulo"
echo "versão atual é"
/system/bin/aria2c -v

/system/bin/busybox mount -o remount,rw /system

cp ${0%/*}/com.gianlu.aria2app_5.9.3/lib/$CPU/libaria2c.so /system/bin/aria2c

chmod 755 /system/bin/aria2c

echo "nova versão é"
/system/bin/aria2c -v


