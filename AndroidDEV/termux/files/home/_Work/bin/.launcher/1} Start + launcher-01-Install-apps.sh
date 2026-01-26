#!/system/bin/sh

clear
# am force-stop launcher.offline
# am force-stop dxidev.toptvlauncher2
    

# Launcher do primeiro boot install quando não se tem nada dentro da box
pm enable launcher.offline
"/data/asusbox/.sc/boot/launcher-01-Install-apps.sh"
am start -a android.intent.action.MAIN -c android.intent.category.HOME
pm disable dxidev.toptvlauncher2


