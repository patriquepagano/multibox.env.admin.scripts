#!/system/bin/sh


/system/bin/busybox find "/data/asusbox/.install/" -type d -name "*" \
| /system/bin/busybox grep -v -f /data/local/tmp/.install.clean \
| while read fname; do
    Fileloop=`basename $fname`
    echo "eu vou apagar este arquivo > $fname"
    #echo $Fileloop
done






exit


file=`cat "/data/local/tmp/appList"`
echo "$file" | while IFS= read -r line ; do
    echo $line
    pm clear $line
done

quem não estiver nesta lista vai ser desinstalado.



find ... | grep -v -f excludefile | grep -f includefile | cpio ...


/system/bin/busybox find "$path/$FileName/" -type f -name "*"|while read fname; do
    Fileloop=`basename $fname`
    echo "" >> "$path/$FileName-list.txt"
    echo -n "$path/$FileName/;$Fileloop" >> "$path/$FileName-list.txt"
done