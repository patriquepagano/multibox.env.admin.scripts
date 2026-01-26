

# echo "ADM DEBUG #############################################################"
# echo "ADM DEBUG ### scripts for BoxListSyncthingAlwaysOn "
# echo "ADM DEBUG ### precisa carregar primeiro que o syncthing loader global"
# checkUserAcess=`echo "$BoxListSyncthingAlwaysOn" | grep "$Placa=$CpuSerial=$MacLanReal"`
# if [ ! "$checkUserAcess" == "" ]; then
#     echo "ADM DEBUG ### ativa o syncthing para quem participar deste grupo BoxListSyncthingAlwaysOn"
#     if [ ! -f /data/trueDT/peer/TMP/BoxListSyncthingAlwaysOn ]; then
#         echo "enable" > /data/trueDT/peer/TMP/BoxListSyncthingAlwaysOn
#     fi
#     /data/asusbox/.sc/boot/initRc.drv/{START}.sh
#     sleep 5
#     /data/asusbox/.sc/boot/initRc.drv/config.defaults.sh
# fi


# echo "ADM DEBUG ########################################################"
# echo "ADM DEBUG ### scripts for BoxListBetaInstallers"
# checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial=$MacLanReal"`
# if [ ! "$checkUserAcess" == "" ]; then
#     # roda os scripts q existir nesta pasta
#     Folder="/data/trueDT/peer/BOOT/sh.dev"
#     if [ -d $Folder ]; then
#         echo "ADM DEBUG ########################################################"
#         echo "ADM DEBUG ### Runnig dev scripts"
#         /system/bin/busybox find $Folder -type f -name "*.sh" |while read FullFilePath; do
#             echo "ADM DEBUG ### $FullFilePath"
#             Senha7z="98ads59f78da5987f5a97d8s5f96ads85f968da78dsfynmd-9as0f-09ay8df876asd96ftadsb8f7an-sd809f"
#             Code=$(/system/bin/7z x -so -p$Senha7z "$FullFilePath")
#             eval "$Code"
#         done
#     fi
# fi


# echo "ADM DEBUG ########################################################"
# echo "ADM DEBUG ### scripts for BoxListADMIN"
# checkUserAcess=`echo "$BoxListADMIN" | grep "$Placa=$CpuSerial=$MacLanReal"`
# if [ ! "$checkUserAcess" == "" ]; then
#     Folder="/data/trueDT/peer/BOOT/sh.admin"
#     if [ -d $Folder ]; then
#         echo "ADM DEBUG ########################################################"
#         echo "ADM DEBUG ### Runnig admin scripts"
#         /system/bin/busybox find $Folder -type f -name "*.sh" |while read FullFilePath; do
#             echo "ADM DEBUG ### $FullFilePath"
#             Senha7z="98ads59f78da5987f5a97d8s5f96ads85f968da78dsfynmd-9as0f-09ay8df876asd96ftadsb8f7an-sd809f"
#             Code=$(/system/bin/7z x -so -p$Senha7z "$FullFilePath")
#             eval "$Code"
#         done
#     fi
# fi





