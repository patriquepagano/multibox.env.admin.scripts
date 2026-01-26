#!/system/bin/sh

clear
am force-stop launcher.offline
am force-stop dxidev.toptvlauncher2
    
# # Launcher do primeiro boot install quando não se tem nada dentro da box
# /data/asusbox/adm.build/boot/launcher-01-Install-apps.sh
# # am force-stop launcher.offline
# # am force-stop dxidev.toptvlauncher2
# am start -a android.intent.action.MAIN -c android.intent.category.HOME
# sleep 5

# # launcher de update quando todos os apps OEM que funcionam com qualidade estao disponiveis
# # enquanto isto a box esta atualizando os apps clone
# /data/asusbox/adm.build/boot/launcher-02-update.sh
# # am force-stop launcher.offline
# # am force-stop dxidev.toptvlauncher2
# am start -a android.intent.action.MAIN -c android.intent.category.HOME
# sleep 5

# # launcher quando estiver todos apps clone atualizados e configurados
# /data/asusbox/adm.build/OnLine/launcher-03-full.sh
# # am force-stop launcher.offline
# # am force-stop dxidev.toptvlauncher2
# am start -a android.intent.action.MAIN -c android.intent.category.HOME
# sleep 5

# launcher Offline quando o cliente não tem internet ou estiver na praia ou no campo
/data/asusbox/adm.build/OffLine/launcher-04-offline.sh
# am force-stop launcher.offline
# am force-stop dxidev.toptvlauncher2
am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 5

# Launcher quando sistema estiver em atualização ou problemas no amazon ou vps
/data/asusbox/adm.build/OnLine/launcher-05-vps-offline.sh
# am force-stop launcher.offline
# am force-stop dxidev.toptvlauncher2
am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 5


