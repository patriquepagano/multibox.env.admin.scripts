
# binário estraido da instalação do apk vindo da google store


mkdir -p /data/asusbox/sync
HOME=/data/asusbox/sync # precisa setar uma variavel home







# Syncthing

# -- NÃO SERVE COMO UM SISTEMA DE TORRENT!
# -- para compartilhar com clientes precisa saber o SyncID deles..
# -- peso na cpu
# -- se user descobrir a receita pode adicionar pessoas a lista updates
# -- como adicionar e lidar com 2000 mil nodes users ?
# -- binário é GIGANTE
# -- caso o user modificar sua pasta somente leitura, precisa clicar na interface web revert changes (oq seria impossível)

# ++ facilidade em criar arquivos basta jogar no syncthing master e todos receberão

# https://forum.syncthing.net/t/share-a-folder-for-thousands-of-users/11836/7

# Please do not cause confusion. Receive only is a local attribute, you can uncheck that locally at any time and start 
# pushing changes to others. As the user explain, this is not the model he is looking for.


/data/asusbox/libsyncthing.so -no-browser -no-restart -home=/data/asusbox/sync &

# script continua perfeito
mkdir -p /data/asusbox/syncAAAAAAAAAAAABBBBBBccc

# path original do arquivo
/data/app/com.nutomic.syncthingandroid-1/lib/arm/libsyncthing.so




<configuration version="29">
    <folder id="xdnvv-cpbdi" label="ASUSBOX" path="/data/asusbox/sync/ASUSBOX" type="receiveonly" rescanIntervalS="3600" fsWatcherEnabled="true" fsWatcherDelayS="10" ignorePerms="true" autoNormalize="true">
        <filesystemType>basic</filesystemType>
        <device id="4H4ADKC-FLAQBZB-2RQE3BO-NOBHJ5A-RN2AXTF-6WVBX6M-OTVIWIB-AU63QQC" introducedBy=""></device>
        <device id="43SY7PB-JX7OOTH-WT2FH76-LN25YRE-BP3G5WM-HFI4ZOE-7IUC6ZG-ZE65YQQ" introducedBy=""></device>
        <minDiskFree unit="%">1</minDiskFree>
        <versioning></versioning>
        <copiers>0</copiers>
        <pullerMaxPendingKiB>0</pullerMaxPendingKiB>
        <hashers>0</hashers>
        <order>smallestFirst</order>
        <ignoreDelete>false</ignoreDelete>
        <scanProgressIntervalS>0</scanProgressIntervalS>
        <pullerPauseS>0</pullerPauseS>
        <maxConflicts>10</maxConflicts>
        <disableSparseFiles>false</disableSparseFiles>
        <disableTempIndexes>false</disableTempIndexes>
        <paused>false</paused>
        <weakHashThresholdPct>25</weakHashThresholdPct>
        <markerName>.stfolder</markerName>
        <copyOwnershipFromParent>false</copyOwnershipFromParent>
        <modTimeWindowS>0</modTimeWindowS>
    </folder>
    <device id="4H4ADKC-FLAQBZB-2RQE3BO-NOBHJ5A-RN2AXTF-6WVBX6M-OTVIWIB-AU63QQC" name="serverSync" compression="metadata" introducer="false" skipIntroductionRemovals="false" introducedBy="">
        <address>dynamic</address>
        <paused>false</paused>
        <autoAcceptFolders>false</autoAcceptFolders>
        <maxSendKbps>0</maxSendKbps>
        <maxRecvKbps>0</maxRecvKbps>
        <maxRequestKiB>0</maxRequestKiB>
    </device>
    <device id="43SY7PB-JX7OOTH-WT2FH76-LN25YRE-BP3G5WM-HFI4ZOE-7IUC6ZG-ZE65YQQ" name="localhost" compression="metadata" introducer="false" skipIntroductionRemovals="false" introducedBy="">
        <address>dynamic</address>
        <paused>false</paused>
        <autoAcceptFolders>false</autoAcceptFolders>
        <maxSendKbps>0</maxSendKbps>
        <maxRecvKbps>0</maxRecvKbps>
        <maxRequestKiB>0</maxRequestKiB>
    </device>
    <gui enabled="true" tls="false" debugging="false">
        <address>0.0.0.0:8384</address>
        <apikey>nLyjpsoMEREnAUAMHWUb5rPtP3jrv2sW</apikey>
        <theme>default</theme>
    </gui>
    <ldap></ldap>
    <options>
        <listenAddress>default</listenAddress>
        <globalAnnounceServer>default</globalAnnounceServer>
        <globalAnnounceEnabled>true</globalAnnounceEnabled>
        <localAnnounceEnabled>true</localAnnounceEnabled>
        <localAnnouncePort>21027</localAnnouncePort>
        <localAnnounceMCAddr>[ff12::8384]:21027</localAnnounceMCAddr>
        <maxSendKbps>0</maxSendKbps>
        <maxRecvKbps>0</maxRecvKbps>
        <reconnectionIntervalS>60</reconnectionIntervalS>
        <relaysEnabled>true</relaysEnabled>
        <relayReconnectIntervalM>10</relayReconnectIntervalM>
        <startBrowser>true</startBrowser>
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
        <defaultFolderPath>~</defaultFolderPath>
        <setLowPriority>true</setLowPriority>
        <maxConcurrentScans>0</maxConcurrentScans>
        <crashReportingURL>https://crash.syncthing.net/newcrash</crashReportingURL>
        <crashReportingEnabled>true</crashReportingEnabled>
        <stunKeepaliveStartS>180</stunKeepaliveStartS>
        <stunKeepaliveMinS>20</stunKeepaliveMinS>
        <stunServer>default</stunServer>
        <databaseTuning>auto</databaseTuning>
    </options>
</configuration>
