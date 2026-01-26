#!/system/bin/sh

LDFIX=`echo "$LD_LIBRARY_PATH" | cut -c1-1`
if [ "$LDFIX" == ":" ] ; then
	export LD_LIBRARY_PATH=`echo "$LD_LIBRARY_PATH" | cut -c 2-`
fi

if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
		export TheAPP=os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
		export TheAPP=os.tools.scriptmanager
fi
export TMPDIR="$APPFolder"
export PATH=$APPFolder/bin/applets:$PATH
export busybox="$APPFolder/bin/busybox"
export aria2c="$APPFolder/bin/aria2c"
export Szip="$APPFolder/bin/7z"
# path removivel
$APPFolder/sc/0_support/Wpath.sh
export Wpath=`cat "$APPFolder/Wpath.TXT"`
export logao="$Wpath/debug.log"
# webserver
export IPSERVER="1.0.0.2"
export baseapps="$Wpath/.0/1_base_system"
export CPU=`getprop ro.product.cpu.abi`

echo "Instalando MiXplorer favor aguardar..."
pm install -r $baseapps/apk/MiXplorer.apk

# MiXplorer_6 permission
TheFolder="/data/data/com.mixplorer"
mkdir -p $TheFolder/shared_prefs
# config
file="$TheFolder/shared_prefs/com.mixplorer_preferences.xml"
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name="custom_key_CHROMA">xxxxx</string>
    <string name="settings_langs">pt-rBR</string>
