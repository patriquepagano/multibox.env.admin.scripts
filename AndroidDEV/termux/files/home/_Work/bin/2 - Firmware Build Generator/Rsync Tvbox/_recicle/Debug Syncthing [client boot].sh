#!/system/bin/sh


# idéia de usar o syncthing para receber e enviar arquivos log para central server:
#  - Number of Devices in Cluster	2	3	11	451
#     li relatos que o maximo foi 457 devices ligados a um master server para distribuir
#  - precisaria fazer o seguinte:
#     1) box liga, gera um syncthinID configura sua pasta de share
#     2) box envia via php post seu syncthinID para o vps
#     3) vps recebe o syncthinID e adiciona sei la como ao syncthing fechando uma parceria unica entre box cliente
#     4) syncronia unica é feita












#  Versão	v1.11.1, android (ARM)
file="/storage/DevMount/4Android/File_Manager/syncthing/com.github.catfriend1.syncthingandroid_1.11.1.0/lib/armeabi/libsyncthingnative.so"
du -hs $file

# syncthing padrao >  pasta install 700 pastas 600 para arquivos
# quando os arquivos são mudados as permissões a data interna do arquivo muda!
# se apagar a pasta index o syncthing vai querer baixar tudo de novooooo
# muda a data precisa upar ou baixar tudo de novo!
# não serve para updates entre as box servidoras prioritarias

Dir=$(dirname $0)
syncthing="$Dir/libsyncthing.so"

export CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
export MacLanReal=`busybox cat /data/macLan.hardware`
export PeerID="CPU=$CpuSerial+MAC=$MacLanReal"


mkdir -p "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.bkp/$PeerID"



if [ ! -e "$syncthing" ] ; then
    echo 'instalando binario'
    cp $file $syncthing
    chmod 755 $syncthing
fi

ConfigPath="$Dir/config"
mkdir -p $ConfigPath
defaultConfig="$ConfigPath/config.xml"

# preciso disto para no primeiro boot gerar a config e alterar o nome do localhost para o androidID
if [ ! -e "$ConfigPath/key.pem" ] ; then
    $syncthing  -generate="$ConfigPath"   
fi

SyncID=`$syncthing -device-id -home=$ConfigPath`
echo $SyncID
# permite acessar brownser
/system/bin/busybox sed -i -e 's/127.0.0.1/0.0.0.0/g' $defaultConfig

# # aplica o android ID para localizar o cliente caso ele modifique arquivos
/system/bin/busybox sed -i -e "s/localhost/$PeerID/g" $defaultConfig


$syncthing -no-browser -no-restart -home=$ConfigPath &

# abaixo é historico
exit

# clear
# echo "Escolha com atenção!"
# echo "upload - ativar upload only para enviar o conteudo para PC, e vps"
# echo ""
# echo "download - Para baixar para a box o .install quer dizer que deu alguma zica"

# read input
# echo ""
# echo ""
# echo "bah vc escolheu > $input"

# if [ "$input" == "upload" ]; then
#     mkdir -p /data/asusbox/.install/.stfolder
#     /system/bin/busybox sed -i -e 's;<folder id="ihdz2-5gkda" label="AsusBox Install" Dir="/data/asusbox/.install" type=".*" rescanIntervalS="3600" fsWatcherEnabled="true" fsWatcherDelayS="10" ignorePerms="false" autoNormalize="true">;<folder id="ihdz2-5gkda" label="AsusBox Install" Dir="/data/asusbox/.install" type="sendonly" rescanIntervalS="3600" fsWatcherEnabled="true" fsWatcherDelayS="10" ignorePerms="false" autoNormalize="true">;g' $defaultConfig
# fi


# if [ "$input" == "download" ]; then
#     # # apaga para forçar no boot o resync # vai baixar tudo de novoooooooooo
#     rm -rf $ConfigPath/index-v0.14.0.db
#     rm -rf $ConfigPath/Sync
#     mkdir -p /data/asusbox/.install/.stfolder
#     /system/bin/busybox sed -i -e 's;<folder id="ihdz2-5gkda" label="AsusBox Install" Dir="/data/asusbox/.install" type=".*" rescanIntervalS="3600" fsWatcherEnabled="true" fsWatcherDelayS="10" ignorePerms="false" autoNormalize="true">;<folder id="ihdz2-5gkda" label="AsusBox Install" Dir="/data/asusbox/.install" type="receiveonly" rescanIntervalS="3600" fsWatcherEnabled="true" fsWatcherDelayS="10" ignorePerms="false" autoNormalize="true">;g' $defaultConfig
# fi






