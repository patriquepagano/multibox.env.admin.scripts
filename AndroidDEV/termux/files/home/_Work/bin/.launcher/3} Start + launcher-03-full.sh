#!/system/bin/sh

clear
# am force-stop launcher.offline
# am force-stop dxidev.toptvlauncher2
    
# launcher quando estiver todos apps clone atualizados e configurados
pm enable dxidev.toptvlauncher2
"/data/asusbox/.sc/OnLine/launcher-03-full.sh"
am start -a android.intent.action.MAIN -c android.intent.category.HOME
pm disable launcher.offline

