#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear


echo "
### blkid"
check=`busybox blkid | busybox grep "sd"`
if [ ! "$check" == "" ]; then
	echo "$check"
fi



