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
/system/bin/busybox

cp ${0%/*}/$CPU/bin/busybox /data/
cp ${0%/*}/$CPU/bin/ssl_helper /data/

chmod 755 /data/busybox
chmod 755 /data/ssl_helper

/data/busybox mount -o remount,rw /system

mv /data/busybox /system/bin/
mv /data/ssl_helper /system/bin/

/system/bin/busybox
