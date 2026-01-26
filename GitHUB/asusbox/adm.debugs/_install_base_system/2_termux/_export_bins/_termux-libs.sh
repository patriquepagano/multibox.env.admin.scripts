#!/system/bin/sh
# precisa rodar via sshdroid
clear
Dir=$(dirname $0)
source $Dir/_function.sh

export pack="_termux-libs"
cat <<EOF > "$Dir/$pack.FileList"
/data/data/com.termux/files/usr/lib/p7zip/Codecs/Rar.so
/data/data/com.termux/files/usr/lib/p7zip/7z
/data/data/com.termux/files/usr/lib/p7zip/7z.so
/data/data/com.termux/files/usr/lib/p7zip/7za
/data/data/com.termux/files/usr/lib/libc++_shared.so
/data/data/com.termux/files/usr/lib/libandroid-support.so
/data/data/com.termux/files/usr/lib/libreadline.so.8
/data/data/com.termux/files/usr/lib/libreadline.so.8.0
/data/data/com.termux/files/usr/lib/libreadline.so.8.1
/data/data/com.termux/files/usr/lib/libncursesw.so.6
/data/data/com.termux/files/usr/lib/libncursesw.so.6.2
/data/data/com.termux/files/usr/lib/libcurl.so
/data/data/com.termux/files/usr/lib/libz.so.1
/data/data/com.termux/files/usr/lib/libz.so.1.2.11
/data/data/com.termux/files/usr/lib/libnghttp2.so
/data/data/com.termux/files/usr/lib/libssh2.so
/data/data/com.termux/files/usr/lib/libssl.so.1.1
/data/data/com.termux/files/usr/lib/libcrypto.so.1.1
/data/data/com.termux/files/usr/lib/libandroid-glob.so
/data/data/com.termux/files/usr/lib/libpopt.so
/data/data/com.termux/files/usr/lib/liblz4.so.1
/data/data/com.termux/files/usr/lib/liblz4.so.1.9.3
/data/data/com.termux/files/usr/lib/libzstd.so
/data/data/com.termux/files/usr/lib/libzstd.so.1
/data/data/com.termux/files/usr/lib/libzstd.so.1.4.5
/data/data/com.termux/files/usr/lib/libcrypt.so
/data/data/com.termux/files/usr/lib/libminiupnpc.so
/data/data/com.termux/files/usr/lib/libevent-2.1.so
/data/data/com.termux/files/usr/lib/libpcre2-8.so
/data/data/com.termux/files/usr/lib/libuuid.so.1
/data/data/com.termux/files/usr/lib/libuuid.so.1.0.0
EOF

SyncGenerateList

bkpBins

# clean
rm "$Dir/$pack.FileList" > /dev/null 2>&1

exit






