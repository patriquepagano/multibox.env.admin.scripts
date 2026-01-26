#!/system/bin/sh

echo "# arguments called with ---->  ${@}     "
echo "# \$1 ---------------------->  $1       "
echo "# \$2 ---------------------->  $2       "
echo "# path to me --------------->  ${0}     "
echo "# parent path -------------->  ${0%/*}  "
echo "# my name ------------------>  ${0##*/} "

clear
#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib


rm -rf /data/data/com.termux > /dev/null 2>&1


echo "###################################################################################"
echo ""
/system/bin/bash --version
# funcionaaaaaaaaaaa
echo "###################################################################################"
echo ""
/system/bin/transmission-remote -V
echo "###################################################################################"
echo ""
/system/bin/screen --version
echo "###################################################################################"
echo ""
/system/usr/bin/rsync --version
echo "###################################################################################"
echo ""
/system/bin/curl --version
echo "###################################################################################"
echo ""
/system/bin/htop --version
echo "###################################################################################"
echo ""
/system/bin/lighttpd --version
echo "###################################################################################"
echo ""
/system/bin/wget --version
echo "###################################################################################"
echo ""
/system/bin/7z -h
echo "###################################################################################"
echo ""
/system/bin/node -v

# restaurando os symlinks
mkdir -p /data/data/com.termux > /dev/null 2>&1
ln -sf /storage/DevMount/AndroidDEV/termux/files /data/data/com.termux/ > /dev/null 2>&1
ln -sf /storage/DevMount/asusbox/.install /data/asusbox/ > /dev/null 2>&1