# # gerar config para o sistema introducer não compensa e não funciona direito!
# cat <<EOF > "$ConfigPath/config.xml"
# <configuration version="29">
#     <device id="$SyncID" name="$ID" compression="metadata" introducer="false" skipIntroductionRemovals="false" introducedBy="">
#         <address>dynamic</address>
#         <paused>false</paused>
#         <autoAcceptFolders>false</autoAcceptFolders>
#         <maxSendKbps>0</maxSendKbps>
#         <maxRecvKbps>0</maxRecvKbps>
#         <maxRequestKiB>0</maxRequestKiB>
#     </device>
#     <device id="FW5KI6T-FTX5OWK-XGRDL4A-TWD4UCY-ZKH7LLI-7OXS4UJ-ZF76QHK-TVJLTAZ" name="padaria" compression="metadata" introducer="true" skipIntroductionRemovals="false" introducedBy="">
#         <address>dynamic</address>
#         <paused>false</paused>
#         <autoAcceptFolders>true</autoAcceptFolders>
#         <maxSendKbps>0</maxSendKbps>
#         <maxRecvKbps>0</maxRecvKbps>
#         <maxRequestKiB>0</maxRequestKiB>
#     </device>
#     <gui enabled="true" tls="false" debugging="false">
#         <address>127.0.0.1:8384</address>
#         <apikey>KjapfhKASSx9EDsDcktEe5QnEus5xcRr</apikey>
#         <theme>default</theme>
#     </gui>
#     <ldap></ldap>
#     <options>
#         <listenAddress>default</listenAddress>
#         <globalAnnounceServer>default</globalAnnounceServer>
#         <globalAnnounceEnabled>true</globalAnnounceEnabled>
#         <localAnnounceEnabled>true</localAnnounceEnabled>
#         <localAnnouncePort>21027</localAnnouncePort>
#         <localAnnounceMCAddr>[ff12::8384]:21027</localAnnounceMCAddr>
#         <maxSendKbps>0</maxSendKbps>
#         <maxRecvKbps>0</maxRecvKbps>
#         <reconnectionIntervalS>60</reconnectionIntervalS>
#         <relaysEnabled>true</relaysEnabled>
#         <relayReconnectIntervalM>10</relayReconnectIntervalM>
#         <startBrowser>true</startBrowser>
#         <natEnabled>true</natEnabled>
#         <natLeaseMinutes>60</natLeaseMinutes>
#         <natRenewalMinutes>30</natRenewalMinutes>
#         <natTimeoutSeconds>10</natTimeoutSeconds>
#         <urAccepted>3</urAccepted>
#         <urSeen>3</urSeen>
#         <urUniqueID>RiQdGpfY</urUniqueID>
#         <urURL>https://data.syncthing.net/newdata</urURL>
#         <urPostInsecurely>false</urPostInsecurely>
#         <urInitialDelayS>1800</urInitialDelayS>
#         <restartOnWakeup>true</restartOnWakeup>
#         <autoUpgradeIntervalH>12</autoUpgradeIntervalH>
#         <upgradeToPreReleases>false</upgradeToPreReleases>
#         <keepTemporariesH>24</keepTemporariesH>
#         <cacheIgnoredFiles>false</cacheIgnoredFiles>
#         <progressUpdateIntervalS>5</progressUpdateIntervalS>
#         <limitBandwidthInLan>false</limitBandwidthInLan>
#         <minConfigPathDiskFree unit="%">1</minConfigPathDiskFree>
#         <releasesURL>https://upgrades.syncthing.net/meta.json</releasesURL>
#         <overwriteRemoteDeviceNamesOnConnect>false</overwriteRemoteDeviceNamesOnConnect>
#         <tempIndexMinBlocks>10</tempIndexMinBlocks>
#         <trafficClass>0</trafficClass>
#         <defaultFolderDir>/data/</defaultFolderDir>
#         <setLowPriority>true</setLowPriority>
#         <maxConcurrentScans>0</maxConcurrentScans>
#         <crashReportingURL>https://crash.syncthing.net/newcrash</crashReportingURL>
#         <crashReportingEnabled>true</crashReportingEnabled>
#         <stunKeepaliveStartS>180</stunKeepaliveStartS>
#         <stunKeepaliveMinS>20</stunKeepaliveMinS>
#         <stunServer>default</stunServer>
#         <databaseTuning>auto</databaseTuning>
#     </options>
# </configuration>
# EOF


