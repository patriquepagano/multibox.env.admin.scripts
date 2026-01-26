Gerar a lista para criar os apps a serem removidos



# system app list (pm hide)
clear
apps=`pm list packages -f | grep -e '/system/priv-app/' | sed -e 's,package:/system/priv-app/,,g' | cut -d "=" -f 2 | sort`
echo "$apps"





# /system/app/
tmpFile="/sdcard/tmplist"
ApkList="/sdcard/priv-app.sh"
clear | rm $tmpFile
appList=`pm list packages -f | grep -e '/system/priv-app' | sed -e 's,package:/system/priv-app,,g'` 
for i in $appList; do
apk=`echo $i | cut -d "=" -f 1`
name=`echo $i | cut -d "=" -f 2`
echo $name=$apk >> $tmpFile
done
cat $tmpFile | sed -e 's,=/,=,g' | sort > $ApkList 
cat $ApkList
rm $tmpFile




com.amlogic.mediacenter=DLNA.apk
com.android.backupconfirm=BackupRestoreConfirmation.apk
com.android.defcontainer=DefaultContainerService.apk
com.android.externalstorage=ExternalStorageProvider.apk
com.android.gallery3d=Gallery2.apk
com.android.inputdevices=InputDevices.apk
com.android.keyguard=Keyguard.apk
com.android.location.fused=FusedLocation.apk
com.android.musicfx=MusicFX.apk
com.android.onetimeinitializer=OneTimeInitializer.apk
com.android.phone=TeleService.apk
com.android.providers.calendar=CalendarProvider.apk
com.android.providers.contacts=ContactsProvider.apk
com.android.providers.downloads=DownloadProvider.apk
com.android.providers.media=MediaProvider.apk
com.android.providers.settings=SettingsProvider.apk
com.android.proxyhandler=ProxyHandler.apk
com.android.settings=Settings.apk
com.android.sharedstoragebackup=SharedStorageBackup.apk
com.android.shell=Shell.apk
com.android.systemui=SystemUI.apk
com.android.vending=Phonesky.apk
com.android.vpndialogs=VpnDialogs.apk
com.android.wallpapercropper=WallpaperCropper.apk
com.google.android.backuptransport=GoogleBackupTransport.apk
com.google.android.feedback=GoogleFeedback.apk
com.google.android.gms=PrebuiltGmsCore.apk
com.google.android.gsf.login=GoogleLoginService.apk
com.google.android.gsf=GoogleServicesFramework.apk
com.google.android.partnersetup=GooglePartnerSetup.apk
com.google.tv.discovery=Discovery.apk
com.google.tv.ipremote=IpRemote.apk



