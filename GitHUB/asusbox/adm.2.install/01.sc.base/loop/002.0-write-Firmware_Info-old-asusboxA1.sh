
# este arquivo dita completamente as informações do firmware original!
# apos alterar o build.prop o ro.build.fingerprint é alterado.
# este arquivo deve ser gerado na criação do firmware

# desativado isto não tem uso no futuro apagar o arquivo > /system/Firmware_Info
# muitas box não gravaram este arquivo sei la pq ?

# if [ ! -f /system/Firmware_Info ]; then
# /system/bin/busybox mount -o remount,rw /system
# cat << EOF > /system/Firmware_Info
# Android OS = $(getprop ro.build.version.release)
# API Level = $(getprop ro.build.version.sdk)
# Dispositivo = $(getprop ro.product.device)
# Placa = $(getprop ro.product.board)
# Fabricante = $(getprop ro.product.manufacturer)
# cpu = $(getprop ro.product.cpu.abi)
# Modelo = $(getprop ro.product.model)
# Nome = $(getprop ro.product.name)
# fingerprint = $(getprop ro.build.fingerprint)
# date.utc = $(getprop ro.build.date.utc)
# date = $(getprop ro.build.date)
# description = $(getprop ro.build.description)
# bootimage.build.fingerprint = $(getprop ro.bootimage.build.fingerprint)
# display.id = $(getprop ro.build.display.id)
# version.incremental = $(getprop ro.build.version.incremental)
# EOF
# # cat /system/Firmware_Info
# # ideia interessante para comparar strings via shell. mas pessimo para leitura humana
# #FirwareUUID=`/system/bin/busybox md5sum "/system/Firmware_Info" | /system/bin/busybox cut -d ' ' -f1`
# # mv /system/Firmware_Info /system/Firmware_Info-$FirwareUUID
# #cp /system/Firmware_Info-$FirwareUUID ${0%/*}/
# /system/bin/busybox mount -o remount,ro /system
# fi

# filetmp="/data/trueDT/peer/Sync/Firmware_Info"
# if [ ! -f "$filetmp" ]; then
#     cp /system/Firmware_Info "$filetmp"
# fi



