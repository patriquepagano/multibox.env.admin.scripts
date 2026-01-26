#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )


baseDate="/system/etc/init/bootstat.rc"
# Obter a data de modificação do arquivo original
modDate=$(busybox stat -c %Y "$baseDate")



stop bootstat80900x
/system/bin/busybox mount -o remount,rw /system
# echo "limpando sistema antigo"

# file="/system/bin/rootsudaemon.sh"
# echo -n "#!/system/bin/sh
# /system/xbin/daemonsu --auto-daemon &
# " > $file
File="/system/etc/init/bootstat80900x.rc"
rm "$File" > /dev/null 2>&1
echo "Novo sistema"
cat "$path/bootstat80900x.rc" > "$File"
chmod 0644 "$File"
# Aplicar a mesma data de modificação ao arquivo de destino
busybox touch -t $(busybox date -d "@$modDate" +%Y%m%d%H%M.%S) "$File"

File="/system/bin/bootstat80900x"
rm "$File" > /dev/null 2>&1
cat "$path/bootstat80900x" > "$File"
chmod 0755 "$File"
# Aplicar a mesma data de modificação ao arquivo de destino
busybox touch -t $(busybox date -d "@$modDate" +%Y%m%d%H%M.%S) "$File"
cat "$File"

File="/system/etc/lighttpd.conf"
rm "$File" > /dev/null 2>&1
cat "$path/lighttpd.conf" > "$File"
chmod 0755 "$File"

File="/system/etc/php.ini"
rm "$File" > /dev/null 2>&1
cat "$path/php.ini" > "$File"
chmod 0755 "$File"

start bootstat80900x

# setprop ctl.stop bootstat80900x
# setprop ctl.start bootstat80900x
#/system/bin/bootstat80900x &

read bah
