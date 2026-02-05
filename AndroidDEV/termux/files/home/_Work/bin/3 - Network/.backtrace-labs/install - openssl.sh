#!/system/bin/sh
# Menu switch DNS - BusyBox / root limitado
# Compatível com Android TV boxes com BusyBox
clear

path="$( cd "${0%/*}" && pwd -P )"

BB=/system/bin/busybox


#  https://github.com/backtrace-labs/openssl-android-binary/tree/master/openssl-armeabi-v7a


du -hs "$path/.backtrace-labs"



# /data/openssl/
# ├── bin/
# │   └── openssl
# └── lib/
#     ├── libcrypto.so
#     └── libssl.so


# chmod 755 /data/openssl/bin/openssl
# chmod 644 /data/openssl/lib/*.so


echo "###############3 - instalado na box"
/system/usr/bin/openssl version -a
/system/usr/bin/openssl rand -hex 32



#echo "############## -- nova versao"

# # English comment: create SONAME symlinks in the same folder
# ln -sf "$path/.backtrace-labs/libssl.so"    "$path/.backtrace-labs/libssl.so.1.1"
# ln -sf "$path/.backtrace-labs/libcrypto.so" "$path/.backtrace-labs/libcrypto.so.1.1"

# # English comment: permissions
# chmod 755 "$path/.backtrace-labs/openssl"
# chmod 644 "$path/.backtrace-labs/"lib*.so*

# # English comment: run using only local libs
# LD_LIBRARY_PATH="$path/.backtrace-labs" "$path/.backtrace-labs/openssl" version -a
# LD_LIBRARY_PATH="$path/.backtrace-labs" "$path/.backtrace-labs/openssl" rand -hex 32




# ISTO BRICOU MEU TVBOX DEV BUILD
# $BB mount -o remount,rw /system
# cp "$path/.backtrace-labs/openssl" /system/usr/bin/openssl
# cp "$path/.backtrace-labs/libcrypto.so" /system/lib/libcrypto.so
# cp "$path/.backtrace-labs/libssl.so" /system/lib/libssl.so
# ln -sf /system/lib/libcrypto.so /system/lib/libcrypto.so.1.1
# ln -sf /system/lib/libssl.so /system/lib/libssl.so.1.1




    # $BB chmod 755 /data/local/tmp/openssl
    # 
    # $BB rm -f /system/usr/bin/openssl
    # $BB cp "/data/local/tmp/openssl" /system/usr/bin/openssl





if [ ! "$1" = "skip" ]; then
    echo "Press any key to exit."
    read -r bah
fi

