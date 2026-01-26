#!/system/bin/sh


#package="dxidev.toptvlauncher2"
package="launcher.offline"

am force-stop $package
file=/data/data/$package/shared_prefs/PREFERENCE_DATA.xml
if [ ! -d /data/data/$package/shared_prefs ];then
    mkdir -p /data/data/$package/shared_prefs
fi

# cp $file /data/asusbox/adm.build/OnLine/launcher-PREFERENCE_DATA.xml
# exit

cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <int name="horizontalScrollView_AlignLeft_R1" value="0" />
    <int name="TilesRow5TileHeight" value="140" />
    <int name="PickColorHue" value="230" />
    <int name="TilesRow2Visible" value="1" />
    <string name="PinToUnlock"></string>
    <int name="TilesRow6Height" value="80" />
    <int name="ShowAppsRequiresPIN" value="0" />
    <int name="PickColorValue" value="64" />
    <int name="ScreenHeight" value="1920" />
    <int name="0dcClockSize" value="0" />
    <int name="EditModeEnabled" value="0" />
    <int name="TilesRow4TileHeight" value="109" />
    <int name="TilesRow1Visible" value="0" />
    <int name="TilesRow4Visible" value="0" />
    <string name="1217646ImageOnTile">/data/data/launcher.offline/update.png</string>
    <int name="TilesRow2Height" value="180" />
    <int name="PickColorAlpha" value="180" />
    <int name="PickColorSaturation" value="100" />
    <string name="LinearTilesRowGravity_Row3">Center</string>
    <string name="dynamic_gridview_textsize">Medium</string>
    <int name="horizontalScrollView_AlignLeft_R3" value="0" />
    <string name="LinearTilesRowGravity_Row1">Center</string>
    <int name="ShowLongClickMenuDisabled" value="0" />
    <string name="LinearTilesRowGravity_Row4">Center</string>
    <string name="HiddenAppsList"></string>
    <int name="TilesRow2TileHeight" value="180" />
    <int name="TilesRow6TileHeight" value="80" />
    <string name="LinearTilesRowGravity_Row5">Center</string>
    <int name="1217646AppIconBGcolor" value="0" />
    <int name="TilesRow3TileHeight" value="170" />
    <int name="NumberofAppDrawerColumns" value="3" />
    <int name="RandomInt" value="1217" />
    <int name="TilesRow4Height" value="110" />
    <int name="p_LastFocusedItem" value="1217646" />
    <int name="horizontalScrollView_AlignLeft_R4" value="0" />
    <int name="ShowTTLSettingsRequiresPIN" value="1" />
    <int name="customTileBorderColorValue" value="64" />
    <string name="LinearTilesRowGravity_Row2">Center</string>
    <string name="SetWallpaperMethod">method3</string>
    <int name="customTileBorderColorAlpha" value="255" />
    <string name="TilesRow2">1217646</string>
    <string name="1217646BigOrSmallTile">Big</string>
    <int name="TilesRow1Height" value="129" />
    <string name="wallpaper_location">/data/data/launcher.offline/00.update.reboot.jpg</string>
    <int name="TilesRow3Visible" value="0" />
    <int name="horizontalScrollView_AlignLeft_R2" value="0" />
    <int name="UserHasOpenedEditLayout" value="1" />
    <string name="1217646AppIconSize">image</string>
    <int name="ShowAndroidSettingsRequiresPIN" value="0" />
    <string name="SettingsList"></string>
    <int name="customTileBorderColorHue" value="0" />
    <int name="ScreenWidth" value="1920" />
    <string name="0dcFont">Default</string>
    <string name="TilesRow1"></string>
    <string name="TilesRow3"></string>
    <string name="1217646AppList">acr.browser.barebones</string>
    <int name="TilesRow1TileHeight" value="128" />
    <int name="TilesRow5Height" value="140" />
    <int name="launchStatus" value="16" />
    <int name="customTileBorderColorSaturation" value="60" />
    <string name="mainAppDraw_gridview_textsize">Medium</string>
    <int name="TilesRow3Height" value="170" />
</map>

EOF
uid=`dumpsys package $package | /system/bin/busybox grep "userId" | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox cut -d " " -f 1`
/system/bin/busybox chown -R $uid:$uid /data/data/$package
/system/bin/busybox chmod 660 /data/data/$package/shared_prefs/*.xml
restorecon -FR /data/data/$package

pm grant $package android.permission.READ_EXTERNAL_STORAGE
am force-stop $package

####### Ativa a Launcher Install
### para quem ja tiver a launcher só força o setting
cmd package set-home-activity "launcher.offline/dxidev.toptvlauncher2.HomeActivity"
## necessário para chamar a launcher para a frente
#am start --user 0 -a android.intent.action.MAIN launcher.offline/dxidev.toptvlauncher2.HomeActivity



# ### para quem ja tiver a launcher só força o setting
# cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
# ## necessário para chamar a launcher para a frnte
# am start --user 0 -a android.intent.action.MAIN dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity






