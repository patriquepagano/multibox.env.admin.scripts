#!/system/bin/sh

rm /data/data/dxidev.toptvlauncher2/shared_prefs/PREFERENCE_DATA.xml





package="dxidev.toptvlauncher2"
am force-stop $package
file=/data/data/$package/shared_prefs/PREFERENCE_DATA.xml
if [ ! -d /data/data/$package/shared_prefs ];then
    mkdir -p /data/data/$package/shared_prefs
fi
# clear
# sleep 60000

# Dir=$(dirname $0)
# cp $file $Dir/launcher-PREFERENCE_DATA.xml
# exit

cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <int name="horizontalScrollView_AlignLeft_R1" value="0" />
    <int name="PickColorHue" value="230" />
    <string name="PinToUnlock"></string>
    <string name="888646AppIconSize">image</string>
    <string name="3646BigOrSmallTile">Big</string>
    <int name="TilesRow6Height" value="80" />
    <int name="ShowAppsRequiresPIN" value="0" />
    <int name="PickColorValue" value="64" />
    <int name="ScreenHeight" value="1920" />
    <string name="4646BigOrSmallTile">Big</string>
    <int name="0dcClockSize" value="0" />
    <int name="EditModeEnabled" value="0" />
    <int name="TilesRow4TileHeight" value="109" />
    <string name="33646dcFont">Rounded</string>
    <string name="1033646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher-update/myfamily.png</string>
    <int name="TilesRow1Visible" value="1" />
    <int name="6646AppIconBGcolor" value="0" />
    <string name="LinearTilesRowGravity_Row3">Center</string>
    <string name="902646BigOrSmallTile">Small</string>
    <string name="LinearTilesRowGravity_Row1">Center</string>
    <int name="ShowLongClickMenuDisabled" value="0" />
    <int name="2646AppIconBGcolor" value="0" />
    <string name="LinearTilesRowGravity_Row4">Center</string>
    <string name="HiddenAppsList"></string>
    <string name="33646BigOrSmallTile">IncludedWidget</string>
    <string name="888646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher-update/PrimeVideo.png</string>
    <string name="1034646AppIconSize">image</string>
    <string name="1033646BigOrSmallTile">Small</string>
    <int name="1033646AppIconBGcolor" value="0" />
    <string name="718646BigOrSmallTile">Small</string>
    <string name="LinearTilesRowGravity_Row5">Center</string>
    <int name="NumberofAppDrawerColumns" value="3" />
    <int name="1034646AppIconBGcolor" value="0" />
    <int name="p_LastFocusedItem" value="1646" />
    <int name="horizontalScrollView_AlignLeft_R4" value="0" />
    <int name="3646AppIconBGcolor" value="0" />
    <string name="1646AppIconSize">image</string>
    <int name="ShowTTLSettingsRequiresPIN" value="1" />
    <int name="customTileBorderColorAlpha" value="255" />
    <int name="TilesRow1Height" value="129" />
    <string name="902646AppIconSize">image</string>
    <string name="wallpaper_location">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher/wallpaper.webp</string>
    <string name="2646AppList">com.google.android.youtube.tv</string>
    <int name="ShowAndroidSettingsRequiresPIN" value="0" />
    <int name="customTileBorderColorHue" value="0" />
    <string name="6646AppIconSize">image</string>
    <string name="6646AppList">com.netflix.mediaclient</string>
    <string name="TilesRow1">33646,902646</string>
    <string name="902646AppList">acr.browser.barebones</string>
    <string name="718646AppIconSize">image</string>
    <int name="33646WidgetWidth" value="0" />
    <int name="TilesRow1TileHeight" value="128" />
    <string name="1034646AppList">tv.pluto.android</string>
    <string name="6646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher/netflix.webp</string>
    <int name="customTileBorderColorSaturation" value="60" />
    <string name="1646BigOrSmallTile">Big</string>
    <string name="mainAppDraw_gridview_textsize">Medium</string>
    <string name="1033646AppList">com.valor.mfc.droid.tvapp.generic</string>
    <int name="TilesRow3Height" value="170" />
    <int name="33646WidgetHeight" value="0" />
    <int name="902646AppIconBGcolor" value="0" />
    <int name="888646AppIconBGcolor" value="0" />
    <int name="TilesRow5TileHeight" value="140" />
    <int name="TilesRow2Visible" value="1" />
    <string name="888646AppList">com.amazon.avod.thirdpartyclient</string>
    <string name="6646BigOrSmallTile">Big</string>
    <int name="4646AppIconBGcolor" value="0" />
    <string name="2646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher/youtube.webp</string>
    <string name="4646AppList">com.google.android.apps.youtube.music</string>
    <int name="33646dcClockSize" value="50" />
    <int name="TilesRow4Visible" value="0" />
    <string name="2646BigOrSmallTile">Big</string>
    <int name="PickColorSaturation" value="100" />
    <int name="PickColorAlpha" value="180" />
    <int name="TilesRow2Height" value="180" />
    <string name="dynamic_gridview_textsize">Medium</string>
    <string name="1033646AppIconSize">image</string>
    <string name="3646AppIconSize">image</string>
    <int name="horizontalScrollView_AlignLeft_R3" value="0" />
    <string name="2646AppIconSize">image</string>
    <string name="3646AppList">bnsky.tv,com.asxbn,com.zze.iptvbsatip,com.world.youcinetv,br.com.iptv,com.brtv.vod,com.eaitv,com.rednetapp.worldiptv,com.zntv,com.blk.cine,com.example.myiptv.SouzaGo,com.b4k,com.realplay.ntv_2,com.realplay.wstv,com.example.myiptv.souza,dp.ws.popcorntime,com.integration.unitviptv,com.cine.criciuma.br</string>
    <int name="TilesRow2TileHeight" value="180" />
    <int name="TilesRow6TileHeight" value="80" />
    <string name="33646ImageOnTile">0</string>
    <string name="3646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher/silver.webp</string>
    <string name="888646BigOrSmallTile">Small</string>
    <int name="TilesRow3TileHeight" value="170" />
    <int name="RandomInt" value="1047" />
    <int name="TilesRow4Height" value="110" />
    <string name="1646AppList">com.asusbox.asusboxiptvbox,com.aplicativox.asusbox,com.asusplay.asusplaysmartersplayer,asusbox.tv</string>
    <string name="902646ImageOnTile">/sdcard/Android/data/asusbox/.www/qrIP.png</string>
    <string name="1034646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher-update/plutoTV.png</string>
    <string name="4646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher/youtubemusic.webp</string>
    <int name="customTileBorderColorValue" value="64" />
    <string name="LinearTilesRowGravity_Row2">Center</string>
    <string name="SetWallpaperMethod">method3</string>
    <string name="TilesRow2">718646,1646,2646,3646</string>
    <string name="1646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher/asusbox.webp</string>
    <int name="718646AppIconBGcolor" value="0" />
    <string name="4646AppIconSize">image</string>
    <int name="1646AppIconBGcolor" value="0" />
    <int name="TilesRow3Visible" value="1" />
    <int name="horizontalScrollView_AlignLeft_R2" value="0" />
    <int name="UserHasOpenedEditLayout" value="1" />
    <string name="SettingsList"></string>
    <int name="ScreenWidth" value="1920" />
    <string name="0dcFont">Default</string>
    <string name="718646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher/livestream.webp</string>
    <string name="TilesRow3">4646,6646,888646,1033646,1034646</string>
    <int name="TilesRow5Height" value="140" />
    <int name="launchStatus" value="16" />
    <string name="718646AppList">com.asx4k</string>
    <string name="1034646BigOrSmallTile">Small</string>
</map>
EOF
uid=`dumpsys package $package | /system/bin/busybox grep "userId" | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox cut -d " " -f 1`
/system/bin/busybox chown -R $uid:$uid /data/data/$package
/system/bin/busybox chmod 660 /data/data/$package/shared_prefs/*.xml
restorecon -FR /data/data/$package

pm grant $package android.permission.READ_EXTERNAL_STORAGE
#am force-stop $package

#pm enable dxidev.toptvlauncher2

#exit


### para quem ja tiver a launcher só força o setting
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"

# ## necessário para chamar a launcher para a frnte
# am start --user 0 -a android.intent.action.MAIN dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity


am start -a android.intent.action.MAIN -c android.intent.category.HOME



