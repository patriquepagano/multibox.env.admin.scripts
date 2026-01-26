#!/system/bin/sh

anotação qe vai ir para o site..

# regravar o firmware..
modo download:
volume - e home segura
aperta power (quando aparecer a tela)
solta power..
solta volume - e segura volume +
solta home

----

carrega melhor firmware pra ele
T110XXUANH6_T110ZTOANH1_T110XXUANH6_HOME.tar.md5

desliga o auto-reboot

grava o recovery
entra no recovery e grava root superSu
wipe
grava o stock recovery (boot loop issues)

------------

nao tem dirname !!!!!!!!!

tem q instalar os apps base na mão




rodo to o xmind padrao da nossa base...





# removendo os users apps





apps=`pm list packages -f | grep -e '/data/app/' | sed -e 's,package:/data/app/,,g' | cut -d "=" -f 2 | grep -v "berserker.android.apps.sshdroid" | sort`
for loop in $apps; do
	echo "Desinstalando.. " $loop
	pm clear $loop
	pm uninstall $loop
	rm -rf /data/data/$loop
	rm -rf /data/app-lib/$loop
	sleep 2
done













# desativa o google Play
pm disable com.google.android.gms
pm disable com.android.vending

pm list packages -f | grep -e '/system/app/' | sed -e 's,package:/system/app/,,g' | cut -d "=" -f 2


de.falkemedia.myboard
com.sec.android.app.samsungapps
de.kaufda.android
de.pizza
de.worldiety.photiety.cewe.smartphoto.de


berserker.android.apps.sshdroid

appRemove="
com.google.android.apps.books
com.google.android.apps.magazines
com.google.android.apps.maps
com.google.android.videos
com.google.android.gm
# google talk
com.google.android.talk
com.google.android.tts
com.google.android.apps.plus
com.google.android.apps.docs
"
for app in $appRemove; do
echo 'desativando ' $app
pm disable $app
pm clear $app
pm uninstall $app
done






# desativados do system
# google bloatwares
# gmail
com.google.android.gm
# google talk
com.google.android.talk
com.google.android.tts
com.google.android.apps.plus
com.google.android.apps.docs

# volta a cada boot
com.google.android.apps.books
com.google.android.apps.magazines
com.google.android.apps.maps
com.google.android.videos


com.google.android.voicesearch
com.popcap.pvz
com.promotionwidget.widget2
android.googleSearch.googleSearchWidget






# porcarias osbsoletas samsung
com.sec.android.app.memo
com.samsung.android.app.accesscontrol
com.samsung.android.app.assistantmenu
com.samsung.android.app.shareaccessibilitysettings
com.samsung.android.providers.context
com.samsung.android.sdk.spenv10
com.samsung.clipboardsaveservice
com.samsung.everglades.video
com.samsung.helphub
com.samsung.pickuptutorial
com.samsung.scrc.idi.server
com.samsung.sec.android.application.csc
com.samsung.shareshot
com.sec.android.app.samsungapps
com.sec.android.app.samsungapps.una2
com.sec.app.samsungprintservice
com.samsung.SMT
com.sec.pcw
com.sec.pcw.device
com.osp.app.signin
com.vlingo.midas
com.sec.android.app.popupcalculator
com.sec.android.app.worldclock
com.android.calendar
com.sec.android.app.myfiles
com.sec.android.app.clockpackage
com.android.musicfx
com.sec.android.app.music
# controle remoto ?
com.fmm.dm
com.fmm.ds






com.android.phasebeam
com.android.dreams.basic
com.android.dreams.phototable
com.android.wallpaper.livepicker

com.google.android.googlequicksearchbox
com.google.android.music
com.google.android.marvin.talkback
com.google.android.setupwizard
com.google.android.street
com.infraware.polarisoffice5tablet
com.lifevibes.trimapp
com.sec.android.fotaclient
com.sec.android.gallery3d
com.sec.kidsplat.installer
com.dropbox.android
com.ea.game.bejeweled2
com.epson.mobilephone.samsungprintservice
com.evernote
com.gameloft.android.LATAM.GloftA7TB
com.gameloft.android.LATAM.GloftSDTB
flipboard.app
org.simalliance.openmobileapi.service
br.org.sidi.aplicacoesbrasil.widget
br.org.sidi.b2xmobile
com.sec.android.widgetapp.SPlannerAppWidget
com.sec.android.widgetapp.activeapplicationwidget
com.sec.android.widgetapp.ap.hero.accuweather
com.sec.android.widgetapp.ap.yahoostock.stockclock
com.sec.android.widgetapp.digitalclock
com.sec.android.widgetapp.dualclockdigital
com.sec.android.widgetapp.memo
com.sec.android.sCloudBackupApp
com.sec.android.sCloudBackupProvider
com.sec.android.sCloudRelayData
com.sec.android.sCloudSync
com.sec.android.sCloudSyncBrowser
com.sec.android.sCloudSyncCalendar
com.sec.android.sCloudSyncContacts
com.sec.android.sCloudSyncSNote
com.sec.android.scloud.quota
com.sec.android.service.cm
com.sec.android.usermanual
com.android.email
com.android.exchange
com.sec.android.allshare.service.controlshare
com.sec.android.allshare.service.fileshare
com.sec.android.allshare.service.mediashare

































