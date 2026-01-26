#!/system/bin/sh

# pkg files curl
clear
Dir=$(dirname $0)
source $Dir/_function.sh

export pack="curl"
export cmd="/system/usr/bin/curl --version"
cat << EOF > "$Dir/$pack.FileList"
/data/data/com.termux/files/usr/bin
/data/data/com.termux/files/usr/bin/curl
EOF

SyncGenerateList

DebugBINs

bkpBins

# clean
rm "$Dir/$pack.FileList" > /dev/null 2>&1

exit

# # copiar para um smb share
# https://github.com/curl/curl/issues/3535
/system/bin/curl -v --upload-file -T "{/data/data/com.termux/files/usr/etc/wgetrc,/data/data/com.termux/files/usr/etc/xattr.conf}" -u '.\personaltecnico:admger9pqt' smb://10.0.0.113/d/





