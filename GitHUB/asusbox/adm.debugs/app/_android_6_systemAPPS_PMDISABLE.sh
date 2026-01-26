#!/system/bin/sh

Gerar a lista para criar os apps a serem removidos



# system app list (pm hide)
clear
apps=`pm list packages -f | grep -e '/system/app/' | sed -e 's,package:/system/app/,,g' | cut -d "=" -f 2 | sort`
echo "$apps"





# /system/app/
tmpFile="/sdcard/tmplist"
ApkList="/sdcard/ApkList.sh"
clear | rm $tmpFile
appList=`pm list packages -f | grep -e '/system/app' | sed -e 's,package:/system/app,,g'` 
for i in $appList; do
apk=`echo $i | cut -d "=" -f 1`
name=`echo $i | cut -d "=" -f 2`
echo $name=$apk >> $tmpFile
done
cat $tmpFile | sed -e 's,=/,=,g' | sort > $ApkList 
cat $ApkList
rm $tmpFile


=Camera2.apk

android.rk.RockVideoPlayer=RkVideoPlayer.apk
android.rockchip.update.service=RKUpdateService.apk
com.android.apkinstaller=RkApkinstaller.apk
com.android.bluetooth=Bluetooth.apk
com.android.browser=Browser.apk
com.android.calculator2=Calculator.apk
=Calendar.apk

com.android.certinstaller=CertInstaller.apk
com.android.deskclock=DeskClock.apk
=Development.apk
com.android.documentsui=DocumentsUI.apk
com.android.dreams.basic=BasicDreams.apk
com.android.dreams.phototable=PhotoTable.apk
com.android.email=Email.apk
com.android.exchange=Exchange2.apk
com.android.galaxy4=Galaxy4.apk
com.android.gallery3d=Gallery2.apk
com.android.htmlviewer=HTMLViewer.apk
com.android.inputmethod.latin=LatinIME.apk
com.android.inputmethod.pinyin=PinyinIME.apk
com.android.keychain=KeyChain.apk
com.android.launcher3=Launcher3.apk
com.android.magicsmoke=MagicSmokeWallpapers.apk
com.android.music=RkMusic.apk
com.android.musicvis=VisualizationWallpapers.apk
com.android.noisefield=NoiseField.apk
com.android.packageinstaller=PackageInstaller.apk
com.android.pacprocessor=PacProcessor.apk
com.android.phasebeam=PhaseBeam.apk
com.android.printspooler=PrintSpooler.apk
com.android.providers.downloads.ui=DownloadProviderUi.apk
com.android.providers.userdictionary=UserDictionaryProvider.apk
com.android.provision=Provision.apk
com.android.rk.mediafloat=MediaFloat.apk
com.android.rockchip=RkExplorer.apk
com.android.smspush=WAPPushManager.apk
=SoundRecorder.apk

com.android.stk=Stk.apk
com.android.wallpaper.holospiral=HoloSpiralWallpaper.apk
com.android.wallpaper.livepicker=LiveWallpapersPicker.apk
com.android.wallpaper=LiveWallpapers.apk
com.example.staticistall2=SkyReinstall.apk
com.francis.wifitest=SkyKirinTest.apk

com.google.android.gm=Gmail2.apk
com.google.android.syncadapters.calendar=GoogleCalendarSyncAdapter.apk
com.google.android.syncadapters.contacts=GoogleContactsSyncAdapter.apk
=RKGameControlSettingV1.0.1.apk
com.rockchip.mediacenter=eHomeMediaCenter_box.apk
com.rockchip.wfd=WifiDisplay.apk
com.svox.pico=PicoTts.apk
jp.co.omronsoft.openwnn=OpenWnn.apk





