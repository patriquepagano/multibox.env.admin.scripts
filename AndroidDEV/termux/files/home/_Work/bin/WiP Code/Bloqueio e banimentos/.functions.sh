#!/system/bin/sh

BB="busybox"

UnHideApp () {
if dumpsys package "$PKG" | $BB grep -q "hidden=true"; then
    echo "Ativando $PKG"
    pm unhide "$PKG" 2>/dev/null
fi
}

ACRInfo () {
# caso o navegador esteja na tela precisa ser fechado para carregar novo url
am force-stop acr.browser.barebones
mkdir -p /data/local/tmp
echo -n "$ACRURL" > /data/local/tmp/URL
sh="/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/WiP Code/Bloqueio e banimentos/x - watchdog web allert.sh"
#sh "$sh" skip & > /dev/null 2>&1
sh "$sh" skip > /dev/null 2>&1 &
}

ACRInfoDisable () {
rm /data/local/tmp/URL
am force-stop acr.browser.barebones
}

DisablePriorityApps () {
# Apps to check, e desativar com prioridade
PKGS="
dxidev.toptvlauncher2
com.android.settings
com.android.tv.settings
com.android.vending
com.mixplorer
com.android.documentsui
"
for PKG in $PKGS; do
    # Check if the package is hidden
    if dumpsys package "$PKG" | $BB grep -q "hidden=false"; then
        echo "Desativando $PKG"
        pm hide "$PKG" >/dev/null 2>&1
    fi
done
}

disableAllApps () {
# Get installed packages
pm list packages -3 -e | sed 's/package://g' | while read -r PKG; do
  # Skip empty lines
  [ -z "$PKG" ] && continue
  echo "Desativando $PKG"
  pm hide "$PKG" >/dev/null 2>&1
done
}

EnableAppsExclusions () {
WHITELIST="/data/local/tmp/APPList"
mkdir -p /data/local/tmp

find /data/data -maxdepth 1 -type d \
    | busybox sed 's#.*/##' \
    | busybox grep -Ev '^(com.android.vending|com.mixplorer|android|data|local|dxidev.toptvlauncher2)$' \
    | busybox sort > "$WHITELIST"
#cat $WHITELIST | busybox sort

while read -r PKG; do
    echo "Analizando $PKG"
    UnHideApp
    # if dumpsys package "$PKG" | busybox grep -q "hidden=true"; then
    #     echo "Ativando $PKG"
    #     pm unhide "$PKG" 2>/dev/null
    # fi
done < "$WHITELIST"
}

EnablePriorityApps () {
# Apps to check, in the required order
PKGS="
com.android.documentsui
com.android.settings
com.android.tv.settings
dxidev.toptvlauncher2
"
for PKG in $PKGS; do
    echo "Analizando priority app = $PKG"
    UnHideApp
    # # Check if the package is hidden
    # if dumpsys package "$PKG" | $BB grep -q "hidden=true"; then
    #     echo "Ativando $PKG"
    #     pm unhide "$PKG" 2>/dev/null
    # fi
done
}


EnablePriorityAppsAdminOnly () {
# Apps to check, in the required order
PKGS="
dxidev.toptvlauncher2
com.android.settings
com.android.tv.settings
com.android.vending
com.mixplorer
com.android.documentsui
"
for PKG in $PKGS; do
    echo "Analizando priority app = $PKG"
    UnHideApp
    # # Check if the package is hidden
    # if dumpsys package "$PKG" | $BB grep -q "hidden=true"; then
    #     echo "Ativando $PKG"
    #     pm unhide "$PKG" 2>/dev/null
    # fi
done
}




LauncherOnTop () {
app="dxidev.toptvlauncher2"
monkey -p $app -c android.intent.category.LAUNCHER 1
}

