

if [ -f /data/asusbox/fullInstall ]; then

    # chama a launcher final pq o cara ja esta com tudo instalado
    # a funçao launcherList desativa a launcher official
    pm enable dxidev.toptvlauncher2
    cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    if [ ! -f /data/asusbox/LauncherLock ]; then
        # abre a launcher oficial caso a box esteja em boot direto da energia
        # preciso forçar trazer a launcher para frente caso a box tenha ficado sem internet no boot a launcher offline esta na frente
        am start --user 0 -a android.intent.action.MAIN dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity
    fi
fi

USBLOGCALL="if launcher official start"
OutputLogUsb

