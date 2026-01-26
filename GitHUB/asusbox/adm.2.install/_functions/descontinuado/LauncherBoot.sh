###############################################################################################################################
function LauncherBoot () {
while [ 1 ]; do
    echo "Download do wait allert para users"
    $wget -N --no-check-certificate -P $www http://personaltecnico.net/Android/AsusBOX/A1/www/boot.webp #> $wgetLog 2>&1
    if [ $? = 0 ]; then break; fi;
    sleep 1;
done;
# carrega a launcher oficial
package="dxidev.toptvlauncher2"
file=/data/data/$package/shared_prefs/PREFERENCE_DATA.xml
if [ ! -d /data/data/$package/shared_prefs ];then
    mkdir -p /data/data/$package/shared_prefs
fi
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <int name="horizontalScrollView_AlignLeft_R1" value="0" />
    <int name="TilesRow5TileHeight" value="140" />
    <int name="TilesRow2Visible" value="0" />
    <int name="PickColorHue" value="230" />
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
    <int name="TilesRow3TileHeight" value="170" />
    <int name="RandomInt" value="887" />
    <int name="NumberofAppDrawerColumns" value="3" />
    <int name="TilesRow4Height" value="110" />
    <int name="p_LastFocusedItem" value="529646" />
    <int name="horizontalScrollView_AlignLeft_R4" value="0" />
    <int name="ShowTTLSettingsRequiresPIN" value="1" />
    <int name="customTileBorderColorValue" value="64" />
    <string name="LinearTilesRowGravity_Row2">Center</string>
    <string name="SetWallpaperMethod">method3</string>
    <string name="TilesRow2"></string>
    <int name="customTileBorderColorAlpha" value="255" />
    <int name="TilesRow1Height" value="129" />
    <string name="wallpaper_location">$www/boot.webp</string>
    <int name="TilesRow3Visible" value="0" />
    <int name="horizontalScrollView_AlignLeft_R2" value="0" />
    <int name="UserHasOpenedEditLayout" value="1" />
    <int name="ShowAndroidSettingsRequiresPIN" value="0" />
    <string name="SettingsList"></string>
    <int name="ScreenWidth" value="1920" />
    <int name="customTileBorderColorHue" value="0" />
    <string name="0dcFont">Default</string>
    <string name="TilesRow1"></string>
    <string name="TilesRow3"></string>
    <int name="TilesRow1TileHeight" value="128" />
    <int name="TilesRow5Height" value="140" />
    <int name="launchStatus" value="16" />
    <int name="customTileBorderColorSaturation" value="60" />
    <string name="mainAppDraw_gridview_textsize">Medium</string>
    <int name="TilesRow3Height" value="170" />
</map>
EOF

# extrai na hora o numero de id do users permissions
while [ 1 ]; do
	uid=`dumpsys package $package | $grep "userId" | $cut -d "=" -f 2 | $cut -d " " -f 1`
	if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
	sleep 1;
done;
#echo $uid # debug verificar o numero do usuario
# applicar a permissão
$chown -R $uid:$uid /data/data/$package
$chmod 660 /data/data/$package/shared_prefs/*.xml
restorecon -FR /data/data/$package
}

