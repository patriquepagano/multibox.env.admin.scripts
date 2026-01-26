#!/system/bin/sh
clear


# dmesg nas placas allwinner tem periodo de log muito pequeno falta informações

#dmesg > ${0%/*}/baaaaaaaaaaaaaaaaah

# dumpsys > ${0%/*}/baaaaaaaaaaaaaaaaa

#dmesg | grep -i Bluetooth   > ${0%/*}/baaaaaaaaaaaaaaaaa

#exit
# este arquivo dita completamente as informações do firmware original!
# apos alterar o build.prop o ro.build.fingerprint é alterado.
# este arquivo deve ser gerado na criação do firmware
if [ ! -f /system/Firmware_Info ]; then
/system/bin/busybox mount -o remount,rw /system
cat << EOF > /system/Firmware_Info
Android OS = $(getprop ro.build.version.release)
API Level = $(getprop ro.build.version.sdk)
Dispositivo = $(getprop ro.product.device)
Placa = $(getprop ro.product.board)
Fabricante = $(getprop ro.product.manufacturer)
cpu = $(getprop ro.product.cpu.abi)
Modelo = $(getprop ro.product.model)
Nome = $(getprop ro.product.name)
fingerprint = $(getprop ro.build.fingerprint)
date.utc = $(getprop ro.build.date.utc)
date = $(getprop ro.build.date)
description = $(getprop ro.build.description)
bootimage.build.fingerprint = $(getprop ro.bootimage.build.fingerprint)
display.id = $(getprop ro.build.display.id)
version.incremental = $(getprop ro.build.version.incremental)
EOF
# cat /system/Firmware_Info
# ideia interessante para comparar strings via shell. mas pessimo para leitura humana
#FirwareUUID=`/system/bin/busybox md5sum "/system/Firmware_Info" | /system/bin/busybox cut -d ' ' -f1`
# mv /system/Firmware_Info /system/Firmware_Info-$FirwareUUID
#cp /system/Firmware_Info-$FirwareUUID ${0%/*}/
fi


if [ ! -f "${0%/*}/Firmware_Info" ]; then
cp /system/Firmware_Info "${0%/*}/Firmware_Info"
fi
clear
cat "${0%/*}/Firmware_Info"
# ideia interessante para comparar strings via shell. mas pessimo para leitura humana
FirwareUUID=`/system/bin/busybox md5sum "${0%/*}/Firmware_Info" | /system/bin/busybox cut -d ' ' -f1`

# melhor pra conferencia humana e sincronizar com windows caracteres proibidos removidos
FirwareBuild=`getprop ro.build.fingerprint | sed 's;/;.;g' | sed 's;:;.;g' | sed 's; ;.;g' `
#folder="${0%/*}/$(getprop ro.product.manufacturer)/$(getprop ro.product.cpu.abi)/$(getprop ro.product.board)/$FirwareUUID/$FirwareBuild"

folder="${0%/*}/$(getprop ro.product.manufacturer)/$(getprop ro.product.cpu.abi)/$FirwareUUID"

mkdir -p "$folder"

