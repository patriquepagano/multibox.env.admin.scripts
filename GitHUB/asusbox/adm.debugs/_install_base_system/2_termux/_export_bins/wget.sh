#!/system/bin/sh
# pkg files wget
clear
Dir=$(dirname $0)
source $Dir/_function.sh

export pack="wget"
export cmd="/system/usr/bin/wget --version"
cat << EOF > "$Dir/$pack.FileList"
/data/data/com.termux/files/usr/etc
/data/data/com.termux/files/usr/etc/wgetrc
/data/data/com.termux/files/usr/bin
/data/data/com.termux/files/usr/bin/wget
EOF

SyncGenerateList

DebugBINs

bkpBins

# clean
rm "$Dir/$pack.FileList" > /dev/null 2>&1

