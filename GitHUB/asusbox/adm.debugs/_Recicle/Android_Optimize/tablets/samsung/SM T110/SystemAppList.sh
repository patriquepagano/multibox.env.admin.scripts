pathFile="/sdcard/newlist"
clear | rm $pathFile
appList=`pm list packages -f | grep -e '/system/app/' | sed -e 's,package:/system/app/,,g'` 
for i in $appList; do
	apk=`echo $i | cut -d "=" -f 1`
	name=`echo $i | cut -d "=" -f 2`
echo $name=$apk >> $pathFile
done
cat $pathFile | sort > $pathFile | cat $pathFile



com.android.MtpApplication=MtpApplication.apk
com.android.apps.tag=Tag.apk
com.android.backupconfirm=BackupRestoreConfirmation.apk
com.android.bluetooth=Bluetooth.apk
com.android.cellbroadcastreceiver=CellBroadcastReceiver.apk
com.android.certinstaller=CertInstaller.apk
com.android.chrome=ChromeWithBrowser.apk
com.android.contacts=SecContacts.apk
com.android.defcontainer=DefaultContainerService.apk
com.android.htmlviewer=SecHTMLViewer.apk
com.android.inputdevices=InputDevices.apk
com.android.keychain=KeyChain.apk
com.android.location.fused=FusedLocation.apk
com.android.packageinstaller=PackageInstaller.apk
com.android.phone=SecPhone.apk
com.android.providers.applications=ApplicationsProvider.apk
com.android.providers.calendar=SecCalendarProvider_Tablet.apk
com.android.providers.contacts=SecContactsProvider.apk
com.android.providers.downloads=SecDownloadProvider.apk
com.android.providers.downloads.ui=SecDownloadProviderUi.apk
com.android.providers.drm=DrmProvider.apk
com.android.providers.media=SecMediaProvider.apk
com.android.providers.partnerbookmarks=PartnerBookmarksProvider.apk
com.android.providers.security=SecurityProvider.apk
com.android.providers.settings=SecSettingsProvider.apk
com.android.providers.userdictionary=UserDictionaryProvider.apk
com.android.settings=SecSettings.apk
com.android.sharedstoragebackup=SharedStorageBackup.apk
com.android.stk=Stk.apk
com.android.systemui=SystemUI.apk
com.android.vending=Phonesky.apk
com.android.vpndialogs=VpnDialogs.apk
com.google.android.apps.uploader=MediaUploader.apk
com.google.android.backup=GoogleBackupTransport.apk
com.google.android.configupdater=ConfigUpdater.apk
com.google.android.feedback=GoogleFeedback.apk
com.google.android.gms=GmsCore.apk
com.google.android.gsf=GoogleServicesFramework.apk
com.google.android.gsf.login=GoogleLoginService.apk
com.google.android.location=NetworkLocation.apk
com.google.android.partnersetup=GooglePartnerSetup.apk

com.google.android.setupwizard=SetupWizard.apk
com.google.android.syncadapters.bookmarks=ChromeBookmarksSyncAdapter.apk
com.google.android.syncadapters.calendar=GoogleCalendarSyncAdapter.apk
com.google.android.syncadapters.contacts=GoogleContactsSyncAdapter.apk
com.marvell.graphics.ceu=GPUEngine-CEU-Res.apk
com.marvell.logtools=logtools.apk
com.marvell.networkinfo=NetworkInfo.apk
com.marvell.ppdgadget=EventRelay.apk
com.marvell.thermal=ThermalService.apk
com.marvell.usbsetting=UsbSetting.apk
com.rxnetworks.rxnservicesxybrid=rxn_services_xybrid.apk
com.samsung.android.app.accesscontrol=AccessControl_tablet.apk
com.samsung.android.app.assistantmenu=AssistantMenu_tablet.apk
com.samsung.android.app.shareaccessibilitysettings=SharingAccessibilitySettings.apk
com.samsung.android.providers.context=ContextProvider.apk
com.samsung.clipboardsaveservice=ClipboardSaveService.apk
com.samsung.scrc.idi.server=INDI_Server.apk
com.sec.android.Preconfig=Preconfig.apk
com.sec.android.RilServiceModeApp=ServiceModeApp_RIL.apk
com.sec.android.app.DataCreate=AutomationTest_FB.apk
com.sec.android.app.FlashBarService=FlashBarService.apk
com.sec.android.app.SecSetupWizard=SecSetupWizard2013.apk
com.sec.android.app.bluetoothtest=BluetoothTest.apk
com.sec.android.app.camera=SamsungCamera.apk
com.sec.android.app.controlpanel=TabletJobManager.apk
com.sec.android.app.factorykeystring=FactoryKeystring_FB.apk
com.sec.android.app.hwmoduletest=HwModuleTest.apk
com.sec.android.app.launcher=SecLauncher3.apk
com.sec.android.app.parser=SCParser.apk
com.sec.android.app.popupuireceiver=PopupuiReceiver.apk
com.sec.android.app.servicemodeapp=serviceModeApp_FB.apk
com.sec.android.app.sns3=SNS.apk
com.sec.android.app.sysscope=SysScope.apk
com.sec.android.app.wlantest=WlanTest.apk
com.sec.android.directconnect=DirectConnect.apk
com.sec.android.inputmethod=SamsungIME.apk
com.sec.android.mmapp=MMAppFramework.apk
com.sec.android.motions.settings.panningtutorial=PanningTryActually.apk
com.sec.android.pagebuddynotisvc=PageBuddyNotiSvc2.apk
com.sec.android.preloadinstaller=PreloadInstaller.apk
com.sec.android.provider.badge=BadgeProvider.apk
com.sec.android.provider.logsprovider=LogsProvider.apk
com.sec.android.providers.downloads=SecOmaDownloadProvider.apk
com.sec.android.providers.tasks=TasksProvider.apk
com.sec.android.service.cm=CapabilityManagerService.apk
com.sec.app.RilErrorNotifier=PhoneErrService.apk
com.sec.bcservice=BCService.apk
com.sec.enterprise.mdm.services.simpin=EdmSimPinService.apk
com.sec.enterprise.mdm.services.sysscope=EdmSysScopeService.apk
com.sec.enterprise.mdm.services.vpn=EdmVpnServices.apk
com.sec.enterprise.permissions=EnterprisePermissions.apk
com.sec.esdk.elm=ELMAgent.apk
com.sec.factory=FactoryTest_FB.apk
com.sec.factory.camera=FactoryCamera_FB.apk
com.sec.ims.android=secimsfw.apk
com.sec.minimode.taskcloser=MiniTaskcloserService.apk
com.sec.setdefaultlauncher=SetDefaultLauncher.apk
com.sec.smartcard.pinservice=SmartcardManager.apk
eu.chainfire.supersu=Superuser.apk
org.simalliance.openmobileapi.service=SmartcardService.apk
















