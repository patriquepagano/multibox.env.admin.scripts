#!/system/bin/sh

DIR=$(dirname $0)

path=`echo $DIR | /system/bin/busybox sed 's;/adm.0.git/fileTasks;;g'`

clear
echo $path

exit
não to gostando desta ideia de mudar em massa tudo
/system/bin/busybox find "$path" -type f -name "*.sh"| sort | while read fname; do
    echo "$fname"
    /system/bin/busybox sed -i -e  's/echo "ADM DEBUG ###.*/#barbaridade/g' "$fname"
done









# 00.boot
path="/data/asusbox/adm.2.install/00.boot/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    echo "$fname"
    cat "$fname" >> $file
done

# 00.snib
path="/data/asusbox/adm.2.install/00.snib/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    echo "$fname"
    cat "$fname" >> $file
done

# 01.sc.base
path="/data/asusbox/adm.2.install/01.sc.base/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    echo "$fname"
    cat "$fname" >> $file
done