###################################################################################
# /system/priv-app
# futuro fazer lista invertida.. oque não posso desativar.. e desativar todo o resto.
appRemove="
#######################_Android_6
CalendarProvider/CalendarProvider.apk=com.android.providers.calendar
ContactsProvider/ContactsProvider.apk=com.android.providers.contacts
WallpaperCropper/WallpaperCropper.apk=com.android.wallpapercropper
#######################_Android_4.4.4
ThemeChooser.apk=org.cyanogenmod.theme.chooser
ThemesProvider.apk=org.cyanogenmod.themes.provider
VoiceDialer.apk=com.android.voicedialer
PicoTts.apk=com.svox.pico
CMAccount.apk=com.cyanogenmod.account
CMUpdater.apk=com.cyanogenmod.updater
DLNA.apk=com.amlogic.mediacenter
Gallery2.apk=com.android.gallery3d
MusicFX.apk=com.android.musicfx
WallpaperCropper.apk=com.android.wallpapercropper
Discovery.apk=com.google.tv.discovery
#######################_Porcarias_AMLOGIC
IpRemote.apk=com.google.tv.ipremote
#######################_não_remover_em_celulares
Contacts.apk=com.android.contacts
CalendarProvider.apk=com.android.providers.calendar
ContactsProvider.apk=com.android.providers.contacts
TeleService.apk=com.android.phone
Dialer.apk=com.android.dialer
Mms.apk=com.android.mms
"
clear
# as vezes não apaga bug do somente leitura no /system
mount -o remount,rw /system
for i in $appRemove; do   app=`echo $i `
	data=`echo $i | cut -d "=" -f 2`
	echo 'desativando ' $data
	pm disable $data
	pm clear $data
	sleep 2
done








# força linguagem para Brasil
	setprop persist.sys.language pt_BR
	setprop persist.sys.country BR
		# android 6
		am start -n com.android.settings/.Settings\$LocalePickerActivity




exit






rm /system/app/00_aria.tar.init_ok # debug

if [ ! -e /system/app/00_aria.tar.init_ok ] ; then
#mount -o remount,rw /system
	DownloadFiles="
	http://1.0.0.95/0/Dropbox-AndroidPortal/01-Install/0-apps/aria/aria2c_github
	http://1.0.0.95/0/Dropbox-AndroidPortal/01-Install/0-apps/aria/libaria2_PIC_exec.so
	http://1.0.0.95/0/Dropbox-AndroidPortal/01-Install/0-apps/aria/libaria2_exec.so
	http://1.0.0.95/0/Dropbox-AndroidPortal/01-Install/0-apps/gnutar.bin
	http://1.0.0.95/0/Dropbox-AndroidPortal/01-Install/0-apps/Universal_Init.d_1.2.1.apk
	"
	for i in $DownloadFiles; do
	mount -o remount,rw /system
		link=`echo $i`
		echo 'Download' $link
		cd /system/app
		#mount -o remount,rw /system
		wget $link
		sleep 1
		#mount -o remount,rw /system
		chmod 644 *.apk
		chmod 755 *.sh
	done
	mount -o remount,rw /system
	# aria2c
	chmod 755 /system/app/*aria2*
	# versão mais atual
	cp /system/app/aria2c_github /system/bin/aria2c
	aria2c -v
	rm /system/app/*aria2*
	# gnuTar
	mv /system/app/gnutar.bin /system/bin/gnutar
	chmod 755 /system/bin/aria2c
	chmod 755 /system/bin/gnutar
	echo "ok" > /system/app/00_aria.tar.init_ok
fi





link="http://1.0.0.95/0/Dropbox-AndroidPortal/01-Install/00_firstInstall_webserver.sh"
wget $link -O /data/app/tmp.sh && chmod 755 /data/app/tmp.sh && /data/app/tmp.sh && rm /data/app/tmp.sh





mount -o remount,rw /system
# init boot
mkdir -p /system/etc/init.d
chmod 755 /system/etc/init.d
InitBoot="/system/etc/init.d/Iniciar_Sistema"
cat <<'EOF' > $InitBoot
#!/system/bin/sh

/data/app/mediaserver/sh/Ativar_Cron_agenda_tarefas
/data/app/mediaserver/sh/Ativar_webServer

EOF
chown root:root $InitBoot && chmod 755 $InitBoot
rm /system/etc/init.d/found
rm /system/etc/init.d/no
rm /system/etc/init.d/scripts
rm /system/etc/init.d/Ativar_Cron_agenda_tarefas
rm /system/etc/init.d/Ativar_webServer








