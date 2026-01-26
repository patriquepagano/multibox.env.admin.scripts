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
chmod 700 ${0%/*}/$CPU/*
cp ${0%/*}/$CPU/* /system/usr/bin/



# com.giis.parted4Android_0.0.2.2 extraido deste apk
# https://play.google.com/store/apps/details?id=com.giis.parted4Android&hl=pt_BR&gl=US


