#!/system/bin/sh
# pkg files rsync
clear
Dir=$(dirname $0)
source $Dir/_function.sh

export pack="rsync"
export cmd="/system/usr/bin/rsync --version"
cat << EOF > "$Dir/$pack.FileList"
/data/data/com.termux
/data/data/com.termux/files
/data/data/com.termux/files/usr
/data/data/com.termux/files/usr/bin
/data/data/com.termux/files/usr/bin/rsync
/data/data/com.termux/files/usr/bin/rsync-ssl
EOF

SyncGenerateList

DebugBINs

bkpBins

# clean
rm "$Dir/$pack.FileList" > /dev/null 2>&1

