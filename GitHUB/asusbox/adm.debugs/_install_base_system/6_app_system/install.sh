#!/system/bin/sh
clear
echo "# arguments called with ---->  ${@}     "
echo "# \$1 ---------------------->  $1       "
echo "# \$2 ---------------------->  $2       "
echo "# path to me --------------->  ${0}     "
echo "# parent path -------------->  ${0%/*}  "
echo "# my name ------------------>  ${0##*/} "
export CPU=`getprop ro.product.cpu.abi`




/system/bin/busybox mount -o remount,rw /system
cp ${0%/*}/*.apk /system/app/
chmod 644 /system/app/*.apk


