
# echo "ADM DEBUG ### script de fechamento do generic user"

# # quem não participar desta lista tera seu syncthing fechado
# checkUserAcess=`echo "$BoxListSyncthingAlwaysOn" | grep "$Placa=$CpuSerial=$MacLanReal"`
# if [ "$checkUserAcess" == "" ]; then
#     rm /data/trueDT/peer/TMP/BoxListSyncthingAlwaysOn
# 	echo "$(date +"%d/%m/%Y %H:%M:%S") End Script routine " > $LogRealtime
#     checkVersion=`cat /data/trueDT/peer/TMP/BootVersion`
#     if [ ! "$checkVersion" == "$SHCBootVersion" ]; then
# 		ServerConfigPath="/data/trueDT/peer/config/config.xml"
# 		API=$(cat "$ServerConfigPath" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
# 		WebPort=$(cat "$ServerConfigPath" | grep "127.0.0.1" | cut -d ":" -f 2 | cut -d "<" -f 1)
# 		User=$(cat "$ServerConfigPath" | grep "<user>" | cut -d ">" -f 2 | cut -d "<" -f 1)

# 		RemoteDevice="4W74FHY-6B2IOVI-RTE2BDJ-67C4I6V-6O7LADH-2TIOHZX-N7HRKTN-F7UK2A3"
# 		folderID="log_$Placa=$CpuSerial=$MacLanReal"

# 		echo "ADM DEBUG ########################################################"
# 		echo "ADM DEBUG ### override sendonly profile solução temporaria para o bug dos arquivos que somem"
# 		echo "ADM DEBUG ### p2p.status.Verifying.live error.p2p.FolderPack.md5.v2.log"
# 		curl -u "$User":"$User" -X POST -H "X-API-Key: $API" "http://127.0.0.1:$WebPort/rest/db/override?folder=log_$DeviceName"

# 		echo "ADM DEBUG ######################################################################"
# 		echo "ADM DEBUG ### força um scan na pasta LOG"
# 		curl -u "$User":"$User" -X POST -H "X-API-Key: $API" "http://127.0.0.1:$WebPort/rest/db/scan?folder=$folderID"

#         #while [ 1 ]; do # travar em loop pessima ideia se meu server estiver off
#         # 100 repetições com pausas de 3 segundos vai dar 5 minutos de espera no looping
#         for i in $(seq 1 20); do
#             data=`curl -u "$User":"$User" --silent -X GET -H "X-API-Key: $API" "http://127.0.0.1:$WebPort/rest/db/completion?folder=$folderID&device=$RemoteDevice"`
#             #echo "$data"
#             completion=`echo "$data" | grep "completion" | cut -d "," -f 1 | cut -d " " -f 4`
#             echo "Aguardando a pasta sincronizar em 100% estado atual = $completion%"
#             if [ "$completion" == "100" ]; then
#                 echo "ADM DEBUG ### Sincronizado! em = $completion%"
#                 echo "ADM DEBUG ### Gravando o marcador SHCBootVersion"
#                 # o marcador SHCBootVersion vai no final do loop apos a conclusão dos 100%
#                 # com isto não é possivel se ter a ultima versão do SHCBootVersion na pasta Sync
#                 echo -n "$SHCBootVersion" > "/data/trueDT/peer/TMP/BootVersion"
#                 break
#             else
#                 echo "Server Sync esta offline"
#             fi
#             sleep 3
#         done;
# 		# vai fechar o syncthing geral para todos!
# 		DELFoldersPairs
# 		"/data/asusbox/.sc/boot/initRc.drv/[STOP].sh"		
#     fi
# fi



"/data/asusbox/.sc/boot/initRc.drv/[STOP].sh"	


USBLOGCALL="initRc.drv [STOP]"
OutputLogUsb




