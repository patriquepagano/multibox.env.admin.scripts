function acr.browser.barebones.set.config () {
FileXML="/data/data/acr.browser.barebones/shared_prefs/acr.browser.barebones_preferences.xml"
if [ ! -f "$FileXML"  ]; then
mkdir -p /data/data/acr.browser.barebones/shared_prefs
/system/bin/busybox cat <<EOF > "$FileXML"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="fullScreenOption" value="true" />
    <boolean name="cb_images" value="false" />
    <boolean name="cb_javascript" value="true" />
    <boolean name="clear_webstorage_exit" value="true" />
    <boolean name="password" value="true" />
    <boolean name="cb_drawertabs" value="true" />
    <boolean name="remove_identifying_headers" value="false" />
    <boolean name="clear_cookies_exit" value="false" />
    <boolean name="allow_cookies" value="true" />
    <boolean name="cb_ads" value="false" />
    <boolean name="allow_new_window" value="true" />
    <boolean name="third_party" value="false" />
    <boolean name="clear_history_exit" value="false" />
    <boolean name="restore_tabs" value="false" />
    <boolean name="cb_swapdrawers" value="false" />
    <boolean name="do_not_track" value="false" />
    <boolean name="location" value="false" />
    <boolean name="cb_flash" value="false" />
    <boolean name="incognito_cookies" value="false" />
    <boolean name="black_status_bar" value="true" />
    <boolean name="fullscreen" value="true" />
    <boolean name="clear_cache_exit" value="true" />
    <boolean name="text_reflow" value="false" />
    <boolean name="wideViewPort" value="true" />
    <boolean name="overViewMode" value="true" />
    <boolean name="cb_colormode" value="true" />
</map>

EOF
fi

FileXML="/data/data/acr.browser.barebones/shared_prefs/settings.xml"
if [ -z "$(cat $FileXML | grep 9091)" ]; then
/system/bin/busybox cat <<EOF > "$FileXML"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="blackStatusBar" value="true" />
    <int name="enableflash" value="0" />
    <boolean name="cache" value="true" />
    <boolean name="restoreclosed" value="false" />
    <boolean name="clearWebStorageExit" value="true" />
    <boolean name="hidestatus" value="true" />
    <int name="Theme" value="1" />
    <string name="home">http://127.0.0.1:9091</string>
</map>

EOF
fi

/system/bin/busybox chmod 660 /data/data/acr.browser.barebones/shared_prefs/*.xml
app="acr.browser.barebones"
FixPerms
# echo "ADM DEBUG ########################################################"
# echo "ADM DEBUG ### abre o navegador pela primeira vez"
# monkey -p $app -c android.intent.category.LAUNCHER 1


}





