
# # criar um função para o start loader do syncthing
# function DELFoldersPairs () {
#     # ANTIGOS PROFILES NÃO PODE APAGAR DA PASTA INIT
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### remove server MGADARQ"
#     /data/asusbox/.sc/boot/initRc.drv/MGADARQ=DEL.LOG.sh
#     /data/asusbox/.sc/boot/initRc.drv/MGADARQ=DEL.BOOT.sh
#     # novos configs pair
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### remove server "
#     /data/asusbox/.sc/boot/initRc.drv/ServerPair=DEL.Upload.Log.sh
#     /data/asusbox/.sc/boot/initRc.drv/ServerPair=DEL.BOOT.sh
# }

# function ImportProfilesPairs () {
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### importa os profiles"
#     /data/asusbox/.sc/boot/initRc.drv/ServerPair=iMPORT.Upload.Log.sh
#     /data/asusbox/.sc/boot/initRc.drv/ServerPair=IMPORT.BOOT.sh
# }


# os clientes só vão ligar o syncthing se tiver novidades no UPdateSystem!
# + vai economizar recursos de CPU na box

echo -n "$SHCBootVersion" > /data/trueDT/peer/Sync/BootVersion.live

rm /data/trueDT/peer/TMP/SHCBootVersion > /dev/null 2>&1
rm /data/trueDT/peer/Sync/SHCBootVersion > /dev/null 2>&1
rm /data/trueDT/peer/Sync/BootVersion > /dev/null 2>&1

# checkVersion=`cat /data/trueDT/peer/TMP/BootVersion`
# if [ ! "$checkVersion" == "$SHCBootVersion" ]; then
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### Nova versão de SHCBootVersion detectado!"
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### boot start syncthing via screen"
#     /data/asusbox/.sc/boot/initRc.drv/{START}.sh
# 	echo "$(date +"%d/%m/%Y %H:%M:%S") sync realtime started" > $LogRealtime
# 	# aqui fica o registro de geo localização
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### setting default configs to syncthing"
#     echo "ADM DEBUG ### sleep necessário  para não dar erro nas configs"
#     /data/asusbox/.sc/boot/initRc.drv/config.defaults.sh
#     DELFoldersPairs
#     ImportProfilesPairs
#     # load script Qrcode ID
#     /data/asusbox/.sc/boot/initRc.drv/Qrcode.ID.sh
#     # load script qrcode IP
#     /data/asusbox/.sc/boot/initRc.drv/Qrcode.IP.Local.sh
# fi


# clean file logs
busybox find "/data/trueDT/peer/Sync/" -type f -name "*.p2p.FolderPack*.log" -delete
busybox find "/data/trueDT/peer/Sync/" -type f -name "p2p.status.*.live" -delete

# diretorios obsoletos migrar para lugar devido
# futuro fazer um eco para arquivo externo e concatenar com a variavel da limpeza
listApagar="/data/trueDT/peer/Sync/sh.admin
/data/trueDT/peer/Sync/sh.all
/data/trueDT/peer/Sync/sh.dev
/data/trueDT/peer/Sync/sh.uniq"
for delfolder in $listApagar; do
    if [ -d $delfolder ];then
       busybox rm -rf $delfolder
    fi
done





USBLOGCALL="sync loader step"
OutputLogUsb


