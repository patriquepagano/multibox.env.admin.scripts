#!/system/bin/sh
source /data/.vars
package="dxidev.toptvlauncher2"
am force-stop $package
file=/data/data/$package/shared_prefs/PREFERENCE_DATA.xml
if [ ! -d /data/data/$package/shared_prefs ];then
mkdir -p /data/data/$package/shared_prefs
fi
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
<int name="horizontalScrollView_AlignLeft_R1" value="0" />
<int name="PickColorHue" value="230" />
<string name="PinToUnlock"></string>
<string name="888646AppIconSize">Large</string>
<string name="3646BigOrSmallTile">Big</string>
<int name="TilesRow6Height" value="80" />
<int name="ShowAppsRequiresPIN" value="0" />
<int name="PickColorValue" value="64" />
<int name="ScreenHeight" value="1920" />
<string name="4646BigOrSmallTile">Big</string>
<string name="5646ImageOnTile">/system/asusbox/img/applist.webp</string>
<string name="5646BigOrSmallTile">Big</string>
<int name="0dcClockSize" value="0" />
<int name="EditModeEnabled" value="0" />
<int name="TilesRow4TileHeight" value="109" />
<string name="33646dcFont">Rounded</string>
<int name="TilesRow1Visible" value="1" />
<int name="6646AppIconBGcolor" value="0" />
<string name="LinearTilesRowGravity_Row3">Center</string>
<string name="902646BigOrSmallTile">Small</string>
<string name="5646AppList">com.siriusapplications.quickboot,com.aplicativox.asusbox,com.google.android.youtube.tv,com.google.android.apps.youtube.music,com.android.tv.settings,com.asusplay.asusplaysmartersplayer,com.asusbox.asusboxiptvbox,com.mixplorer,acr.browser.barebones,com.cetusplay.remoteservice,com.netflix.mediaclient</string>
<string name="LinearTilesRowGravity_Row1">Center</string>
<int name="ShowLongClickMenuDisabled" value="0" />
<string name="LinearTilesRowGravity_Row4">Center</string>
<int name="2646AppIconBGcolor" value="0" />
<string name="HiddenAppsList"></string>
<string name="33646BigOrSmallTile">IncludedWidget</string>
<string name="888646ImageOnTile">com.asusplay.asusplaysmartersplayer</string>
<string name="718646BigOrSmallTile">Small</string>
<string name="LinearTilesRowGravity_Row5">Center</string>
<int name="NumberofAppDrawerColumns" value="3" />
<int name="p_LastFocusedItem" value="3646" />
<int name="horizontalScrollView_AlignLeft_R4" value="0" />
<int name="3646AppIconBGcolor" value="0" />
<string name="1646AppIconSize">image</string>
<int name="ShowTTLSettingsRequiresPIN" value="1" />
<int name="customTileBorderColorAlpha" value="255" />
<int name="TilesRow1Height" value="129" />
<string name="902646AppIconSize">image</string>
<string name="wallpaper_location">/system/asusbox/img/wallpaper.webp</string>
<string name="2646AppList">com.google.android.youtube.tv</string>
<int name="ShowAndroidSettingsRequiresPIN" value="0" />
<int name="customTileBorderColorHue" value="0" />
<string name="6646AppIconSize">image</string>
<string name="6646AppList">com.netflix.mediaclient</string>
<string name="TilesRow1">33646,902646</string>
<string name="902646AppList">com.xyz.fullscreenbrowser</string>
<string name="718646AppIconSize">image</string>
<int name="33646WidgetWidth" value="0" />
<int name="TilesRow1TileHeight" value="128" />
<string name="6646ImageOnTile">/system/asusbox/img/netflix.webp</string>
<int name="customTileBorderColorSaturation" value="60" />
<string name="1646BigOrSmallTile">Big</string>
<string name="mainAppDraw_gridview_textsize">Medium</string>
<int name="TilesRow3Height" value="170" />
<int name="33646WidgetHeight" value="0" />
<int name="902646AppIconBGcolor" value="0" />
<int name="5646AppIconBGcolor" value="0" />
<int name="888646AppIconBGcolor" value="-13288904" />
<int name="TilesRow5TileHeight" value="140" />
<int name="TilesRow2Visible" value="1" />
<string name="888646AppList">com.asusplay.asusplaysmartersplayer</string>
<string name="6646BigOrSmallTile">Big</string>
<int name="4646AppIconBGcolor" value="0" />
<string name="2646ImageOnTile">/system/asusbox/img/youtube.webp</string>
<string name="4646AppList">com.google.android.apps.youtube.music</string>
<int name="33646dcClockSize" value="50" />
<int name="TilesRow4Visible" value="0" />
<string name="2646BigOrSmallTile">Big</string>
<int name="PickColorSaturation" value="100" />
<int name="PickColorAlpha" value="180" />
<int name="TilesRow2Height" value="180" />
<string name="dynamic_gridview_textsize">Medium</string>
<string name="3646AppIconSize">image</string>
<int name="horizontalScrollView_AlignLeft_R3" value="0" />
<string name="2646AppIconSize">image</string>
<string name="3646AppList">com.iptz,com.iptv.sgxhgt,com.realplay.ntv_2,com.nathnetwork.ativalivefourk,com.b4tv.br,com.szdq.elinksmart.vtv,com.tosmart.iptw,com.realplay.wstv,com.example.myiptv.souza,com.auth.gotv.brlive,com.mm.droid.livetv.express,com.mm.droid.livetv.kids,dp.ws.popcorntime,com.integration.unitviptv,com.eaith</string>
<int name="TilesRow2TileHeight" value="180" />
<int name="TilesRow6TileHeight" value="80" />
<string name="33646ImageOnTile">0</string>
<string name="3646ImageOnTile">/system/asusbox/img/silver.webp</string>
<string name="888646BigOrSmallTile">Small</string>
<int name="TilesRow3TileHeight" value="170" />
<int name="RandomInt" value="980" />
<int name="TilesRow4Height" value="110" />
<string name="1646AppList">com.asusbox.asusboxiptvbox</string>
<string name="902646ImageOnTile">/sdcard/Android/data/asusbox/.www/qrIP.png</string>
<string name="4646ImageOnTile">/system/asusbox/img/youtubemusic.webp</string>
<int name="customTileBorderColorValue" value="64" />
<string name="LinearTilesRowGravity_Row2">Center</string>
<string name="SetWallpaperMethod">method3</string>
<string name="TilesRow2">718646,1646,2646,3646</string>
<int name="718646AppIconBGcolor" value="0" />
<string name="1646ImageOnTile">/system/asusbox/img/asusbox.webp</string>
<string name="4646AppIconSize">image</string>
<int name="1646AppIconBGcolor" value="0" />
<int name="TilesRow3Visible" value="1" />
<int name="horizontalScrollView_AlignLeft_R2" value="0" />
<int name="UserHasOpenedEditLayout" value="1" />
<string name="SettingsList"></string>
<int name="ScreenWidth" value="1920" />
<string name="0dcFont">Default</string>
<string name="718646ImageOnTile">/system/asusbox/img/livestream.webp</string>
<string name="TilesRow3">4646,5646,6646,888646</string>
<int name="TilesRow5Height" value="140" />
<string name="5646AppIconSize">image</string>
<int name="launchStatus" value="16" />
<string name="718646AppList">com.aplicativox.asusbox</string>
</map>
EOF
uid=`dumpsys package $package | $grep "userId" | $cut -d "=" -f 2 | $cut -d " " -f 1`
$chown -R $uid:$uid /data/data/$package
$chmod 660 /data/data/$package/shared_prefs/*.xml
restorecon -FR /data/data/$package