appRemove="

"
clear
for i in $appRemove; do
mount -o remount,rw /system
	app=`echo $i | cut -d "=" -f 2 | sed -e 's/.apk//g'`
	data=`echo $i | cut -d "=" -f 1`
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
	clear
done








# removidos do system



com.google.android.play.games=PlayGames.apk
android.googleSearch.googleSearchWidget=GoogleSearchWidget.apk
br.org.sidi.aplicacoesbrasil.widget=Destaques_20140605_04_00_09_REL_sidisigned.apk
br.org.sidi.b2xmobile=B2XMobile_050019_HQ_aligned_signed_.apk
com.android.browser=SecBrowser.apk
com.android.calendar=SecCalendar_Tablet.apk
com.android.dreams.basic=BasicDreams.apk
com.android.dreams.phototable=PhotoTable.apk
com.android.email=SecEmail_Tablet.apk
com.android.exchange=SecExchange.apk
com.android.musicfx=MusicFX.apk
com.android.noisefield=NoiseField.apk
com.android.phasebeam=PhaseBeam.apk
com.android.wallpaper.livepicker=SecLiveWallpapersPicker.apk
com.dropbox.android=Dropbox.apk
com.ea.game.bejeweled2=Bejeweled_Samsung_GoyaWiFi_2.0.23_LATAM_v1.9.0_id_10483.apk
com.epson.mobilephone.samsungprintservice=MobilePrintSvc_Epson.apk
com.evernote=com.evernote.samsung-br.AM_553.all.latest.apk
com.fmm.dm=FmmDM.apk
com.fmm.ds=FmmDS.apk
com.gameloft.android.LATAM.GloftA7TB=Asphalt7_update0_LATAM_SAMSUNG_SM_T110_1305_52499_101_101.apk
com.gameloft.android.LATAM.GloftSDTB=SharkDash_update0_LATAM_Samsung_T110_EN_BR_CO_IGP_GLLive_102.apk
com.google.android.apps.books=Books.apk
com.google.android.apps.docs=GoogleDrive.apk
com.google.android.apps.magazines=Magazines.apk
com.google.android.apps.maps=GMS_Maps.apk
com.google.android.apps.plus=PlusOne.apk
com.google.android.gm=Gmail2.apk
com.google.android.googlequicksearchbox=Velvet.apk
com.google.android.marvin.talkback=talkback.apk
com.google.android.music=Music2.apk
com.google.android.street=Street.apk
com.google.android.talk=Hangouts.apk
com.google.android.tts=GoogleTTS.apk
com.google.android.youtube=YouTube.apk
com.google.android.videos=Videos.apk
com.google.android.voicesearch=VoiceSearchStub.apk
com.infraware.polarisoffice5tablet=PolarisOffice5_Tablet.apk
com.lifevibes.trimapp=TrimApp_tablet.apk
com.monotype.android.font.chococooky=ChocoEUKor.apk
com.monotype.android.font.cooljazz=CoolEUKor.apk
com.monotype.android.font.droidserifitalic=DroidSansSherifItalic.apk
com.monotype.android.font.rosemary=RoseEUKor.apk
com.monotype.android.font.samsungsans=SamsungSans.apk
com.osp.app.signin=Samsungservice.apk
com.popcap.pvz=PlantsvsZombies_Samsung_GoyaWiFi_3.0.9_LATAM_v1.9.0_id_10470.apk
com.promotionwidget.widget2=PromotionWidget_Rel_130807_SidiKey.apk
com.samsung.SMT=SamsungTTS_white.apk
com.samsung.android.sdk.spenv10=SPenSdk3.apk
com.samsung.everglades.video=SecVideoList2.apk
com.samsung.helphub=InteractiveTutorial.apk
com.samsung.pickuptutorial=PickUpTutorial.apk
com.samsung.sec.android.application.csc=CSC.apk
com.samsung.shareshot=ShareShotService.apk
com.sec.android.Kies=Kies.apk
com.sec.android.SimpleWidget=SimpleWidget.apk
com.sec.android.allshare.service.controlshare=AllshareControlShare.apk
com.sec.android.allshare.service.fileshare=AllshareFileShare.apk
com.sec.android.allshare.service.mediashare=AllshareMediaShare.apk
com.sec.android.app.FileShareClient=AllshareFileShareClient.apk
com.sec.android.app.FileShareServer=AllshareFileShareServer.apk
com.sec.android.app.browsertry=SecBrowserTry.apk
com.sec.android.app.clockpackage=SecTabletClockPackage.apk
com.sec.android.app.keyguard=KeyguardWidget.apk
com.sec.android.app.keyguardbackuprestore=KeyguardBackupRestore.apk
com.sec.android.app.kieswifi=kieswifi.apk
com.sec.android.app.memo=TMemo.apk
com.sec.android.app.minimode.res=minimode-res.apk
com.sec.android.app.mobileprint=MobilePrint2.apk
com.sec.android.app.mt=MobileTrackerEngineTwo.apk
com.sec.android.app.music=SecTabletMusicPlayer_S1.apk
com.sec.android.app.myfiles=SecTabletMyFiles.apk
com.sec.android.app.popupcalculator=SecTabletCalculator2.apk
com.sec.android.app.ringtoneBR=ringtoneBR.apk
com.sec.android.app.samsungapps.una2=SamsungAppsUNA3.apk
com.sec.android.app.samsungapps=SamsungApps_Tablet.apk
com.sec.android.app.videoplayer=SecVideoPlayer.apk
com.sec.android.app.wallpaperchooser=SecWallpaperChooser.apk
com.sec.android.app.worldclock=SecTabletWorldClock.apk
com.sec.android.cloudagent=CloudAgent.apk
com.sec.android.cloudagent.dropboxoobe=DropboxOOBE.apk
com.sec.android.daemonapp=WeatherWidgetDaemon.apk
com.sec.android.fotaclient=FotaClient.apk
com.sec.android.gallery3d=SecGallery2013.apk
com.sec.android.nearby.mediaserver=AllshareMediaServer.apk
com.sec.android.provider.snote=SNoteProvider.apk
com.sec.android.sCloudBackupApp=sCloudBackupApp.apk
com.sec.android.sCloudBackupProvider=sCloudBackupProvider.apk
com.sec.android.sCloudRelayData=sCloudDataRelay.apk
com.sec.android.sCloudSync=sCloudDataSync.apk
com.sec.android.sCloudSyncBrowser=sCloudSyncBrowser.apk
com.sec.android.sCloudSyncCalendar=sCloudSyncCalendar.apk
com.sec.android.sCloudSyncContacts=sCloudSyncContacts.apk
com.sec.android.sCloudSyncSNote=sCloudSyncSNote.apk
com.sec.android.scloud.quota=sCloudQuotaApp.apk
com.sec.android.usermanual=UserManual_1.0.apk
com.sec.android.widgetapp.SPlannerAppWidget=SPlannerAppWidget.apk
com.sec.android.widgetapp.activeapplicationwidget=SamsungWidget_ActiveApplication.apk
com.sec.android.widgetapp.ap.hero.accuweather=AccuweatherPhone2013.apk
com.sec.android.widgetapp.ap.yahoostock.stockclock=YahoostockPhone2013.apk
com.sec.android.widgetapp.digitalclock=SecTabletDigitalClock.apk
com.sec.android.widgetapp.dualclockdigital=SecTabletDualClockDigital.apk
com.sec.android.widgetapp.memo=TextMemoWidget_SmartPhone.apk
com.sec.app.samsungprintservice=MobilePrintSvc_Samsung.apk
com.sec.dsm.phone=DSMForwarding.apk
com.sec.dsm.system=DSMLawmo.apk
com.sec.kidsplat.installer=SecKidsModeInstaller.apk
com.sec.pcw.device=PCWClientS.apk
com.sec.pcw=AllSharePlay15_Tab.apk
com.sec.phone=SecFactoryPhoneTest.apk
com.sec.spp.push=SPPPushClient_Prod.apk
com.siso.app.generic=MobilePrintSvc_CUPS.apk
com.siso.app.genericprintservice=MobilePrintSvc_CUPS_Backend.apk
com.smlds=SyncmlDS.apk
com.vlingo.midas=S-Voice_Android_tablet_vlingo.apk
com.wssnps=wssyncmlnps.apk
com.wssyncmldm=SyncmlDM.apk
flipboard.app=Flipboard.apk