</map>
EOF
perms=`stat -c "%u" "$TheFolder"`
chown -R $perms:$perms $TheFolder/shared_prefs
chmod 660 $TheFolder/shared_prefs/*.xml
restorecon -FR $TheFolder/shared_prefs >> $logao 2>&1

pm grant com.mixplorer android.permission.READ_EXTERNAL_STORAGE > /dev/null 2>&1
pm grant com.mixplorer android.permission.WRITE_EXTERNAL_STORAGE > /dev/null 2>&1
#------------------------------------------------------------------------------------------------------------
echo "Navegador tela cheia favor aguardar..."
pm install -r $baseapps/apk/de.ozerov.fully.apk
TheFolder="/data/data/de.ozerov.fully"
if [ -e "$TheFolder" ] ; then
mkdir -p $TheFolder/shared_prefs
# config
file="$TheFolder/shared_prefs/_has_set_default_values.xml"
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="_has_set_default_values" value="true" />
</map>
EOF

file="$TheFolder/shared_prefs/de.ozerov.fully_preferences.xml"
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="setRemoveSystemUI" value="false" />
    <string name="wifiKey"></string>
    <boolean name="showMenuHint" value="true" />
    <string name="movementBeaconList"></string>
    <boolean name="screenOffInDarkness" value="false" />
    <string name="authUsername"></string>
    <boolean name="useWideViewport" value="true" />
    <boolean name="geoLocationAccess" value="false" />
    <string name="motionSensitivity">90</string>
    <string name="remoteAdminPassword"></string>
    <boolean name="launchOnBoot" value="false" />
    <string name="graphicsAccelerationMode">2</string>
    <boolean name="showBackButton" value="true" />
    <string name="authPassword"></string>
    <int name="addressBarBgColor" value="-4473925" />
    <boolean name="enablePullToRefresh" value="true" />
    <string name="motionSensitivityAcoustic">90</string>
    <boolean name="ignoreMotionWhenMoving" value="false" />
    <boolean name="kioskHomeStartURL" value="false" />
    <string name="kioskWifiPin"></string>
    <boolean name="disableCamera" value="false" />
    <string name="wifiSSID"></string>
    <int name="hourCounter" value="-144" />
    <boolean name="keepSleepingIfUnplugged" value="false" />
    <string name="darknessLevel">10</string>
    <boolean name="actionBarInSettings" value="false" />
    <boolean name="microphoneAccess" value="false" />
    <boolean name="remoteAdminLan" value="true" />
    <string name="cacheMode">-1</string>
    <string name="movementBeaconDistance">5</string>
    <string name="screensaverBrightness"></string>
    <boolean name="thirdPartyCookies" value="true" />
    <boolean name="desktopMode" value="false" />
    <string name="alarmSoundFileUrl"></string>
    <boolean name="knoxDisableStatusBar" value="false" />
    <boolean name="reloadOnInternet" value="false" />
    <boolean name="disablePowerButton" value="true" />
    <boolean name="screensaverFullscreen" value="false" />
    <string name="actionBarTitle">Fully Kiosk Browser</string>
    <string name="urlBlacklist"></string>
    <boolean name="pageTransitions" value="false" />
    <boolean name="playAlarmSoundUntilPin" value="false" />
    <string name="appLauncherScaling">100</string>
    <boolean name="showAppLauncherOnStart" value="false" />
    <string name="timeToScreensaverV2">0</string>
    <boolean name="usageStatistics" value="false" />
    <boolean name="movementDetection" value="false" />
    <boolean name="restartOnCrash" value="false" />
    <boolean name="sleepOnPowerConnect" value="false" />
    <boolean name="readNfcTag" value="false" />
    <boolean name="swipeNavigation" value="false" />
    <boolean name="screenOnOnMovement" value="true" />
    <boolean name="acra.legacyAlreadyConvertedToJson" value="true" />
    <boolean name="sleepOnPowerDisconnect" value="false" />
    <string name="remotePdfFileMode">0</string>
    <boolean name="deleteHistoryOnReload" value="false" />
    <boolean name="autoplayVideos" value="true" />
    <string name="mdmApkToInstall"></string>
    <int name="actionBarBgColor" value="-15906911" />
    <string name="startURL">http://localhost:8080</string>
    <boolean name="loadOverview" value="false" />
    <boolean name="enableZoom" value="true" />
    <boolean name="reloadOnWifiOn" value="false" />
    <boolean name="advancedKioskProtection" value="false" />
    <string name="compassSensitivity">50</string>
    <string name="searchProviderUrl">https://www.google.com/search?q=</string>
    <int name="defaultWebviewBackgroundColor" value="-1" />
    <boolean name="motionDetectionAcoustic" value="false" />
    <boolean name="reloadOnScreenOn" value="false" />
    <string name="reloadPageFailure">0</string>
    <string name="actionBarIconUrl"></string>
    <string name="initialScale">0</string>
    <boolean name="enableBackButton" value="true" />
    <boolean name="mdmDisableUsbStorage" value="false" />
    <string name="actionBarBgUrl"></string>
    <boolean name="setWifiWakelock" value="false" />
    <boolean name="lockSafeMode" value="false" />
    <int name="acra.lastVersionNr" value="310" />
    <boolean name="deleteWebstorageOnReload" value="false" />
    <int name="actionBarFgColor" value="-1" />
    <string name="fadeInOutDuration">200</string>
    <boolean name="showHomeButton" value="true" />
    <boolean name="audioRecordUploads" value="false" />
    <boolean name="autoplayAudio" value="false" />
    <string name="reloadEachSeconds">0</string>
    <string name="accelerometerSensitivity">80</string>
    <boolean name="showPrintButton" value="false" />
    <boolean name="knoxDisableScreenCapture" value="false" />
    <string name="kioskExitGesture">0</string>
    <string name="kioskAppWhitelist"></string>
    <boolean name="enableVersionInfo" value="true" />
    <string name="screensaverWallpaperURL">fully://color#000000</string>
    <boolean name="forceScreenUnlock" value="true" />
    <boolean name="waitInternetOnReload" value="false" />
    <boolean name="disableVolumeButtons" value="true" />
    <string name="forceScreenOrientation">0</string>
    <boolean name="showStatusBar" value="false" />
    <boolean name="disableStatusBar" value="true" />
    <boolean name="screensaverDaydream" value="false" />
    <boolean name="detectIBeacons" value="false" />
    <string name="kioskPin">1234</string>
    <int name="appLauncherBackgroundColor" value="-1" />
    <boolean name="videoCaptureUploads" value="false" />
    <boolean name="stopScreensaverOnMovement" value="true" />
    <boolean name="webcamAccess" value="false" />
    <string name="motionCameraId"></string>
    <boolean name="knoxDisableSafeMode" value="false" />
    <string name="urlWhitelist"></string>
    <boolean name="disableOtherApps" value="true" />
    <boolean name="playAlarmSoundOnMovement" value="false" />
    <boolean name="enableTapSound" value="false" />
    <boolean name="forceImmersive" value="false" />
    <boolean name="showActionBar" value="false" />
    <string name="volumeLicenseKey"></string>
    <long name="foregroundMillis" value="741655" />
    <boolean name="remoteAdmin" value="false" />
    <boolean name="keepScreenOn" value="true" />
    <string name="launcherInjectCode"></string>
    <boolean name="cameraCaptureUploads" value="false" />
    <boolean name="showCamPreview" value="false" />
    <boolean name="pauseMotionInBackground" value="false" />
    <string name="timeToScreenOffV2">0</string>
    <string name="sleepSchedule"></string>
    <boolean name="setCpuWakelock" value="false" />
    <boolean name="softKeyboard" value="true" />
    <boolean name="enablePopups" value="false" />
    <int name="statusBarColor" value="0" />
    <boolean name="mdmDisableStatusBar" value="false" />
    <string name="canonicalDeviceId">964682c8-63e48363</string>
    <string name="lastVersionInfo">1.24</string>
    <boolean name="textSelection" value="true" />
    <boolean name="fileUploads" value="false" />
    <boolean name="jsAlerts" value="true" />
    <string name="screensaverPlaylist"></string>
    <boolean name="webviewDebugging" value="false" />
    <boolean name="disableHomeButton" value="true" />
    <boolean name="showNavigationBar" value="false" />
    <string name="launcherApps"></string>
    <boolean name="showAddressBar" value="false" />
    <string name="localPdfFileMode">0</string>
    <string name="batteryWarning">0</string>
    <boolean name="kioskMode" value="false" />
    <boolean name="motionDetection" value="false" />
    <boolean name="mdmDisableScreenCapture" value="false" />
    <boolean name="autoImportSettings" value="true" />
    <boolean name="singleAppMode" value="false" />
    <boolean name="enableUrlOtherApps" value="false" />
    <boolean name="cloudService" value="false" />
    <int name="navigationBarColor" value="0" />
    <boolean name="isRunning" value="false" />
    <string name="motionFps">5</string>
    <boolean name="websiteIntegration" value="false" />
    <boolean name="reloadOnScreensaverStop" value="false" />
    <boolean name="deleteCookiesOnReload" value="false" />
    <string name="errorURL"></string>
    <string name="screenBrightness"></string>
    <boolean name="formAutoComplete" value="true" />
    <boolean name="showProgressBar" value="true" />
    <boolean name="knoxEnabled" value="false" />
    <boolean name="knoxDisableCamera" value="false" />
    <boolean name="playMedia" value="false" />
    <boolean name="showRefreshButton" value="false" />
    <boolean name="showForwardButton" value="true" />
    <boolean name="redirectBlocked" value="false" />
    <boolean name="stopScreensaverOnMotion" value="true" />
    <boolean name="mdmDisableADB" value="false" />
    <boolean name="restartAfterUpdate" value="false" />
    <boolean name="enableFullscreenVideos" value="true" />
    <boolean name="acra.legacyAlreadyConvertedTo4.8.0" value="true" />
    <string name="remoteFileMode">0</string>
    <string name="fontSize">100</string>
    <boolean name="clearCacheEach" value="false" />
    <boolean name="confirmExit" value="false" />
    <boolean name="ignoreSSLerrors" value="false" />
    <string name="userAgent">0</string>
    <string name="singleAppIntent"></string>
    <boolean name="deleteCacheOnReload" value="false" />
    <boolean name="runInForeground" value="false" />
    <boolean name="screenOnOnMotion" value="true" />
</map>
EOF
# perm 600 puxar a permissao do user da pasta
perms=`stat -c "%u" $TheFolder`
chown -R $perms:$perms $TheFolder/shared_prefs
chmod 660 $TheFolder/shared_prefs/*.xml
restorecon -FR $TheFolder/shared_prefs >> $logao 2>&1
fi
#------------------------------------------------------------------------------------------------------------
echo "Navegador tela cheia favor aguardar..."
pm install -r $baseapps/apk/Lightning.apk
TheFolder="/data/data/acr.browser.barebones"
if [ -e "$TheFolder" ] ; then
mkdir -p $TheFolder/shared_prefs
# config
file="$TheFolder/shared_prefs/settings.xml"
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name="saveUrl">http://localhost:8080/</string>
    <boolean name="fullscreen" value="true" />
    <boolean name="hidestatus" value="true" />
    <int name="enableflash" value="0" />
    <string name="home">http://localhost:8080</string>
</map>
EOF

file="$TheFolder/shared_prefs/acr.browser.barebones_preferences.xml"
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="cb_images" value="false" />
    <boolean name="cb_javascript" value="true" />
    <boolean name="clear_webstorage_exit" value="false" />
    <boolean name="remove_identifying_headers" value="false" />
    <boolean name="cb_drawertabs" value="true" />
    <boolean name="clear_cookies_exit" value="false" />
    <boolean name="allow_cookies" value="true" />
    <boolean name="allow_new_window" value="true" />
    <boolean name="cb_swapdrawers" value="false" />
    <boolean name="incognito_cookies" value="false" />
    <boolean name="fullscreen" value="true" />
    <boolean name="clear_cache_exit" value="false" />
    <boolean name="wideViewPort" value="true" />
    <boolean name="overViewMode" value="true" />
    <boolean name="cb_colormode" value="true" />
    <boolean name="fullScreenOption" value="true" />
    <boolean name="password" value="true" />
    <boolean name="cb_ads" value="false" />
    <boolean name="third_party" value="false" />
    <boolean name="clear_history_exit" value="false" />
    <boolean name="restore_tabs" value="true" />
    <boolean name="do_not_track" value="false" />
    <boolean name="location" value="false" />
    <boolean name="cb_flash" value="false" />
    <boolean name="text_reflow" value="false" />
</map>
EOF
# perm 600 puxar a permissao do user da pasta
perms=`stat -c "%u" "$TheFolder"`
chown -R $perms:$perms $TheFolder/shared_prefs
chmod 660 $TheFolder/shared_prefs/*.xml
restorecon -FR $TheFolder/shared_prefs >> $logao 2>&1
fi
#------------------------------------------------------------------------------------------------------------
if [ ! -e /sys/class/display ]; then # instala apenas em devices com touchscreen
echo "Navegador tela cheia favor aguardar..."
pm install -r $baseapps/apk/com.xyz.fullscreenbrowser.apk
TheFolder="/data/data/com.xyz.fullscreenbrowser"
if [ -e "$TheFolder" ] ; then
mkdir -p $TheFolder/shared_prefs
# config
file="$TheFolder/shared_prefs/browser.xml"
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name="homepage">http://localhost:8080</string>
    <boolean name="introdone" value="false" />
    <boolean name="bottomtabs" value="false" />
    <boolean name="desktopversion" value="false" />
    <boolean name="nonetwork" value="false" />
    <boolean name="noimages" value="false" />
    <boolean name="nojavascript" value="false" />
</map>
EOF
# perm 600 puxar a permissao do user da pasta
perms=`stat -c "%u" "$TheFolder"`
chown -R $perms:$perms $TheFolder/shared_prefs
chmod 660 $TheFolder/shared_prefs/*.xml
restorecon -FR $TheFolder/shared_prefs >> $logao 2>&1
fi
fi
#------------------------------------------------------------------------------------------------------------

# echo "Instalando Xperia_Home_7.0.A.0.14 favor aguardar..."
# pm install -r $baseapps/apk/Xperia_Home_7.0.A.0.14.apk

# echo "Instalando Xperia_Home_7.0.A.1.12_Android_4.4_API.19 favor aguardar..."
# pm install -r $baseapps/apk/Xperia_Home_7.0.A.1.12_Android_4.4_API.19.apk

# echo "Instalando Xperia_Home_10.0.A.0.8 favor aguardar..."
# pm install -r $baseapps/apk/Xperia_Home_10.0.A.0.8.apk


echo "Instalando TVLauncher_3.1.0.apk favor aguardar..."
pm install -r $baseapps/apk/TVLauncher.apk

# homeLauncher config
if ping -c 1 $IPSERVER &> /dev/null
	then
		link="http://$IPSERVER/.0/1_base_system/.root/homeLauncher.tar.gz"
	else
		link="https://www.dropbox.co"
fi
$aria2c -x 10 --check-certificate=false --allow-overwrite=true --file-allocation=none $link --dir=$EXTERNAL_STORAGE -o tmp.tar.gz > /dev/null 2>&1

# home Launcher oficial
am force-stop com.awe.dev.pro.tv
pm disable com.awe.dev.pro.tv
pm clear com.awe.dev.pro.tv
pm grant com.awe.dev.pro.tv android.permission.WRITE_EXTERNAL_STORAGE
pm grant com.awe.dev.pro.tv android.permission.GET_ACCOUNTS

echo "Extraindo arquivos favor aguardar"
TheFolder="/data/data/com.awe.dev.pro.tv"
cd $TheFolder
tar -mzxvf $EXTERNAL_STORAGE/tmp.tar.gz > /dev/null 2>&1
rm $EXTERNAL_STORAGE/tmp.tar.gz > /dev/null 2>&1
DUser=`stat -c "%u" "$TheFolder"`
chown -R $DUser:$DUser $TheFolder >> $logao 2>&1
restorecon -FR $TheFolder >> $logao 2>&1
#ls -ld /data/data/com.awe.dev.pro.tv/*
#echo $DUser
pm enable com.awe.dev.pro.tv
# sleep 2
# am start --user 0 -a android.intent.action.MAIN com.awe.dev.pro.tv/.Launcher



echo "atualizado, pode fechar esta tela."

