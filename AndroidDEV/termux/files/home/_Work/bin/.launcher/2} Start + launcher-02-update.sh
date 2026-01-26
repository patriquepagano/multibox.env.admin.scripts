#!/system/bin/sh

clear
# am force-stop launcher.offline
# am force-stop dxidev.toptvlauncher2
    
# launcher de update quando todos os apps OEM que funcionam com qualidade estao disponiveis
# enquanto isto a box esta atualizando os apps clone
pm enable launcher.offline
"/data/asusbox/.sc/boot/launcher-02-update.sh"
am start -a android.intent.action.MAIN -c android.intent.category.HOME
pm disable dxidev.toptvlauncher2


