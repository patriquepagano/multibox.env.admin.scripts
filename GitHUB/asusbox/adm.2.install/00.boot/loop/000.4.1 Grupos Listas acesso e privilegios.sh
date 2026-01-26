# Box privilégios de admin
# vai liberar ssh server
# instalar git env 
BoxListADMIN="
rk30sdk=c1b6f2cf4d3908f4 > DevBox 101 camp
rk30sdk=eebf1d74a9420b09 > tvbox 102 roda debugs
rk30sdk=90e49e092c39962b > DevBox 03 105
"

# Box privilégios para BoxListBetaInstallers
# neste grupo tem acesso ao root e vai instalar apps de nivel para install e debug de apps
# quem participa deste grupo não sera desistalado apps adicionais aplicados por fora do sistema
# se a box for um user BoxListBetaInstallers não limpa arquivos cache antigos
# se a box for de um user BoxListBetaInstallers não sera apagado apks no sdcard
# se a box tiver privilégios de BoxListBetaInstallers vai liberar o acesso ao Mixplorer
BoxListBetaInstallers="
rk30sdk=c1b6f2cf4d3908f4 > DevBox 101 camp
rk30sdk=eebf1d74a9420b09 > tvbox 102 roda debugs
rk30sdk=0939e83b9192a6b6 > Box do anibal
"

# lista para box que não desligam o syncthing
BoxListSyncthingAlwaysOn="
rk30sdk=c1b6f2cf4d3908f4 > DevBox 101
rk30sdk=90e49e092c39962b > DevBox 03 105
rk30sdk=0939e83b9192a6b6 > Box do anibal
"


# Box privilégios para amigos e familiares
# neste grupo terão acesso antecipado a apps ou algo que queira testar para eles
BoxListBetaTesters="
rk30sdk=59badad48985f996 > Box do Gil
"

# Box privilégios para Resellers ainda sem uso
BoxListResellers="
rk30sdk=90e49e092c39962b > DevBox 03
rk30sdk=0939e83b9192a6b6 > Box do anibal
"


if echo "$BoxListBetaInstallers" | grep -q "$Placa=$CpuSerial"; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Acesso com privilégios BoxListBetaInstallers"
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG     enable root mode e folder sh.dev"
    mkdir -p "/data/trueDT/peer/BOOT/sh.dev"
    busybox mount -o remount,rw /system
    busybox rm /system/.pin > /dev/null 2>&1
    busybox mount -o remount,ro /system
    ###
    # Desativando a instalação de telegram temporarimente e kodi nada disto para o anibal
    ###
    # if ! ls /data/app/ | grep -q "telegram"; then
    #     echo "ADM DEBUG ########################################################"
    #     echo "ADM DEBUG ### Instalando telegram"
    #     echo "ADM DEBUG ########################################################"
    #     link="https://telegram.org/dl/android/apk"
    #     /system/bin/wget --no-check-certificate --timeout=11 --tries=11 -O /data/local/tmp/base.apk "$link" 2>&1
    #     pm install -r /data/local/tmp/base.apk
    #     rm /data/local/tmp/base.apk
    # fi
    # if ! ls /data/app/ | grep -q "org.xbmc.kodi"; then
    #     link="https://mirrors.kodi.tv/releases/android/arm/kodi-21.2-Omega-armeabi-v7a.apk"
    #     /system/bin/wget --no-check-certificate --timeout=11 --tries=11 -O /data/local/tmp/base.apk "$link" 2>&1
    #     pm install -r /data/local/tmp/base.apk
    #     du -hs /data/local/tmp/base.apk
    # fi
fi

if echo "$BoxListADMIN" | grep -q "$Placa=$CpuSerial"; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Acesso com privilégios BoxListADMIN"
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG     enable folder sh.admin"
    mkdir -p "/data/trueDT/peer/BOOT/sh.admin"
fi