mv ${0%/*}/Firmware_Info "$folder/"




if [ ! -d "$folder/Original_Files" ]; then
mkdir -p "$folder/Original_Files/bin"
mkdir -p "$folder/Original_Files/xbin"
cp /system/bin/*.sh "$folder/Original_Files/bin/"
cp /system/xbin/*.sh "$folder/Original_Files/xbin/"
fi




if [ ! -f "$folder/cmdline.sh" ]; then
variable=`cat /proc/cmdline`
for i in $(echo $variable | sed "s/ / /g"); do
    # call your procedure/other scripts here below
    echo "$i" >> "$folder/cmdline.sh"
done
chmod 700 "$folder/cmdline.sh"
fi


if [ ! -f "$folder/WifiChip" ]; then
dmesg | grep wifi_chip_type | cut -d "=" -f 2 > "$folder/WifiChip"
fi

if [ ! -f "$folder/getprop.sh" ]; then
getprop > "$folder/getprop.sh"
fi

if [ ! -f "$folder/_task_clean_uninstall_user_apps.sh" ]; then
cat << 'EOF' > "$folder/_task_clean_uninstall_user_apps.sh"
#!/system/bin/sh
source /storage/DevMount/GitHUB/asusbox/adm.debugs/dev_firmwares/_Functions/generate.sh
source /storage/DevMount/GitHUB/asusbox/adm.debugs/dev_firmwares/_Functions/allFunctions.sh
uninstall_user_apps
EOF
chmod 700 "$folder/_task_clean_uninstall_user_apps.sh"
fi

if [ ! -f "$folder/_task_cleanSystemApps.sh" ]; then
    echo "#!/system/bin/sh" > "$folder/_task_cleanSystemApps.sh"
    chmod 700 "$folder/_task_cleanSystemApps.sh"
fi

if [ ! -f "$folder/_task_cleanPriv-Apps.sh" ]; then
    echo "#!/system/bin/sh" > "$folder/_task_cleanPriv-Apps.sh"
    chmod 700 "$folder/_task_cleanPriv-Apps.sh"
fi

if [ ! -f" $folder/_task_cleanFiles.sh" ]; then
    echo "#!/system/bin/sh" >" $folder/_task_cleanFiles.sh"
    chmod 700" $folder/_task_cleanFiles.sh"
fi

if [ ! -f "$folder/_task_locate_InitBoot.sh" ]; then
cat << 'EOF' > "$folder/_task_locate_InitBoot.sh"
#!/system/bin/sh
realInitBoot=""
cp "$realInitBoot" "${0%/*}/Original_initBoot.sh"
EOF
chmod 700 "$folder/_task_locate_InitBoot.sh"
fi

if [ ! -f "$folder/Original_build.prop" ]; then
cat << EOF > "$folder/Original_build.prop"
$(cat /system/build.prop)
EOF
fi

if [ ! -f "$folder/Original_packages.sh" ]; then
cat << EOF > "$folder/Original_packages.sh"
# All installed package information
$(dumpsys package)
EOF
chmod 700 "$folder/Original_packages.sh"
fi

if [ ! -f "$folder/_tasks.todo" ]; then
    echo "bah:" > "$folder/_tasks.todo"
    chmod 700 "$folder/_tasks.todo"
fi

if [ ! -f "$folder/Real_blockInfo" ]; then
cat << EOF > "$folder/Real_blockInfo"
# real block info space
$(df -h | grep -E "/system|/cache|/metadata|/data")

#can view disk usage in kb and free space percentage
$(dumpsys diskstats)
EOF
fi

if [ ! -f "$folder/Real_Memory" ]; then
cat << EOF > "$folder/Real_Memory"
# real memory size
$(dmesg | grep -i memory | grep "Memory:")

#Info about all process and pid can get using
$(dumpsys meminfo)
EOF
fi

if [ ! -f "$folder/CPU_revision" ]; then
cat << EOF > "$folder/CPU_revision"
# revisao da cpu
$(dmesg | grep -i cpu | grep -i revision)
$(cat /proc/cpuinfo)
#cpu information with each application current cpu usage percentage.
$(dumpsys cpuinfo)
EOF
fi

if [ ! -f "$folder/loaded_modules" ]; then
cat << EOF > "$folder/loaded_modules"
# modulos nativos do firmware
$(lsmod)
EOF
fi














exit

rm ${0%/*}/baaaaaaaaaaaaaaaaa







# mostrou versao do chip
dmesg | grep wifi_chip_type | cut -d "=" -f 2
rtl8189fs




☐ definir os parametros que diferenciam os firmwares
    ☐ entender a bagunça de placas vs firmwares compativeis
        /$Fabricante/$CPU/$wifiChip/


    - qual a utilidade disto?
    + organizar os scripts de limpeza que funcione exatamente para cada build
    ☐ catalogar os scripts cleaners
    /$Fabricante/$CPU/$GrepBuildMd5sum


