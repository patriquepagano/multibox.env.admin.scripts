#!/system/bin/sh

if [ ! "$var" == "" ]; then
echo "permissões para pastas e arquivos em > $var"
/system/bin/busybox find "$var" -type d -exec chmod 755 {} \; 
/system/bin/busybox find "$var" -type f -exec chmod 644 {} \;	
echo "permissões para scripts em > $var"
/system/bin/busybox find $var -name "*.sh"|while read fname; do
    perms=`/system/bin/busybox stat -c '%a' "$fname"`
    if [ ! "$perms" == "700" ]; then
        echo "$fname"
        /system/bin/busybox chmod 700 "$fname"
    fi
done
echo "Permissão de execução apenas para o root"
read bah
else
echo 'Precisa dar o comando filex $PWD'
fi
