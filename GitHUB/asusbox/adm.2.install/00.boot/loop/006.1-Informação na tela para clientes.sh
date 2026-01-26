#/data/asusbox/.sc/boot/menu/0.readLog/install.sh

cfg='<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<map>
    <boolean name="do_path_extensions" value="true" />
    <string name="fontsize">28</string>
    <boolean name="mouse_tracking" value="false" />
    <string name="statusbar">0</string>
    <string name="ime">0</string>
    <string name="actionbar">2</string>
    <boolean name="verify_path" value="true" />
    <string name="backaction">2</string>
    <boolean name="use_keyboard_shortcuts" value="false" />
    <boolean name="allow_prepend_path" value="true" />
    <boolean name="utf8_by_default" value="true" />
    <boolean name="close_window_on_process_exit" value="true" />
    <string name="color">5</string>
    <boolean name="alt_sends_esc" value="false" />
    <string name="shell">/system/bin/sh -</string>
    <string name="fnkey">4</string>
    <string name="controlkey">5</string>
    <string name="initialcommand">/data/data/jackpal.androidterm/app_HOME/menu.sh</string>
    <string name="home_path">/data/user/0/jackpal.androidterm/app_HOME</string>
    <string name="orientation">0</string>
    <string name="termtype">screen-256color</string>
</map>
'

file="/data/data/jackpal.androidterm/shared_prefs/jackpal.androidterm_preferences.xml"
check=$(cat "$file")

# Remove espaços em branco para uma comparação precisa
cfg_clean=$(echo "$cfg" | tr -d '[:space:]')
check_clean=$(echo "$check" | tr -d '[:space:]')

if [ "$check_clean" != "$cfg_clean" ]; then
    echo "Update preferences"
    echo "$cfg" > "$file"
fi



file="/data/data/dxidev.toptvlauncher2/shared_prefs/PREFERENCE_DATA.xml"
if [ -f "$file" ]; then
    if [ -z "$(cat "$file" | grep jackpal.androidterm)" ]; then
        echo "fixing"
        busybox sed -i 's;<string name="1588646AppList">.*</string>;<string name="1588646AppList">jackpal.androidterm</string>;g' "$file"
        pm enable jackpal.androidterm
        am force-stop dxidev.toptvlauncher2
    fi

fi


busybox cat <<'EOF' > "/data/data/jackpal.androidterm/app_HOME/menu.sh"
function readLog() {
    /system/bin/busybox cat "${0%/*}/log.txt"
}
trap 'echo "Restart system"; sleep 1' SIGINT
while true; do
    sleep 1
    clear
    readLog
done
EOF


export bootLog="/data/data/jackpal.androidterm/app_HOME/log.txt"

if [ ! -f /data/asusbox/fullInstall ]; then
    pm enable jackpal.androidterm
        if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
            echo "Aguarde atualizando Sistema" > $bootLog
            chmod 777 $bootLog

            am force-stop jackpal.androidterm
            am start --user 0 \
            -n jackpal.androidterm/.Term \
            -a android.intent.action.VIEW 
        fi
fi












# echo "pausa dramatica! cancela ai o script"
# read bah
# sleep 900


# # tvbox tete
# if [ "$CpuSerial" == "9a264f47c9de4541" ]; then
#     while [ 1 ]; do
#         echo "ADM DEBUG ########################################################"
#         echo "ADM DEBUG ### abrindo navegador exibir log instalação"
#         am force-stop acr.browser.barebones
#         am start --user 0 \
#         -n acr.browser.barebones/acr.browser.lightning.MainActivity \
#         -a android.intent.action.VIEW -d "http://127.0.0.1:9091" > /dev/null 2>&1
#         if [ $? = 0 ]; then break; fi;
#         sleep 1
#     done;
# fi


