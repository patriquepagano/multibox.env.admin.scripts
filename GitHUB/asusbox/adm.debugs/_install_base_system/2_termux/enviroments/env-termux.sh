#!/system/bin/bash
Dir=$(dirname $0)

env | sort > $Dir/env.var











exit

muita paranoia se no final funciona com apenas um binário. se algum dia precisar mudar eu taco um update

clear
Dir=$(dirname $0)
rm $DirChange/bash.list
# para extrair a lista de arquivos
# pkg files screen

list="/data/data/com.termux/files/usr/lib/bash
/data/data/com.termux/files/usr/bin/bash
/data/data/com.termux/files/usr/include/bash
/data/data/com.termux/files/usr/etc/profile
/data/data/com.termux/files/usr/etc/bash.bashrc"
for line in $list; do

if [[ -d $line ]]; then 
    #echo "$line is a Dir"
    DirChange=`echo $line | /system/bin/busybox sed 's;/data/data/com.termux/files/usr;/system;g'`
    echo "mkdir -p $DirChange"
    /system/bin/busybox mount -o remount,rw /system
    mkdir -p $DirChange
    /system/bin/rsync -ah --progress -rptv $line/ $DirChange/
    chown root:root -R $DirChange
elif [[ -f $line ]]; then 
    echo "$line is the File"
    FileChange=`echo $line | /system/bin/busybox sed 's;/data/data/com.termux/files/usr;/system;g'`
    /system/bin/rsync -ah --progress -rptv $line $FileChange
    chown root:root $FileChange
else 
    echo "Invalid path" 
fi
done

