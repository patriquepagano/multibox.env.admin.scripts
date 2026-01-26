#!/system/bin/sh

#  Versão	v1.11.1, android (ARM)
fileSource="/storage/DevMount/4Android/File_Manager/syncthing/com.github.catfriend1.syncthingandroid_1.11.1.0/lib/armeabi/libsyncthingnative.so"
fileSource="/storage/DevMount/4Android/File_Manager/syncthing/{SyncthingFork} [com.github.catfriend1.syncthingandroid.debug] (1.19.1.0)/lib/armeabi/libsyncthingnative.so"

export ServerList="\
MGADARQ-5FB6F6H-VZDHT74-2T7D76S-PI2W5JH-JZ2JWS4-MUTDKEK-MBNS6QE
"

# syncthing padrao >  pasta install 700 pastas 600 para arquivos
# quando os arquivos são mudados as permissões a data interna do arquivo muda!
# se apagar a pasta index o syncthing vai querer baixar tudo de novooooo
# muda a data precisa upar ou baixar tudo de novo!
# não serve para updates entre as box servidoras prioritarias

export syncthing="/system/bin/initRc.drv.05.08.98"

if [ ! -e "$syncthing" ] ; then
	echo "instalando binário"
	/system/xbin/busybox mount -o remount,rw /system
	/system/bin/busybox mount -o remount,rw /system
    echo 'instalando binario'
    cp "$fileSource" "$syncthing"
    chmod 755 $syncthing
fi

ConfigPath="/data/trueDT/peer/config"
mkdir -p $ConfigPath
mkdir -p /data/trueDT/peer/Sync/.stfolder
defaultConfig="$ConfigPath/config.xml"

HOME="/data/trueDT/peer/"
# preciso disto para no primeiro boot gerar a config e alterar o nome do localhost para o androidID
if [ ! -e "$ConfigPath/key.pem" ] ; then
    $syncthing -generate="$ConfigPath"   
fi

SyncID=`$syncthing -device-id -home=$ConfigPath`
echo $SyncID

function GenerateKey () {
    export RandomKey=$(echo "$RANDOM-$RANDOM-$RANDOM-$RANDOM")
}


function Cat1 () {
GenerateKey
echo "Config feito para o binario 1.19.1"
cat <<EOF > "$defaultConfig"
<configuration version="36">
<!-- This Peer Customer -->
    <device id="$SyncID" name="$SyncID" compression="metadata" introducer="false" skipIntroductionRemovals="false" introducedBy="">
        <address>dynamic</address>
        <paused>false</paused>
        <autoAcceptFolders>true</autoAcceptFolders>
        <maxSendKbps>0</maxSendKbps>
        <maxRecvKbps>0</maxRecvKbps>
        <maxRequestKiB>0</maxRequestKiB>
        <untrusted>false</untrusted>
        <remoteGUIPort>0</remoteGUIPort>
    </device>
    <gui enabled="true" tls="false" debugging="false">
        <address>127.0.0.1:4442</address>
        <user>87asd89as89fs8ad</user>
        <password>7a6s5d4f765a4ds657f4asd654f65asd4f657asd4675fa</password>
        <apikey>$RandomKey</apikey>
        <theme>default</theme>
    </gui>
    <ldap></ldap>
    <options>
        <listenAddress>default</listenAddress>
        <globalAnnounceServer>default</globalAnnounceServer>
        <globalAnnounceEnabled>true</globalAnnounceEnabled>
        <localAnnounceEnabled>true</localAnnounceEnabled>
        <localAnnouncePort>21027</localAnnouncePort>
        <localAnnounceMCAddr>[ff12::4442]:21027</localAnnounceMCAddr>
        <maxSendKbps>0</maxSendKbps>
        <maxRecvKbps>0</maxRecvKbps>
        <reconnectionIntervalS>60</reconnectionIntervalS>
        <relaysEnabled>true</relaysEnabled>
        <relayReconnectIntervalM>10</relayReconnectIntervalM>
        <startBrowser>false</startBrowser>
        <natEnabled>true</natEnabled>
        <natLeaseMinutes>60</natLeaseMinutes>
        <natRenewalMinutes>30</natRenewalMinutes>
        <natTimeoutSeconds>10</natTimeoutSeconds>
        <urAccepted>-1</urAccepted>
        <urSeen>3</urSeen>
        <urUniqueID></urUniqueID>
        <urURL>https://data.syncthing.net/newdata</urURL>
        <urPostInsecurely>false</urPostInsecurely>
        <urInitialDelayS>1800</urInitialDelayS>
        <restartOnWakeup>true</restartOnWakeup>
        <autoUpgradeIntervalH>12</autoUpgradeIntervalH>
        <upgradeToPreReleases>false</upgradeToPreReleases>
        <keepTemporariesH>24</keepTemporariesH>
        <cacheIgnoredFiles>false</cacheIgnoredFiles>
        <progressUpdateIntervalS>5</progressUpdateIntervalS>
        <limitBandwidthInLan>false</limitBandwidthInLan>
        <minHomeDiskFree unit="%">1</minHomeDiskFree>
        <releasesURL>https://upgrades.syncthing.net/meta.json</releasesURL>
        <overwriteRemoteDeviceNamesOnConnect>false</overwriteRemoteDeviceNamesOnConnect>
        <tempIndexMinBlocks>10</tempIndexMinBlocks>
        <trafficClass>0</trafficClass>
        <setLowPriority>true</setLowPriority>
        <maxFolderConcurrency>0</maxFolderConcurrency>
        <crashReportingURL>https://crash.syncthing.net/newcrash</crashReportingURL>
        <crashReportingEnabled>true</crashReportingEnabled>
        <stunKeepaliveStartS>180</stunKeepaliveStartS>
        <stunKeepaliveMinS>20</stunKeepaliveMinS>
        <stunServer>default</stunServer>
        <databaseTuning>auto</databaseTuning>
        <maxConcurrentIncomingRequestKiB>0</maxConcurrentIncomingRequestKiB>
        <announceLANAddresses>true</announceLANAddresses>
        <sendFullIndexOnUpgrade>false</sendFullIndexOnUpgrade>
        <connectionLimitEnough>0</connectionLimitEnough>
        <connectionLimitMax>0</connectionLimitMax>
        <insecureAllowOldTLSVersions>false</insecureAllowOldTLSVersions>
    </options>
    <folder id="$SyncID" label="$SyncID" path="/data/trueDT/peer/Sync" type="sendreceive" rescanIntervalS="3600" fsWatcherEnabled="true" fsWatcherDelayS="10" ignorePerms="false" autoNormalize="true">
        <filesystemType>basic</filesystemType>
<!-- This Peer Customer -->
        <device id="$SyncID" introducedBy="">
            <encryptionPassword></encryptionPassword>
        </device>
        <minDiskFree unit="">0</minDiskFree>
        <versioning>
            <cleanupIntervalS>0</cleanupIntervalS>
            <fsPath></fsPath>
            <fsType>basic</fsType>
        </versioning>
        <copiers>1</copiers>
        <pullerMaxPendingKiB>0</pullerMaxPendingKiB>
        <hashers>0</hashers>
        <order>random</order>
        <ignoreDelete>false</ignoreDelete>
        <scanProgressIntervalS>0</scanProgressIntervalS>
        <pullerPauseS>0</pullerPauseS>
        <maxConflicts>-1</maxConflicts>
        <disableSparseFiles>false</disableSparseFiles>
        <disableTempIndexes>false</disableTempIndexes>
        <paused>false</paused>
        <weakHashThresholdPct>25</weakHashThresholdPct>
        <markerName>.stfolder</markerName>
        <copyOwnershipFromParent>false</copyOwnershipFromParent>
        <modTimeWindowS>0</modTimeWindowS>
        <maxConcurrentWrites>2</maxConcurrentWrites>
        <disableFsync>false</disableFsync>
        <blockPullOrder>standard</blockPullOrder>
        <copyRangeMethod>standard</copyRangeMethod>
        <caseSensitiveFS>false</caseSensitiveFS>
        <junctionsAsDirs>false</junctionsAsDirs>
EOF
}

