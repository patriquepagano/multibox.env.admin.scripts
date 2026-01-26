
function CheckMacLanClone () {
MacLanClone=`/system/bin/busybox ifconfig \
| /system/bin/busybox grep eth0 \
| /system/bin/busybox grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' \
| /system/bin/busybox tr 'A-F' 'a-f'`
}

CheckMacLanClone

# antigo mac em uso > EC:2C:E9:C1:03:A2 
# antigo mac em uso setembro > EC:2C:CB:71:20:99
# novo mac para aplicar em outubro > EC:22:98:51:00:08
# novo mac para aplicar em dezembro >  D0:76:6C:11:02:B9
# novo mac para aplicar em abril 2024 > D0:76:6C: 31:0C:49
# novo mac julho  D0766C11045C / EC2CCD51377F / D0766C1100CF
# novo mac julho 11/07 > d0:76:6c: 31:00:40
# novo mac dezembro dia 10 2025 > 9c:00:d3:cc:84:3f

if [ ! "$MacLanClone" == "9c:00:d3:cc:84:3f" ]; then
    export MacLanReal=`/system/bin/busybox ifconfig | /system/bin/busybox grep eth0 | /system/bin/busybox awk '{ print $5 }'`
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### ativando mac oficial para emulação clone"
    am force-stop com.valor.mfc.droid.tvapp.generic
    #/data/asusbox/.sc/OnLine/mac.sh # descontinuado remover do pack local
    /system/bin/busybox ifconfig eth0 down
    /system/bin/busybox ifconfig eth0 hw ether 9c:00:d3:cc:84:3f
    /system/bin/busybox ifconfig eth0 up
    while [ 1 ]; do
        CheckMacLanClone
        echo "ADM DEBUG ###########################################################"
        echo "ADM DEBUG ### aguardando receber novo mac na interface Lan"
        echo "Mac atual > $MacLanClone"
        if [ "$MacLanClone" = "9c:00:d3:cc:84:3f" ]; then break; fi;
        sleep 1;
    done;
    # gera o arquivo marcador para o chaveamento se este arquivo for sobreescrito duas vezes detona o chaveamento
    # este sistema de filemark para mac não funciona! descontinuar o uso desta tranqueira
    if [ ! -f /data/macLan.hardware ]; then        
        echo -n $MacLanReal > /data/macLan.hardware
    fi
else
    export MacLanReal=`/system/bin/busybox cat /data/macLan.hardware`
fi


# necessario para aguardar se recebeu o ip do dhcp server
echo "ADM DEBUG ###########################################################"
echo "ADM DEBUG ### aguardando receber algum ip para interface"
while [ 1 ]; do
    CheckIPLocal
    if [ ! "$IPLocal" = "" ]; then break; fi;
    sleep 1;
done;

export IPLocalAtual="$IPLocal"
export MacWiFiReal=`/system/bin/busybox ifconfig | /system/bin/busybox grep wlan0 | /system/bin/busybox awk '{ print $5 }'`

