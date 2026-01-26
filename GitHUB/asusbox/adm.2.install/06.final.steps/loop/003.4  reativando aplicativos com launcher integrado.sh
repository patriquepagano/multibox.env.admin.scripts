
echo "Ativando aplicativos com Launcher, aguarde." > $bootLog 2>&1


LauncherList=`/system/bin/busybox cat /data/asusbox/LauncherList \
| /system/bin/busybox grep -v "dxidev.toptvlauncher2Tem-q-reativar-rom-antiga" \
| /system/bin/busybox sort \
| /system/bin/busybox uniq`

if [ ! -f /data/asusbox/LauncherLock ]; then
    if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
        # ativa os apps
        for loopL in $LauncherList; do
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### Ativando o app com launcher integrado > $loopL"
            #pm unhide $loopL # não é necessário para os apps launcher atual
            pm enable $loopL
        done
    fi
fi


        #     pm enable $loopL
        #     echo "ADM DEBUG ### o comando abaixo é para nem aparecer a oportunidade de trocar a launcher dos apps clone"        
        #     cmd package set-home-activity "launcher.offline/dxidev.toptvlauncher2.HomeActivity"
        # done


#         # ultimo da lista para ser o atual em uso
#         #pm unhide dxidev.toptvlauncher2 # não é necessário para os apps launcher atual
#         pm enable dxidev.toptvlauncher2
#         cmd package set-cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"

#         echo "ADM DEBUG ########################################################"
#         echo "ADM DEBUG ### Alternando para launcher online final"
#         # ativando a launcher final de uso online, onde se bota os icones e apps finais 
#         #/data/asusbox/.sc/OnLine/launcher-03-full.sh


# # fix de um antigo bug
# # package="dxidev.toptvlauncher2"
# # profile="launcher-03-full"
# # am force-stop $package
# # cp /data/data/$package/$profile.xml /data/data/$package/shared_prefs/PREFERENCE_DATA.xml

# cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
# #pm disable $package

#         if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
#             echo "ADM DEBUG ########################################################"
#             echo "ADM DEBUG ### fechando a launcher offline"
#             am force-stop launcher.offline
#             # if [ ! -f /data/asusbox/LauncherLock ]; then
#             #     # abre a launcher oficial caso a box esteja em boot direto da energia
#             #     am start --user 0 -a android.intent.action.MAIN dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity
#             # fi
#         fi    



USBLOGCALL="reenable launcher apps step"
OutputLogUsb