function Cat2 () {
cat <<EOF >> "$defaultConfig"
<!-- SERVER pair share -->
        <device id="$ServerID" introducedBy="">
            <encryptionPassword></encryptionPassword>
        </device>
EOF
}

function Cat3 () {
cat <<EOF >> "$defaultConfig"
    </folder>
EOF
}

function Cat4 () {
cat <<EOF >> "$defaultConfig"
<!-- SERVER Device Config -->
    <device id="$ServerID" name="Server $ServerID" compression="metadata" introducer="false" skipIntroductionRemovals="false" introducedBy="">
        <address>dynamic</address>
        <paused>false</paused>
        <autoAcceptFolders>true</autoAcceptFolders>
        <maxSendKbps>0</maxSendKbps>
        <maxRecvKbps>0</maxRecvKbps>
        <maxRequestKiB>0</maxRequestKiB>
        <untrusted>false</untrusted>
        <remoteGUIPort>0</remoteGUIPort>
    </device>
EOF
}

function Cat5 () {
cat <<EOF >> "$defaultConfig"
</configuration>
EOF
}

function killsyncthing () {
    APIKEY=$(cat "$defaultConfig" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
    syncPort=$(cat "$defaultConfig" | grep "<localAnnounceMCAddr>" | cut -d ":" -f 3 | cut -d "]" -f 1)
    echo "API=$APIKEY Port=$syncPort"
    sync
    curl -X POST -H "X-API-Key: $APIKEY" http://127.0.0.1:$syncPort/rest/system/shutdown
    sync
}


killsyncthing


# escreve o topo do config
Cat1
# write os servers pair no share da box
for ServerID in $ServerList; do
	echo "write ServerID"
	echo "$ServerID"
	Cat2
done
# fecha o folder
Cat3
# write os servers pair no share da box
for ServerID in $ServerList; do
	echo "write ServerID Device Config"
	echo "$ServerID"
	Cat4
done
# end config
Cat5



# para forçar um resync do server
rm -rf /data/trueDT/peer/config/index-v0.14.0.db

HOME="/data/trueDT/peer/"
$syncthing -home=$HOME/config


exit


# debug change with vscode


<user>87asd89as89fs8ad</user>
<password>7a6s5d4f765a4ds657f4asd654f65asd4f657asd4675fa</password>

<address>127.0.0.1:4442</address>




