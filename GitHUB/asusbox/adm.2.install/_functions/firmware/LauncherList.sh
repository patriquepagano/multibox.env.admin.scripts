function LauncherList () {
if [ "$LauncherIntegrated" == "yes" ]; then
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### adicionado a lista de aplicativos com launcher"
    #pm hide $app # não é necessário para os apps launcher atual
    if [ ! -f /data/asusbox/LauncherLock ]; then
        # nova politica de não desativar mais a launcher online official
        if [ ! "$app" == "dxidev.toptvlauncher2" ]; then
            pm disable $app
        fi
    fi
    echo "$app" >> /data/asusbox/LauncherList
fi
}

