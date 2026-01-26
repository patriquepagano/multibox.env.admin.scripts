#!/system/bin/sh
path=$(dirname $0)
clear

/system/bin/busybox md5sum "/system/build.prop" | /system/bin/busybox cut -d ' ' -f1


BuildPropLocal=`/system/bin/busybox cat "/system/build.prop" | /system/bin/busybox base64`

echo -n "BuildPropLocal=\"$BuildPropLocal\"" > $path/BuildPropLocal


cat $path/BuildPropLocal | /system/bin/busybox base64 -d > $path/BuildPropLocal.ini

/system/bin/busybox md5sum "$path/BuildPropLocal.ini" | /system/bin/busybox cut -d ' ' -f1

# echo  'linuxhint.com' | base64
# Output:


# Example#2: Decoding text data
# The following command will decode the encoded text, ‘bGludXhoaW50LmNvbQ==‘ and print the original text as output.

# $ echo 'bGludXhoaW50LmNvbQo=' | base64 --decode