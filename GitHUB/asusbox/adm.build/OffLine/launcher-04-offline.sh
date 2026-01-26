#!/system/bin/sh


#package="dxidev.toptvlauncher2"
package="launcher.offline"

am force-stop $package
file=/data/data/$package/shared_prefs/PREFERENCE_DATA.xml
if [ ! -d /data/data/$package/shared_prefs ];then
    mkdir -p /data/data/$package/shared_prefs
fi


# Dir=$(dirname $0)
# cp $file $Dir/launcher-PREFERENCE_DATA.xml
# exit

/system/bin/busybox cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <int name="horizontalScrollView_AlignLeft_R1" value="0" />
    <string name="1460646AppList">acr.browser.barebones</string>
    <int name="PickColorHue" value="230" />
    <string name="PinToUnlock"></string>
    <int name="TilesRow6Height" value="80" />
    <string name="TilesRow5"></string>
    <int name="ShowAppsRequiresPIN" value="0" />
    <int name="PickColorValue" value="64" />
    <int name="ScreenHeight" value="1920" />
    <string name="1446646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher-update/null.png</string>
    <int name="0dcClockSize" value="0" />
    <string name="1269646AppIconSize">image</string>
    <int name="EditModeEnabled" value="0" />
    <int name="TilesRow4TileHeight" value="109" />
    <int name="TilesRow1Visible" value="1" />
    <string name="1460646AppIconSize">image</string>
    <string name="1284646BigOrSmallTile">Big</string>
    <string name="1284646AppList">acr.browser.barebones</string>
    <string name="LinearTilesRowGravity_Row3">Center</string>
    <string name="LinearTilesRowGravity_Row1">Center</string>
    <int name="ShowLongClickMenuDisabled" value="0" />
    <string name="LinearTilesRowGravity_Row4">Center</string>
    <string name="HiddenAppsList"></string>
    <string name="1080646AppIconSize">image</string>
    <string name="1446646AppIconSize">image</string>
    <string name="1392646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher-update/null.png</string>
    <string name="1392646AppList">acr.browser.barebones</string>
    <string name="1392646AppIconSize">image</string>
    <string name="LinearTilesRowGravity_Row5">Center</string>
    <string name="1392646BigOrSmallTile">Big</string>
    <int name="NumberofAppDrawerColumns" value="3" />
    <int name="p_LastFocusedItem" value="1460646" />
    <int name="1392646AppIconBGcolor" value="0" />
    <string name="1137646AppIconSize">image</string>
    <int name="horizontalScrollView_AlignLeft_R4" value="0" />
    <int name="ShowTTLSettingsRequiresPIN" value="1" />
    <string name="1284646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher-update/null.png</string>
    <string name="1460646BigOrSmallTile">Big</string>
    <string name="1269646BigOrSmallTile">Small</string>
    <int name="1269646AppIconBGcolor" value="0" />
    <string name="1285646BigOrSmallTile">Big</string>
    <string name="1285646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher-update/null.png</string>
    <int name="customTileBorderColorAlpha" value="255" />
    <int name="TilesRow1Height" value="129" />
    <string name="wallpaper_location">/storage/emulated/0/Android/data/asusbox/.www/boot-files/no.internet.jpg</string>
    <string name="1080646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher-update/NetFlix.png</string>
    <int name="ShowAndroidSettingsRequiresPIN" value="0" />
    <string name="1269646AppList">acr.browser.barebones</string>
    <int name="customTileBorderColorHue" value="0" />
    <string name="1269646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher-update/internet.png</string>
    <string name="TilesRow1">1446646,1300646,1460646,1284646,1137646,1269646</string>
    <string name="1460646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher-update/null.png</string>
    <string name="1446646AppList">acr.browser.barebones</string>
    <int name="TilesRow1TileHeight" value="128" />
    <int name="1393646AppIconBGcolor" value="0" />
    <int name="customTileBorderColorSaturation" value="60" />
    <string name="mainAppDraw_gridview_textsize">Medium</string>
    <int name="TilesRow3Height" value="170" />
    <string name="1285646AppIconSize">image</string>
    <string name="1300646AppIconSize">image</string>
    <int name="1300646AppIconBGcolor" value="0" />
    <int name="TilesRow5TileHeight" value="140" />
    <int name="TilesRow2Visible" value="1" />
    <string name="1285646AppList">acr.browser.barebones</string>
    <string name="1446646BigOrSmallTile">Big</string>
    <string name="1393646BigOrSmallTile">Big</string>
    <string name="1284646AppIconSize">image</string>
    <string name="1137646AppList">dp.ws.popcorntime</string>
    <string name="1393646AppList">acr.browser.barebones</string>
    <int name="TilesRow4Visible" value="0" />
    <int name="PickColorSaturation" value="100" />
    <int name="PickColorAlpha" value="180" />
    <int name="TilesRow2Height" value="180" />
    <string name="dynamic_gridview_textsize">Medium</string>
    <int name="horizontalScrollView_AlignLeft_R3" value="0" />
    <int name="1285646AppIconBGcolor" value="0" />
    <int name="TilesRow2TileHeight" value="180" />
    <string name="1080646BigOrSmallTile">Small</string>
    <int name="TilesRow6TileHeight" value="80" />
    <string name="1300646BigOrSmallTile">Big</string>
    <string name="1393646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher-update/null.png</string>
    <int name="1284646AppIconBGcolor" value="0" />
    <int name="TilesRow3TileHeight" value="170" />
    <int name="RandomInt" value="1473" />
    <int name="TilesRow4Height" value="110" />
    <string name="1300646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher-update/null.png</string>
    <int name="customTileBorderColorValue" value="64" />
    <string name="LinearTilesRowGravity_Row2">Center</string>
    <string name="SetWallpaperMethod">method3</string>
    <string name="TilesRow2">1285646,1392646,1393646,1080646</string>
    <string name="1300646AppList">acr.browser.barebones</string>
    <int name="TilesRow5Visible" value="1" />
    <string name="1080646AppList">com.netflix.mediaclient</string>
    <int name="1446646AppIconBGcolor" value="0" />
    <int name="TilesRow3Visible" value="0" />
    <int name="horizontalScrollView_AlignLeft_R2" value="0" />
    <string name="1137646BigOrSmallTile">Small</string>
    <int name="UserHasOpenedEditLayout" value="1" />
    <string name="SettingsList"></string>
    <int name="ScreenWidth" value="1920" />
    <string name="1137646ImageOnTile">/storage/emulated/0/Android/data/asusbox/.www/.img.launcher/launcher-update/logo-popcorn.png</string>
    <string name="0dcFont">Default</string>
    <int name="1460646AppIconBGcolor" value="0" />
    <string name="TilesRow3"></string>
    <int name="1137646AppIconBGcolor" value="0" />
    <int name="1080646AppIconBGcolor" value="0" />
    <int name="TilesRow5Height" value="140" />
    <int name="launchStatus" value="16" />
    <string name="1393646AppIconSize">image</string>
</map>

EOF
uid=`dumpsys package $package | /system/bin/busybox grep "userId" | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox cut -d " " -f 1`
/system/bin/busybox chown -R $uid:$uid /data/data/$package
/system/bin/busybox chmod 660 /data/data/$package/shared_prefs/*.xml
restorecon -FR /data/data/$package

pm grant $package android.permission.READ_EXTERNAL_STORAGE
am force-stop $package

#pm enable dxidev.toptvlauncher2

#exit



####### Ativa a Launcher Install
### para quem ja tiver a launcher só força o setting
cmd package set-home-activity "launcher.offline/dxidev.toptvlauncher2.HomeActivity"
## necessário para chamar a launcher para a frnte
#am start --user 0 -a android.intent.action.MAIN launcher.offline/dxidev.toptvlauncher2.HomeActivity




# ### para quem ja tiver a launcher só força o setting
#cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
# ## necessário para chamar a launcher para a frente
# am start --user 0 -a android.intent.action.MAIN dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity




