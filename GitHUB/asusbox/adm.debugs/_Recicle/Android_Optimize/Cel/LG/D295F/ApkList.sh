com.android.bluetooth=LGBluetooth4.apk
com.android.certinstaller=CertInstaller.apk
com.android.chrome=ChromeWithBrowser.apk
com.android.documentsui=DocumentsUI.apk
com.android.htmlviewer=HTMLViewer.apk
com.android.keychain=KeyChain.apk
com.android.packageinstaller=PackageInstaller.apk
com.android.pacprocessor=PacProcessor.apk
com.android.providers.partnerbookmarks=LGPartnerBookmarksProvider.apk
com.android.providers.telephony=LGTelephonyProvider.apk
com.android.providers.userdictionary=UserDictionaryProvider.apk
com.android.stk=Stk.apk
com.lge.android.atservice=LGATCMDService.apk

com.lge.defaultaccount=LGDefaultAccount.apk
com.lge.divx.permission=LGDivXDRM.apk
com.lge.drmservice=DrmService.apk
com.lge.eltest=ELTTest.apk
com.lge.eula=UnifiedEULA.apk
com.lge.eulaprovider=LicenseProvider.apk
com.lge.gnss.airtest=GnssAirTest.apk
com.lge.gnsspostest=GnssPosTest.apk
com.lge.gnsstest=GnssTest.apk
com.lge.hiddenmenu=HiddenMenu.apk
com.lge.hiddenpersomenu=HiddenSIMUnlockMenu.apk
com.lge.ime.theme.black=LGEIME_THEME_BLACK3.apk
com.lge.ime=LGEIME.apk
com.lge.kpt.adaptxt.alladdons=LG_LITE_ADDONS_SINGLE_APK_bin.apk
com.lge.launcher2.theme.optimus=LGHome_Theme_Optimus.apk
com.lge.lgdmsclient=LGDMSClient.apk
com.lge.lgdmsgcm=LGDMSGCM.apk
com.lge.lgdrm.permission=LGDrm.apk
com.lge.lgfota.permission=LGFOTA.apk
com.lge.lockscreensettings=LGLockScreenSettings.apk
com.lge.pcsyncui=LGPCSuiteUI.apk
com.lge.permission=PermissionToAccessLgeApi.apk
com.lge.settings.easy=LGEasySettings.apk
com.lge.shutdownmonitor=com.lge.shutdownmonitor.apk
com.lge.systemservice=LGSystemServer.apk
com.lge.systemui.theme.black=SystemUI_Theme_Black.apk
com.lge.systemui.theme.blackgradation=SystemUI_Theme_Black_Gradation.apk
com.lge.systemui.theme.white=SystemUI_Theme_White.apk
com.lge.systemui.theme.whitegradation=SystemUI_Theme_White_Gradation.apk
com.lge.touchcontrol=LGTouchControlAreas.apk
com.qualcomm.atfwd=atfwd.apk
com.qualcomm.location=com.qualcomm.location.apk
com.qualcomm.qcrilmsgtunnel=qcrilmsgtunnel.apk
com.qualcomm.timeservice=TimeService.apk
com.rsupport.rsperm=rspermlge.apk
kingoroot.supersu=KingoUser.apk






# vars. system safe
appRemove="
com.android.facelock=FaceLock.apk
com.lge.appwidget.lgsearch=LGSearchWidgetProvider.apk

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
com.android.printspooler=PrintSpooler.apk
com.google.android.apps.books=Books.apk
com.google.android.apps.docs=GoogleDrive.apk
com.google.android.apps.magazines=Magazines.apk
com.google.android.apps.maps=GMS_Maps.apk
com.google.android.apps.plus=PlusOne.apk
com.google.android.gm=Gmail2.apk
com.google.android.marvin.talkback=talkback.apk
com.google.android.music=Music2.apk
com.google.android.play.games=PlayGames.apk
com.google.android.street=Street.apk
com.google.android.syncadapters.calendar=GoogleCalendarSyncAdapter.apk
com.google.android.syncadapters.contacts=GoogleContactsSyncAdapter.apk
com.google.android.talk=Hangouts.apk
com.google.android.tts=GoogleTTS.apk
com.google.android.videos=Videos.apk
com.google.android.youtube=YouTube.apk
com.lge.sizechangable.weather.platform=LGWeatherService.apk
com.lge.sizechangable.weather.theme.optimus=LGWeatherTheme.apk
com.lge.sizechangable.weather=LGWeather.apk
com.lge.springcleaning=LGSpringCleaning.apk
"
clear
for i in $appRemove; do
mount -o remount,rw /system
	app=`echo $i | cut -d "=" -f 2 | sed -e 's/.apk//g'`
	data=`echo $i | cut -d "=" -f 1`
	echo $app
	#echo $data
	if [ -e /system/app/$app.apk ] ; then
		echo 'Removendo ' $app
		pm disable $data
		pm clear $data
		rm -rf /system/app/$app.apk
		rm -rf /system/app/$app.odex
		echo 'Removendo ' $data
		rm -rf /data/data/$data
		rm -rf /data/app-lib/$data
		sleep 2
	fi
done



