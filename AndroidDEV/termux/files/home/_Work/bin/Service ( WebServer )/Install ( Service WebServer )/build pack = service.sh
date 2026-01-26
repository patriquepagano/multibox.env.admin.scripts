#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )


baseDate="/system/etc/init/bootstat.rc"
# Obter a data de modificação do arquivo original
modDate=$(busybox stat -c %Y "$baseDate")

mkdir -p "$path/Export"

tarFile="$path/Export/bootstat80900x.tar.gz"
rm "$tarFile"
FileList="/system/etc/init/bootstat80900x.rc
/system/bin/bootstat80900x
/system/etc/lighttpd.conf
/system/etc/php.ini"

/system/bin/busybox tar -czvf "$tarFile" $FileList

# Aplicar a mesma data de modificação ao arquivo de destino
busybox touch -t $(busybox date -d "@$modDate" +%Y%m%d%H%M.%S) "$tarFile"

Senha7z="batata"
Zfile="$path/Export/essential-0003.0.key"
rm "$Zfile"
# 7zip
/system/bin/7z a -mx=9 -p$Senha7z -mhe=on -t7z -y "$Zfile" "$tarFile"

# Aplicar a mesma data de modificação ao arquivo de destino
busybox touch -t $(busybox date -d "@$modDate" +%Y%m%d%H%M.%S) "$Zfile"

rm "$tarFile"
du -hs "$Zfile"

read bah

