com.android.LGSetupWizard=LGStartupwizard.apk
com.android.backupconfirm=BackupRestoreConfirmation.apk
com.android.browser=LGBrowser.apk
com.android.calendar=LGCalendar.apk
com.android.cellbroadcastreceiver=LGCb.apk
com.android.contacts=LGContacts.apk
com.android.defcontainer=DefaultContainerService.apk
com.android.externalstorage=ExternalStorageProvider.apk
com.android.gallery3d=LGGallery.apk
com.android.incallui=LGInCallUI.apk
com.android.inputdevices=InputDevices.apk
com.android.keyguard=LGKeyguard.apk
com.android.location.fused=FusedLocation.apk
com.android.mms=LGMessage.apk
com.android.phone=LGTeleService.apk
com.android.providers.calendar=LGCalendarProvider.apk
com.android.providers.contacts=LGContactsProvider.apk
com.android.providers.downloads=LGDownloadProvider.apk
com.android.providers.media=LGMediaProvider.apk
com.android.providers.settings=LGSettingsProvider.apk
com.android.proxyhandler=ProxyHandler.apk
com.android.settings=LGSettings.apk
com.android.settingsaccessibility=LGSettingsAccessibility.apk
com.android.sharedstoragebackup=SharedStorageBackup.apk
com.android.shell=Shell.apk
com.android.systemui=LGSystemUI.apk
com.android.vpndialogs=VpnDialogs.apk
com.android.wallpaper.livepicker=LGLiveWallpapersPicker.apk
com.android.wallpapercropper=WallpaperCropper.apk
com.google.android.backuptransport=GoogleBackupTransport.apk
com.google.android.configupdater=ConfigUpdater.apk
com.google.android.feedback=GoogleFeedback.apk
com.google.android.googlequicksearchbox=Velvet.apk
com.google.android.gsf.login=GoogleLoginService.apk
com.google.android.gsf=GoogleServicesFramework.apk
com.google.android.onetimeinitializer=GoogleOneTimeInitializer.apk
com.google.android.partnersetup=GooglePartnerSetup.apk
com.google.android.setupwizard=SetupWizard.apk
com.hy.system.fontserver=FontServer.apk
com.lge.appbox.client=LGApplicationManager.apk
com.lge.appwidget.dualsimstatus=DualSimStatus.apk
com.lge.bnr=LGBackup.apk
com.lge.camera=LGCameraApp.apk
com.lge.clock=LGAlarmClock.apk
com.lge.easyhome=LGEasyHome.apk

com.lge.filemanager=LGFileManager.apk
com.lge.homeselector=HomeSelector.apk
com.lge.launcher2=LGHome.apk
com.lge.lginstallservies=LGInstallService.apk
com.lge.mlt=MLT.apk
com.lge.music=LGMusic.apk
com.lge.provider.systemui=LGSystemUI_Provider.apk
com.lge.sizechangable.musicwidget.widget=LGMusicWidget.apk
com.lge.sync=LGPCSuite.apk


com.lge.wapservice=WapService.apk










# vars. system safe
appRemove="

"
clear

# desativando
for i in $appRemove; do
app=`echo $i | cut -d "=" -f 1`
echo 'desativando ' $app
pm disable $app
pm clear $app
pm uninstall $app
done



# remove do filesystem
appRemove="
com.lge.email=LGEmail.apk
com.lge.updatecenter=LGUpdateCenter.apk
com.lge.videoplayer=LGVideo.apk
com.lge.voicerecorder=LGVoiceRecorder.apk
"
clear
for i in $appRemove; do
mount -o remount,rw /system
	app=`echo $i | cut -d "=" -f 2 | sed -e 's/.apk//g'`
	data=`echo $i | cut -d "=" -f 1`
	echo $app
	#echo $data
	if [ -e /system/priv-app/$app.apk ] ; then
		echo 'Removendo ' $app
		pm disable $data
		pm clear $data
		rm -rf /system/priv-app/$app.apk
		rm -rf /system/priv-app/$app.odex
		echo 'Removendo ' $data
		rm -rf /data/data/$data
		rm -rf /data/app-lib/$data
		sleep 2
	fi
done













