#!/system/bin/sh

# Simular o ultimo estado da box apos o carregamento total

LauncherList=`/system/bin/busybox cat /data/asusbox/LauncherList \
| /system/bin/busybox grep -v "dxidev.toptvlauncher2" \
| /system/bin/busybox sort \
| /system/bin/busybox uniq`
# ativa os apps
for loopL in $LauncherList; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Ativando o app com launcher integrado > $loopL"
    # pm unhide $loopL
    pm enable $loopL
done
# ultimo da lista para ser o atual em uso
#pm unhide dxidev.toptvlauncher2
pm enable dxidev.toptvlauncher2


"/storage/DevMount/GitHUB/asusbox/adm.build/OnLine/launcher-03-full.sh"
# ## necessário para chamar a launcher para a frnte
am start --user 0 -a android.intent.action.MAIN dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity




