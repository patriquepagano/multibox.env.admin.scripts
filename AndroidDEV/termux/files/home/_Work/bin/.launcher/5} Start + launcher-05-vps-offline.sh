#!/system/bin/sh

clear

# launcher Offline quando o cliente não tem internet ou estiver na praia ou no campo
pm enable launcher.offline
"/data/asusbox/.sc/OnLine/launcher-05-vps-offline.sh"
am start -a android.intent.action.MAIN -c android.intent.category.HOME
pm disable dxidev.toptvlauncher2

