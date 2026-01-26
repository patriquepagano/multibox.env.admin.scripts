#!/system/bin/sh

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/000.0.0-phpSignin-CheckIPLocal.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# checkup do script para saber se é nosso para rodar
if [ "$1" == "675asd765da4s567f4asd4f765ads4f675a4ds6f754ads6754fa657ds4f675ads467f5ads" ]; then
    echo "Certified.BOOT"
    exit
fi


function CheckIPLocal () {
WlanIP=`/system/bin/busybox ip addr show wlan0 \
| /system/bin/busybox grep "inet " \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox cut -d "/" -f 1 \
| /system/bin/busybox head -1`

LanIP=`/system/bin/busybox ip addr show eth0 \
| /system/bin/busybox grep "inet " \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox cut -d "/" -f 1 \
| /system/bin/busybox head -1`

# echo "Lista de IPs
# Se o IP da wlan não estiver disponivel pega o da lan
# WlanIP  $WlanIP
# LanIP   $LanIP
# "
if [ "$LanIP" == "" ]; then
    export IPLocal="$WlanIP"
else
    export IPLocal="$LanIP"
fi
}


# IPLocal=`/system/bin/busybox ifconfig \
# | /system/bin/busybox grep -v 'P-t-P' \
# | /system/bin/busybox grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
# | /system/bin/busybox grep -Eo '([0-9]*\.){3}[0-9]*' \
# | /system/bin/busybox grep -v '127.0.0.1' \
# | /system/bin/busybox head -3`

echo "ADM DEBUG ###########################################################"
echo "ADM DEBUG ### aguardando receber algum ip para interface"
while [ 1 ]; do
    CheckIPLocal
    if [ ! "$IPLocal" = "" ]; then break; fi;
    sleep 1;
done;


echo "primeiro try IPlocal"
CheckIPLocal

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/000.1.1-phpSignin-Mac.lan.clone-descontinuar-em-breve.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


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

if [ ! "$MacLanClone" == "d0:76:6c:31:00:40" ]; then
    export MacLanReal=`/system/bin/busybox ifconfig | /system/bin/busybox grep eth0 | /system/bin/busybox awk '{ print $5 }'`
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### ativando mac oficial para emulação clone"
    am force-stop com.valor.mfc.droid.tvapp.generic
    #/data/asusbox/.sc/OnLine/mac.sh # descontinuado remover do pack local
    /system/bin/busybox ifconfig eth0 down
    /system/bin/busybox ifconfig eth0 hw ether d0:76:6c:31:00:40
    /system/bin/busybox ifconfig eth0 up
    while [ 1 ]; do
        CheckMacLanClone
        echo "ADM DEBUG ###########################################################"
        echo "ADM DEBUG ### aguardando receber novo mac na interface Lan"        
        echo "Mac atual > $MacLanClone"
        if [ "$MacLanClone" = "d0:76:6c:31:00:40" ]; then break; fi;        
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

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/000.1.2-phpSignin-clock-update.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



# Obrigatório setar isto SEMPRE quando a box liga pela primeira vez
# cmd > settings get global ntp_server = 1.7seconds to complete
echo "ADM DEBUG ##############################################################################"
echo "ADM DEBUG ### atenção ntp client usa porta udp bloqueada por algums net providers"
if [ ! -e /data/asusbox/crontab/LOCK_cron.updates ]; then
    settings put global ntp_server a.st1.ntp.br 
	settings put global auto_time 0
	settings put global auto_time 1
fi

function ClockUpdateNow () {
echo "ADM DEBUG ########################################################################################"
echo "ADM DEBUG ### Micro serviço worldtimeapi.org funciona sem garantias criar meu proprio self hosted"

# variaveis de data unix epoch
dateOld="1630436299" # dia que foi feito este script
dateNew=`date +%s` # data atual no momento do boot

# comparar a data local da box com unix if update via proxy time
# if [ "3" -gt "1" ];then
if [ ! -d /data/trueDT/peer/Sync ]; then
    mkdir -p /data/trueDT/peer/Sync
fi
if [ "$dateOld" -gt "$dateNew" ];then
FileMark="/data/trueDT/peer/Sync/udp.clock.blocked.by.isp.v2.live"
busybox cat <<EOF > $FileMark
date from local gateway = $(date +"%d/%m/%Y %H:%M:%S")
EOF
    echo "ADM DEBUG ##############################################################################"
    echo "ADM DEBUG ### atualizando horário a partir do clock server"
    echo "ADM DEBUG ### Microserviço funciona sem garantias o unico ate agora 21/03/2022"
    TZ=UTC−03:00
    export TZ
    echo "ADM DEBUG ##############################################################################"
    echo "ADM DEBUG ### abre url temporária do telegram informando sobre o bug do relógio"
    ACRURL="https://telegra.ph/Entre-em-contato-com-o-suporte-03-20"
    acr.browser.barebones.launch
    echo "ADM DEBUG ##############################################################################"
    echo "ADM DEBUG ### TRAVA EM LOOP ATE CONSEGUIR O HORARIO"
    echo "ADM DEBUG ### PODE DEIXAR AS BOX PARADAS"
	while [ 1 ]; do
		export CheckCurl=`/system/bin/curl "http://worldtimeapi.org/api/timezone/America/Sao_Paulo"`
		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
		sleep 3;
	done;    
    datetime=`echo -n "$CheckCurl" | busybox cut -d ',' -f 3 | busybox cut -d '"' -f 4 | busybox cut -d '"' -f 1`
    timezone=`echo -n "$CheckCurl" | busybox cut -d ',' -f 11 | busybox cut -d '"' -f 4 | busybox cut -d '"' -f 1`
    unixtime=`echo -n "$CheckCurl" | busybox cut -d ',' -f 12 | busybox cut -d ':' -f 2`
    /system/bin/busybox date -s "@$unixtime"
busybox cat <<EOF >> $FileMark
date from world api = $datetime
$timezone
$unixtime
EOF
am force-stop acr.browser.barebones
fi

}


# -eq # equal
# -ne # not equal
# -lt # less than
# -le # less than or equal
# -gt # greater than
# -ge # greater than or equal



# desativado pq não funciona! aguardando novo metodo
# comparar a data local da box com unix if update via proxy time
#if [ "3" -gt "1" ];then
# if [ "$dateOld" -gt "$dateNew" ];then
#     echo "ADM DEBUG ##############################################################################"
#     echo "ADM DEBUG ### atualizando horário a partir do clock server"
#     TZ=UTC−03:00
#     export TZ
#     url="https://time.is/pt_br/Unix_time_converter"
#     curl -ko /data/local/tmp/getTime $url
#     epochDate=`/system/bin/busybox cat /data/local/tmp/getTime | /system/bin/busybox grep 'id="unix_time" value="' | /system/bin/busybox cut -d '"' -f 8`
#     /system/bin/busybox date -s "@$epochDate"
#     rm /data/local/tmp/getTime
# fi


# precisa deixar linhas em branco abaixo para a funçao


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/000.1.3-phpSignin-geolocalization.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function GetGeoLocalization () {
    # https://ipinfo.io/
    # https://iplocality.com/
    # https://ipapi.co/#pricing
    # https://ipregistry.co/
    link='https://ipinfo.io'
    # funciona e baixa a pagina inteira mas não tem os dados de geolocation
    # CheckCurl=`/system/bin/curl --silent -w "%{http_code}" -k -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36" "$link" -L`
    CheckCurl=`/system/bin/curl --silent -w "%{http_code}" -k $link -L`
    export httpCode=`echo "$CheckCurl" | busybox grep "}" | busybox cut -d "}" -f 2`
    export ip=`echo -n "$CheckCurl" | busybox grep "ip" | busybox cut -d '"' -f 4 | busybox head -1`
    export country=`echo -n "$CheckCurl" | busybox grep "country" | busybox cut -d '"' -f 4 | busybox head -1`
    export region=`echo -n "$CheckCurl" | busybox grep "region" | busybox cut -d '"' -f 4 | busybox head -1`
    export city=`echo -n "$CheckCurl" | busybox grep "city" | busybox cut -d '"' -f 4 | busybox head -1`
    export hostname=`echo -n "$CheckCurl" | busybox grep "hostname" | busybox cut -d '"' -f 4 | busybox head -1`
    export org=`echo -n "$CheckCurl" | busybox grep "org" | busybox cut -d '"' -f 4 | busybox head -1`
    if [ ! -d /data/trueDT/peer/Sync ]; then
        mkdir -p /data/trueDT/peer/Sync
    fi
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### IP GetGeoLocalization"
    echo "ADM DEBUG ### httpCode = $httpCode" 
    echo "ADM DEBUG ### $ip" 
    echo "ADM DEBUG ### $country"
    echo "ADM DEBUG ### $region"
    echo "ADM DEBUG ### $city"
    echo "ADM DEBUG ### $hostname"
    echo "ADM DEBUG ### $org"    
}

function WriteGeoLocalization () {
# se não existir requisita ao servidor o micro serviço
FileLog="/data/trueDT/peer/Sync/LocationGeoIP.v6.atual"
checkFileInfo=$(busybox cat $FileLog | busybox tr -d '\n')
if [ "$checkFileInfo" == "" ]; then
    # apaga para forçar um proximo request na proxima hora
    rm $FileLog
fi
if [ ! -f "$FileLog" ]; then
    for i in $(seq 1 7); do
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### call function > GetGeoLocalization"
        GetGeoLocalization
        if [ "$httpCode" = "200" ]; then break; fi;
        sleep 3;
    done;
    # fora do looping se não tiver sucesso encerra o script
    if [ ! "$httpCode" = "200" ]; then exit; fi;    
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### grava GeoLocalização"
	CheckIPLocal
    if [ ! "$ip$country$region$city$org$hostname" == "" ]; then
        echo "$IPLocal | $ip | $country | $region | $city | $org | $hostname" > "/data/trueDT/peer/Sync/LocationGeoIP.v6.atual"
    fi
fi
}

ExternalipLogged=$(busybox cat "/data/trueDT/peer/Sync/LocationGeoIP.v6.atual" | busybox awk -F'|' '{print $2}' | busybox tr -d '[:space:]')
GETipExternal=$(/system/bin/curl --silent http://canhazip.com)
if [ ! "$ExternalipLogged" == "$GETipExternal" ]; then
	WriteGeoLocalization
fi

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/000.1.6-phpSignin-VARs.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


SECONDS=0

#export bootLog="/dev/null"
export LogRealtime="/data/trueDT/peer/Sync/LogRealtime.live"

#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin

export Senha7z="6ads5876f45a9sdf7as975a87"
export Produto="asusbox"
export PHome="/data/$Produto"
export HOME="/data/$Produto"

if [ ! -d $PHome ] ; then
 mkdir -p $PHome
fi

if [ ! -d /data/trueDT/peer/chat ] ; then
mkdir -p /data/trueDT/peer/chat
fi

# # sempre escreve no boot o android id
# GetID=`settings get secure android_id` # puxa o ultimo id do android
# export ID=`cat /data/$Produto/android_id` # id variavel que muda no hard reset
# # compara para escrever apenas se mudou
# if [ ! "$GetID" = "$ID" ];then
# 	echo "novo id instalado"
# 	echo -n $GetID > /data/$Produto/android_id # escreve novo id
# 	export ID=`cat /data/$Produto/android_id` # carrega o novo id
# fi

# antigo id em uso = dc9c52898d8bcc99
# + box az original = 3573F9431ACC9AB1

# sempre escreve no boot o android id
GetID=`settings get secure android_id` # puxa o ultimo id do android
#export ID=`cat /data/$Produto/android_id` # id variavel que muda no hard reset
export ID="3573F9431ACC9AB1"
# compara para escrever apenas se mudou
if [ ! "$GetID" == "$ID" ]; then
	#echo "novo id instalado"
    settings put --user 0 secure android_id 3573F9431ACC9AB1
    echo -n $GetID > /data/$Produto/android_id_OLD # escreve novo id
	echo -n $ID > /data/$Produto/android_id # escreve novo id
	# export ID=`cat /data/$Produto/android_id` # carrega o novo id
fi

IDCheck=`cat /data/$Produto/android_id`
if [ ! "$IDCheck" == "$ID" ]; then
echo -n $ID > /data/$Produto/android_id # escreve novo id temporariamente
fi

# descontinuado isto não serve mais
# export UUID=`cat /system/UUID`
# if [ "$UUID" = "" ] ; then
# while [ 1 ]; do
#     echo "Baixando novo UUID"
# 	while [ 1 ]; do
# 		UUID=`/system/bin/curl "http://personaltecnico.net/Android/RebuildRoms/keyaccess.php"`
# 		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
# 		sleep 1;
# 	done;
# 	/system/bin/busybox mount -o remount,rw /system
# 	echo -n $UUID > /system/UUID
#     export UUID=`cat /system/UUID`
#      echo "Verificando UUID > $UUID"   
#     if [  "$UUID" = "" ];then
#         $?="1"	
#     fi
#     if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
#     sleep 1;
# done;
# fi
# export UUID=`/system/bin/busybox cat /system/UUID`


export ID=`/system/bin/busybox cat /data/$Produto/android_id`
export CPU=`getprop ro.product.cpu.abi | sed -e 's/ /_/g'`
export Modelo=`getprop ro.product.model`
export RomBuild=`getprop ro.build.description | sed -e 's/ /_/g'`

# informação variavel
export FirmwareVer=`busybox blkid | busybox sed -n '/system/s/.*UUID=\"\([^\"]*\)\".*/\1/p'`

export shellBin=`echo IyEvc3lzdGVtL2Jpbi9zaA== | /system/bin/busybox base64 -d`
export onLauncher="pm enable dxidev.toptvlauncher2"
export conf="/data/$Produto/.conf"
export www="$EXTERNAL_STORAGE/Android/data/$Produto/.www"
export systemLog="$www/system.log"
export wgetLog="$www/wget.log"

export wwwup="$EXTERNAL_STORAGE/Android/data/$Produto/.updates"
export fileUpdates="/data/$Produto/.updates"

# ver oque eu faço com estas variaveis
#export bootLog="/data/$Produto/boot.log"
export userLog="/data/$Produto/user.log"

export bootLog="/data/data/jackpal.androidterm/app_HOME/log.txt"


export PathSerial="/system/Serial"
export PathPin="/system/Pin"

export SupportLOG="$EXTERNAL_STORAGE/Adata.log"

# UNIQ DEVICE IDENTIFICATION
Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`
DeviceName="$Placa=$CpuSerial=$MacLanReal"



    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/000.3-.install-folder.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

# ☐ portabilizando a pasta install Show!!!!
#     - deixar o setup para o inicio não da! pq não tem interface para explicações
#     - gravar na /system/.install é uma péssima ideia! em menos de 3 messes todos os packs serão totalmente obsoletos e vai regravar tudo
#         * allwinner e varias box com uma partição system com mais de 2GB!!
#         * restore apos um hard-reset é muito rapido e atualizado!
#         + SEEDERS NA MARRA não tem como os clientes removerem o pendrive e parar de semear
#         + /system/.install inicia no firmware VAZIO! no primeiro connect com a rede baixa e enche o diretorio
#     + criar uma função para gerir a decisão do cache externo
#         - vai dar gente removendo o pendrive e o seed vai parar
#     + velocidade na gravação dos bin,libs e apps
#     + libera o data para apps
#     + criar um container dentro da /system/drive deixando 20% livre para uso do cliente, filmes ou jogos usar a memoria interna dele
#     + criar um if se a pasta existe $Drive/.install ele faz o symlink
#     ☐ definir quais etapas e funções
#         + is /data/asusbox/.install is monted ?
#         + check DevMount is present, mount .install
#         + check space target
#         + mount

mkdir -p /data/trueDT/www/.stfolder > /dev/null 2>&1
chmod -R 777 /data/trueDT/www
mkdir -p /data/trueDT/assets > /dev/null 2>&1
mkdir -p /data/trueDT/peer/Sync > /dev/null 2>&1

function .installAsusBOX-PC () {
    FolderPath="/storage/asusboxUpdate"
    UUID=`/system/bin/busybox blkid | /system/bin/busybox grep "ThumbDriveDEV" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2`
    if [ ! $UUID == "" ]; then    
        if [ ! -d $FolderPath ] ; then
            mkdir $FolderPath
            chmod 700 $FolderPath
        fi
        # montando o device
        #   /system/bin/busybox umount $FolderPath > /dev/null 2>&1
		check=`/system/bin/busybox mount | /system/bin/busybox grep "$FolderPath"`
		if [ "$check" == "" ]; then
			echo "ADM DEBUG ########################################################"
			echo "ADM DEBUG ### $FolderPath MONTANDO como pasta .install"
			/system/bin/busybox mount -t ext4 LABEL="ThumbDriveDEV" "$FolderPath"
		fi
        # Symlink
        rm /data/asusbox/.install > /dev/null 2>&1    
        /system/bin/busybox ln -sf $FolderPath/asusbox/.install /data/asusbox/
        InstallFolder="ENABLED"
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $FolderPath ativado como pasta .install"
    fi
}


# function .installSystem () {
#     FolderPath="/system/.install"
#     ### tamanho atual da pasta .install = 697512
#     #/system/bin/busybox du -s /storage/AsusBOX-PC/asusbox/.install | /system/bin/busybox cut -f1
#     SystemSpace=`/system/bin/busybox df | grep "/system" | /system/bin/busybox awk '/[0-9]%/{print $(NF-2)}'`
#     #if [ "$SystemSpace" -ge "75000000000000000000000" ];then # debug para não utilizar a system
#     if [ "$SystemSpace" -ge "750000" ];then        
#         if [ ! -d $FolderPath ] ; then
#             /system/bin/busybox mount -o remount,rw /system
#             # montando o device
#             mkdir $FolderPath
#             chmod 700 $FolderPath
#         fi
#         # Symlink
#         rm /data/asusbox/.install > /dev/null 2>&1    
#         /system/bin/busybox ln -sf $FolderPath /data/asusbox/.install
#         InstallFolder="ENABLED"
#         echo "ADM DEBUG ########################################################"
#         echo "ADM DEBUG ### $FolderPath ativado como pasta .install"   
#     fi
# }

function .installSDcard () {
        FolderPath="/storage/emulated/0/Download/AsusBOX-UPDATE"
        if [ ! -d $FolderPath ]; then
            export FolderPath="/data/trueDT/PackP2P"
            mkdir -p $FolderPath
            echo "FolderPath > $FolderPath"
        fi
        # Symlink
        rm /data/asusbox/.install > /dev/null 2>&1    
        /system/bin/busybox ln -sf $FolderPath /data/asusbox/.install
        InstallFolder="ENABLED"
}

function Check.installFolder () {
    Clink=`/system/bin/busybox readlink -v "/data/asusbox/.install"` > /dev/null 2>&1    
    # test if symlink is broken (by seeing if it links to an existing file)
    if [ ! -e "$Clink" ] ; then
        InstallFolder="DISABLED"
        echo "Symlink /data/.install esta desativado"
        if [ ! $InstallFolder == "ENABLED" ]; then
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### verificando se existe storage ext4 AsusBOX-PC"    
            .installAsusBOX-PC
        fi
        # desativado pq esta dando problemas
        # if [ ! $InstallFolder == "ENABLED" ]; then
        #     echo "ADM DEBUG ########################################################"
        #     echo "ADM DEBUG ### verificando se existe espaço na /system/.install" 
        #     .installSystem
        # fi
        if [ ! $InstallFolder == "ENABLED" ]; then
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### ativando a pasta install no SDCard" 
            .installSDcard
        fi
        Check.installFolder
    else
        InstallFolder="ENABLED"
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $InstallFolder = $Clink" 
    fi    
}

### Precisa apagar o symlink sempre no boot pois se tiver um usb storage vai puxar do mesmo
# verifica sem um pendrive AsusBOX-PC esta conectado e o utiliza como .install
# verifica se tem espaço na system e seta o diretorio como .install
# instala no sdcard em ultimo caso > /storage/emulated/0/Download/AsusBOX-UPDATE (assim o cliente pode apagar no futuro)
rm -rf /data/asusbox/.install
Check.installFolder

if [ ! -d /storage/emulated/0/Download/naoApagueUpdate ]; then
    busybox mkdir -p /storage/emulated/0/Download/naoApagueUpdate
    echo "56asd476a5sf5467da" > /storage/emulated/0/Download/naoApagueUpdate/setup.txt
fi


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/7ZextractDir.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function 7ZextractDir () {

if [ "$Senha7z" == "" ]; then
    Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
fi

eval $cmdCheck
rm /data/local/tmp/swap > /dev/null 2>&1
tmpUpdateF=/data/local/tmp/UpdateF

echo "ADM DEBUG #################################################################################"
echo "ADM DEBUG ########### $app | $FileName | $FileExtension ###################################"
echo "ADM DEBUG ########### Entrando na função 7ZextractDir #####################################"
echo "ADM DEBUG ########### versão Local  > $versionBinLocal"
echo "ADM DEBUG ########### versão online > $versionBinOnline"

if [ "$versionBinLocal" == "$versionBinOnline" ]; then # if do install
    echo "$app esta atualizado! > $versionBinOnline"
else

echo "$(date)" > $bootLog 2>&1
echo "Instalando o componente > $apkName" >> $bootLog 2>&1
echo "Por favor aguarde..." >> $bootLog 2>&1

    echo "ADM DEBUG ### Atualizando $app"    
    rm -rf $tmpUpdateF > /dev/null 2>&1
    mkdir -p $tmpUpdateF
    mkdir -p $pathToInstall
    # extract 7z splitted
    echo "ADM DEBUG ### Aguarde extraindo atualização. $app"
    /system/bin/7z x -aoa -y -p$Senha7z "$SourcePack.*" -oc:$tmpUpdateF > /dev/null 2>&1
fi
}

# batalha antiga usando binario do termux
# Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
# SourcePack="/data/asusbox/.install/01.sc.base/002.0/002.0"
# tmpUpdateF=/data/local/tmp/UpdateF
# /data/data/com.termux/files/usr/lib/p7zip/7za \
# x -aoa -y -p$Senha7z \
# "$SourcePack.*" -oc:$tmpUpdateF 






    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/AppGrant.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function AppGrant () {
    if [ ! "$AppGrantLoop" == "" ]; then
        for lgrant in $AppGrantLoop; do
            echo "ADM DEBUG ### aplicando o direito $lgrant ao $app"
            pm grant $app $lgrant
        done
    fi
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/CheckAKPinstallP2P.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


function CheckAKPinstallP2P () {
# senha dos arquivos compactados

if [ "$Senha7z" == "" ]; then
    Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
fi

# sistema antigo
# versionLocal=`dumpsys package $app | /system/bin/busybox grep versionName | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox head -n 1`

# novo sistema baseado em crc32 dos apk's
# versionLocal=`/system/bin/busybox cksum /data/app/$app*/base.apk | /system/bin/busybox cut -d "/" -f 1`


# novo sistema de comparação por data instalação, se existir o marcador ele NÃO FAZ downgrade do app
# este fix é para marcar todos os apps instalados no momento do dia que criei este novo check up
# Thu Jun  3 16:06:36 BRT 2021

if [ ! -d /data/asusbox/AppLog ]; then 
    busybox mkdir -p /data/asusbox/AppLog 
fi

if [ -d "/data/data/$app" ]; then # se a pasta data do apk existe, considero que já tem o ultimo apk lançado
    MarcadorInicial="Thu Jun  3 16:06:36 BRT 2021"
    if [ ! -f "/data/asusbox/AppLog/$app=$MarcadorInicial.log" ];then
        echo "ADM DEBUG ###########################################################"
        echo "ADM DEBUG ### pasta do $app existe! criando o marcador"
        touch "/data/asusbox/AppLog/$app=$MarcadorInicial.log"
    fi
else
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### cliente desistalou o $app removendo os logs marcadores"
    /system/bin/busybox find "/data/asusbox/AppLog/" -type f -name "$app=*" | while read fname; do
        busybox rm "$fname"
    done
fi

echo "ADM DEBUG ###########################################################"
echo "ADM DEBUG ### $apkName >>>>>>> $app"
# echo "ADM DEBUG ### versao local  > $versionLocal"
# echo "ADM DEBUG ### versao online > $versionNameOnline"
echo "ADM DEBUG ### Ultima versão p2p pack = $versionNameOnline"

#if [ ! "$versionLocal" == "$versionNameOnline" ]; then # NOVA TAREFA SE O CLIENTE ATUALIZAR O APP VAI SOBREESCREVER O INSTALL NO BOOT

if [ ! -f "/data/asusbox/AppLog/$app=$versionNameOnline.log" ];then
    echo "ADM DEBUG ######################################################"
    echo "ADM DEBUG ### arquivos $app são diferentes"
    echo "$(date)" > $bootLog 2>&1
    echo "ADM DEBUG ######################################################"
    echo "ADM DEBUG ### é AKP ou DTF ? = $AKPouDTF"
    echo "ADM DEBUG ### Arquivo já esta baixado e verificado CRC p2p"
    if [ "$AKPouDTF" == "AKP" ]; then
        echo "Instalando o aplicativo > $apkName $fakeName" >> $bootLog 2>&1
        echo "Por favor aguarde..." >> $bootLog 2>&1
        # extract 7z splitted
        echo "ADM DEBUG ### extraindo 7Z $app"
        /system/bin/7z e -aoa -y -p$Senha7z "$SourcePack*.001" -oc:/data/local/tmp #> /dev/null 2>&1
        # bug do arquivo corrompido falha aqui neste ponto
        # echo "/system/bin/7z e -aoa -y -p$Senha7z \"$SourcePack*.001\" -oc:/data/local/tmp"
        # exit

        # # binario do termux dando problema mesmo apontando arquivo direto não trabalha com split files
        # /system/bin/7z e -aoa -y -p$Senha7z "/data/asusbox/.install/04.akp.oem/ao.05/AKP/ao.05.AKP.001" -oc:/data/local/tmp

        echo "ADM DEBUG ### tentando instalar por cima o app $app"
        pm install -r /data/local/tmp/base.apk

        # downgrade forçado nos apps, se o cliente atualizar por sua conta
        # desistala o app novo! para instalar o do pack torrent em CIMA
        # se check crc for diferente ele vai entrar aqui descompactar apk
        if [ ! $? = 0 ]; then
            echo "ADM DEBUG ### Uninstall old app version"
            if [ -d /data/data/$app ]; then
                pm uninstall $app
            fi
            echo "ADM DEBUG ### primeira instalação do $app"
            pm install /data/local/tmp/base.apk
        fi
        
        echo "ADM DEBUG ### clean install file"
        rm /data/local/tmp/base.apk > /dev/null 2>&1
        echo "ADM DEBUG ### verificando se precisa liberar permissão para o $app"
        AppGrant

        echo "ADM DEBUG ### gravando o marcador"
        touch "/data/asusbox/AppLog/$app=$versionNameOnline.log"

    fi
else
    echo "$(date)" > $bootLog 2>&1
    echo "Aplicativo > $apkName $fakeName" >> $bootLog 2>&1
    echo "Esta atualizado." >> $bootLog 2>&1
fi
# zerando a variavel fakename por causa que não tem em todas as fichas tecnicas
fakeName=""
}




    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/CheckBase64.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function CheckBase64 () {
# versionBinLocal=`date` # para simular um erro nas versoes e gravar infinito
eval $cmdCheck
if [ ! "$versionBinOnline" == "$versionBinLocal" ]; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### função CheckBase64 #################################"
    echo "ADM DEBUG ### arquivo precisa ser atualizado > $pathToInstall"
    WriteBase64
else
    echo "ADM DEBUG ########################################################"
    echo "$pathToInstall" esta atualizado!
fi

}


function WriteBase64 () {
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### função WriteBase64 #################################"
    echo "ADM DEBUG ### gravando arquivo  > $pathToInstall"
    /system/bin/busybox mount -o remount,rw /system
    echo "$versionBinOnline" | /system/bin/busybox base64 -d > "$pathToInstall"
    /system/bin/busybox chmod $FilePerms $pathToInstall
    eval $NeedReboot
    echo "ADM DEBUG ### chama função CheckBase64 > $pathToInstall"
    CheckBase64
}








    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/CheckInstallAKP.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function CheckInstallAKP () {
# senha dos arquivos compactados
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
versionLocal=`dumpsys package $app | grep versionName | cut -d "=" -f 2`
crclocal=`HashFile /data/asusbox/$apkName.akp`
# se o app não estiver instalado baixa o akp
if [ ! "$versionLocal" == "$versionNameOnline" ]; then # NOVA TAREFA SE O CLIENTE ATUALIZAR O APP VAI SOBREESCREVER O INSTALL NO BOOT
    echo "<h1>$(date)</h1>" >> $bootLog 2>&1
    echo "<h3>Grande atualização, por favor aguarde.</h3>" >> $bootLog 2>&1
    echo "<h3>Arquivo grande pode demorar.</h3>" >> $bootLog 2>&1
### DOWNLOAD COM SISTEMA MULTI-LINKS
for LinkUpdate in $multilinks; do
    echo "loop download > $LinkUpdate"
    if [ ! "$crclocal" == "$crcOnline" ]; then
            echo "Download akp"
            echo "<h2>Iniciando download $apkName por favor espere.</h2>" > $bootLog 2>&1
            echo -n $LinkUpdate > /data/local/tmp/url.list
            cat /data/local/tmp/url.list
            DownloadAKP
            crclocal=`HashFile /data/asusbox/$apkName.akp`       
            if [ "$crclocal" == "$crcOnline" ]; then break; fi; # check return value, break if successful (0)
            sleep 1;
    fi
echo "Download concluido $apkName" > $bootLog 2>&1
done
echo "<h2>Instalando o aplicativo > $apkName</h2>" >> $bootLog 2>&1
echo "<h3>Por favor aguarde...</h3>" >> $bootLog 2>&1
    # extract 7z
    /system/bin/7z e -aoa -y -p$Senha7z "/data/asusbox/$apkName.akp" -oc:/data/local/tmp
    # instalando o app
	pm install -r /data/local/tmp/base.apk
    rm /data/local/tmp/base.apk
    # Fix Launcher
    cmd package set-home-activity "dxidev.toptvlauncher2/.HomeActivity"
fi
}


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/CheckInstallDTF.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function CheckInstallDTF () {
# senha dos arquivos compactados
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
crclocal=`HashFile /data/asusbox/$apkName.DTF`
if [ ! "$crclocal" == "$crcOnline" ]; then
    echo "<h1>$(date)</h1>" >> $bootLog 2>&1
    echo "<h3>Grande atualização, por favor aguarde.</h3>" >> $bootLog 2>&1
    echo "<h3>Arquivo grande pode demorar.</h3>" >> $bootLog 2>&1
### DOWNLOAD COM SISTEMA MULTI-LINKS
for LinkUpdate in $multilinks; do
    echo "loop download > $LinkUpdate"
    if [ ! "$crclocal" == "$crcOnline" ]; then
            echo "Iniciando download $apkName por favor espere." > $bootLog 2>&1
            echo -n $LinkUpdate > /data/local/tmp/url.list
            cat /data/local/tmp/url.list
            DownloadDTF
            crclocal=`HashFile /data/asusbox/$apkName.akp`       
            if [ "$crclocal" == "$crcOnline" ]; then break; fi; # check return value, break if successful (0)
            sleep 1;
    fi
done
    echo "Download concluido $apkName" > $bootLog 2>&1
fi
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/CheckUser.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function CheckUser {
UserPass=`/system/bin/busybox cat /data/data/com.asusbox.asusboxiptvbox/shared_prefs/loginPrefs.xml | /system/bin/busybox grep password | /system/bin/busybox cut -d '>' -f 2 | /system/bin/busybox cut -d '<' -f 1`
}


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/DownloadAKP.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function DownloadAKP () {
echo "Iniciando download $apkName "> $bootLog 2>&1
FechaAria
$aria2c \
--check-certificate=false \
--show-console-readout=false \
--always-resume=true \
--allow-overwrite=true \
--summary-interval=10 \
--console-log-level=error \
--file-allocation=none \
--input-file=/data/local/tmp/url.list \
-d /data/asusbox | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/DownloadDTF.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function DownloadDTF () {
echo "Iniciando download $apkName "> $bootLog 2>&1
FechaAria
$aria2c \
--check-certificate=false \
--show-console-readout=false \
--always-resume=true \
--allow-overwrite=true \
--summary-interval=10 \
--console-log-level=error \
--file-allocation=none \
--input-file=/data/local/tmp/url.list \
-d /data/asusbox | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/DownloadGitHub.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

GitHUBcheckVersion () {
latest_release=$(curl -s "$repo_url" | grep "browser_download_url" | cut -d '"' -f 4 | grep "armeabi-v7a.apk")
VersionOnline=$(basename "$latest_release")
# echo "$latest_release"
# echo "$VersionOnline"
}

DownloadFromGitHUB () {
if [ ! "$VersionOnline" == "$VersionLocal" ]; then
    echo "<h2>Baixando o aplicativo > $VersionOnline < Por favor aguarde.</h2>" >> "$bootLog" 2>&1
    /system/bin/wget --no-check-certificate --timeout=1 --tries=7 -O /data/local/tmp/base.apk "$latest_release" 2>&1
    echo "<h2>Instalando o aplicativo > $VersionOnline</h2>" >> $bootLog 2>&1
    echo "<h3>Por favor aguarde...</h3>" >> $bootLog 2>&1
    pm install -r /data/local/tmp/base.apk
    rm /data/local/tmp/base.apk
    echo -n "$VersionOnline" > /data/data/$realname/VersionInstall.log
else
    echo "Apk [$VersionLocal] esta atualizado" >> "$bootLog" 2>&1
fi
}


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/DownloadSplitted.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function DownloadSplitted () {
echo "Iniciando download $apkName "> $bootLog 2>&1
FechaAria
/system/bin/aria2c \
--check-certificate=false \
--show-console-readout=false \
--always-resume=true \
--allow-overwrite=true \
--summary-interval=10 \
--console-log-level=error \
--file-allocation=none \
--input-file=/data/local/tmp/url.list \
-d $InstallDir | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
echo "Download Concluido!" > $bootLog 2>&1
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/FechaAria.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


#####################################################################################################
# Funções de download
function FechaAria () {
/system/bin/busybox kill -9 $(/system/bin/busybox pgrep aria2c) > /dev/null 2>&1
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/FileListInstall.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function FileListInstall () {

# verifica se esta instalado e funcionando
eval $cmdCheck
rm /data/local/tmp/swap > /dev/null 2>&1
echo "ADM DEBUG #############################################################"
echo "ADM DEBUG ### $app | $FileName | $FileExtension"
echo "ADM DEBUG ### versão local $versionBinLocal"
echo "ADM DEBUG ### versão online $versionBinOnline"


echo "$(date)" > $bootLog 2>&1
echo "Instalando o componente > $apkName" >> $bootLog 2>&1
echo "Por favor aguarde..." >> $bootLog 2>&1


if [ "$versionBinOnline" == "$versionBinLocal" ]; then # if do install
    echo "Componente $FileName Atualizado"
else
# não existe mais comparação de arquivos online vs local em vista q download é via torrent.
    if [ "$FileExtension" == "SC" ]; then
        echo "ADM DEBUG ### extraindo ScriptPack $app"
        # extract 7z splitted
        echo "ADM DEBUG ### nome do path arquivo >>>> $SourcePack"
        echo "ADM DEBUG ### onde vai instalar $pathToInstall"
        /system/bin/7z e -aoa -y -p$Senha7z "$SourcePack" -oc:/data/local/tmp > /dev/null 2>&1
        # extract tar
        rm -rf /data/local/tmp/$FileName > /dev/null 2>&1
        mkdir -p /data/local/tmp/$FileName
        cd /data/local/tmp/$FileName
        /system/bin/busybox tar -mxvf /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
        # botar um if aqui se a var estiver vazia
        if [ "$pathToInstall" == "" ]; then
            echo "ADM DEBUG ### Cuidado! debugger se a variavel $pathToInstall estiver vazia! brica o TVbox"
            sleep 3
            break
        else          
            # rsync
            echo "ADM DEBUG ### rsync > /data/local/tmp/$FileName/ $pathToInstall/"
            mkdir -p $pathToInstall > /dev/null 2>&1
            cd $pathToInstall
            /system/bin/rsync --progress -avz --delete --recursive --force /data/local/tmp/$FileName/ $pathToInstall/ > /dev/null 2>&1
            # clean
            rm /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
            rm -rf /data/local/tmp/$FileName > /dev/null 2>&1
        fi
    fi 
    # extraindo os binarios para instalação
    if [ "$FileExtension" == "tar.gz" ]; then
        echo "ADM DEBUG ### extraindo tar.gz $app"
        # extract tar
        cd /
        /system/bin/busybox mount -o remount,rw /system
        /system/bin/busybox tar -mxvf $InstallDir/$FileName.tar.gz > /dev/null 2>&1
    fi
    if [ "$FileExtension" == "7z" ]; then
        echo "ADM DEBUG ### extraindo 7z $app"
        # extract 7z splitted
        /system/bin/7z e -aoa -y -p$Senha7z "$SourcePack.*" -oc:/data/local/tmp > /dev/null 2>&1
        # extract tar
        cd /
        /system/bin/busybox mount -o remount,rw /system
        /system/bin/busybox tar -mxvf /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
        rm /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
    fi
    if [ "$FileExtension" == "WebPack" ]; then
        # verifica e instala 
        7ZextractDir
        # rsync folder
        RsyncUpdateWWW
    fi
    # roda o script para concluir a instalação do binário em questão
    eval "$scriptOneTimeOnly"
fi ### end do if se esta instalado
}


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/FixPerms.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function FixPerms () {
    # permissao do user da pasta
    DUser=`dumpsys package $app | /system/bin/busybox grep userId | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox head -n 1`
    echo $DUser
    chown -R $DUser:$DUser /data/data/$app
    restorecon -FR /data/data/$app
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/HashALLFiles.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

# check crc para testar escrita e loopa ate conseguir
function HashALLFiles() {
    /system/bin/busybox rm /data/tmp.hash >/dev/null 2>&1
    /system/bin/busybox find $1 -type f \( -iname \* \) | /system/bin/busybox sort | while read fname; do
        /system/bin/busybox md5sum "$fname" | /system/bin/busybox cut -d ' ' -f1 >>/data/tmp.hash 2>&1
    done
    export HashResult=$(/system/bin/busybox cat /data/tmp.hash)
    /system/bin/busybox rm /data/tmp.hash >/dev/null 2>&1
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/HashFile.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function HashFile () {
/system/bin/busybox md5sum "$1" | /system/bin/busybox cut -d ' ' -f1
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/HashFolder.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function HashFolder () {
/system/bin/busybox rm /data/tmp.hash > /dev/null 2>&1
/system/bin/busybox find $1 -type f \( -iname \*.sh -o -iname \*.webp -o -iname \*.jpg -o -iname \*.png -o -iname \*.php -o -iname \*.html -o -iname \*.js -o -iname \*.css \) | /system/bin/busybox sort | while read fname; do
    #echo "$fname"
    /system/bin/busybox md5sum "$fname" | /system/bin/busybox cut -d ' ' -f1 >> /data/tmp.hash 2>&1
done
export HashResult=`/system/bin/busybox cat /data/tmp.hash`
/system/bin/busybox rm /data/tmp.hash > /dev/null 2>&1
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/LauncherList.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function LauncherList () {
if [ "$LauncherIntegrated" == "yes" ]; then
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### adicionado a lista de aplicativos com launcher"
    #pm hide $app # não é necessário para os apps launcher atual
    if [ ! -f /data/asusbox/LauncherLock ]; then
        # nova politica de não desativar mais a launcher online official
        if [ ! "$app" == "dxidev.toptvlauncher2" ]; then
            pm disable $app
        fi
    fi
    echo "$app" >> /data/asusbox/LauncherList
fi
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/OutputLogUsb.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function OutputLogUsb () {
    ListaUSBmounted=$(busybox mount | busybox grep public | busybox grep -v '/mnt/runtime/' | busybox awk '!seen[$1]++' | busybox awk '{print $3}')
    if [ ! "$ListaUSBmounted" == "" ]; then
        for DriverPathUSBmounted in $ListaUSBmounted; do
            if [ "$USBLOGCALLSet" == "clear" ]; then
                rm "$DriverPathUSBmounted/debug.log"
                USBLOGCALLSet=""
            fi
            if [ ! "$USBLOGCALLSet" == "remove" ]; then
                echo "$(date) Usb Log \"$USBLOGCALL\"" >> "$DriverPathUSBmounted/debug.log"
            else
                echo "$(date) Update no errors" >> "$DriverPathUSBmounted/debug.log"
            fi
        done
    fi
}





    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/RsyncUpdate.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function RsyncUpdateWWW () {
    eval $cmdCheck
    exclude="/data/local/tmp/exclude.txt"

    echo "ADM DEBUG #################################################################################" 
    echo "ADM DEBUG ########### Entrando na função RsyncUpdateWWW ###################################"

    if [ "$versionBinLocal" == "$versionBinOnline" ]; then # if do install
        echo "$app esta atualizado!"
    else
        echo -n "$ExcludeItens" > $exclude
        echo "ADM DEBUG ### Atualizando via rsync $app em > $pathToInstall"
        mkdir -p $pathToInstall
        cd $pathToInstall
        # copiar a pasta para o TMP
        /system/bin/rsync \
        --progress \
        -avz \
        --delete \
        --recursive \
        --force \
        --exclude-from=$exclude \
        /data/local/tmp/UpdateF/ $pathToInstall/ > /dev/null 2>&1
    fi
    rm -rf $tmpUpdateF > /dev/null 2>&1
    rm $exclude > /dev/null 2>&1
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/excludeListAPP.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function excludeListAPP () {
# echo "ADM DEBUG ###########################################################"
# echo "ADM DEBUG ### adicionado a lista de aplicativos em uso"
echo "$app" >> /data/local/tmp/APPList

}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/excludeListPack.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function excludeListPack () {
# echo "ADM DEBUG ###########################################################"
# echo "ADM DEBUG ### adicionado a lista de pacotes em uso"
echo "$1" >> /data/local/tmp/PackList

}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/extractDTF.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function extractDTF () {
echo "<h1>$(date)</h1>" >> $bootLog 2>&1
echo "<h2>Configurando o aplicativo > $apkName $fakeName</h2>" >> $bootLog 2>&1
echo "<h3>Por favor aguarde...</h3>" >> $bootLog 2>&1
am force-stop $app
# extract 7z
/system/bin/7z e -aoa -y -p$Senha7z "/data/asusbox/$apkName.DTF" -oc:/data/local/tmp
# extract tar
cd /
/system/bin/busybox tar -mxvf /data/local/tmp/$apkName.DT.tar.gz
rm /data/local/tmp/$apkName.DT.tar.gz
# zerando a variavel fakename por causa que não tem em todas as fichas tecnicas
fakeName=""
}


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/extractDTFSplitted.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function extractDTFSplitted () {
    echo "$(date)" > $bootLog 2>&1
    echo "Configurando o aplicativo > $apkName $fakeName" >> $bootLog 2>&1
    echo "Por favor aguarde..." >> $bootLog 2>&1
    am force-stop $app
    # extract 7z
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### entrando na função extractDTFSplitted"
    echo "ADM DEBUG ### extraindo 7Z $apkName"
    rm /data/local/tmp/*tar.gz > /dev/null 2>&1
    /system/bin/7z e -aoa -y -p$Senha7z "$SourcePack*.001" -oc:/data/local/tmp > /dev/null 2>&1

    # echo "ADM DEBUG ### bah"
    # sleep 3000

    # extract tar
    echo "ADM DEBUG ### extraindo tar $apkName.DT.tar.gz"
    cd /
    /system/bin/busybox tar -mxvf /data/local/tmp/$apkName.DT.tar.gz > /dev/null 2>&1
    rm /data/local/tmp/$apkName.DT.tar.gz > /dev/null 2>&1
    # zerando a variavel fakename por causa que não tem em todas as fichas tecnicas
    fakeName=""
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/killcron.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function killcron () {
checkPort=`/system/bin/busybox ps \
| /system/bin/busybox grep "/system/bin/busybox crond" \
| /system/bin/busybox grep -v "grep" \
| /system/bin/busybox awk '{print $1}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`
    if [ ! "$checkPort" == "" ]; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Desligando serviço cron"
        echo "ADM DEBUG ### cron rodando na porta $checkPort"
        /system/bin/busybox kill -9 $checkPort
    fi
}


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/p2p-getID.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function p2pgetID () {
echo "ADM DEBUG ### $torFile"
torID=`/system/bin/transmission-remote --list \
| /system/bin/busybox grep "$torFile" \
| /system/bin/busybox awk '{print $1}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`
echo "ADM DEBUG ### $torID"
}



    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/p2p-kill.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function killTransmission () {
    checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
    if [ "$checkPort" == "9091" ]; then
        echo "ADM DEBUG ### Desligando transmission torrent downloader"
        /system/bin/transmission-remote --exit
        killall transmission-daemon
    fi


# fix das boxes travadas que não esta atualizando por algum motivo
# existem varias versoes do arquivo settings.json e fica em branco
busybox find /data/transmission/ -type f -name 'settings.json*' -exec busybox rm {} +


}




    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/p2p-restart.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function restartTransmission () {
    killTransmission
    sleep 3
    StartDaemonTransmission
# melhor seria criar uma função e um script anexo para o cron / ai o cliente não tem chance de desativar
# netstat -ntlup | grep transmission
}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/p2p-seedbox.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function SeedBOXTransmission () {
echo "seedbox $torFile.torrent"
##############################################################################################################
######### Seed BOX Torrents ##################################################################################
##############################################################################################################

p2pgetID
# sleep 2

# se não existir ID não existe o torrent na fila de downloads para ser removido
if [ ! "$torID" == "" ]; then
    echo "ADM DEBUG ##############################################################################"
    echo "ADM DEBUG ### remove o torrent obrigatório por conta do bug de salvar na pasta downloads"
    /system/bin/transmission-remote -t $torID -r
    echo "ADM DEBUG ##############################################################################"
fi

echo "ADM DEBUG ### conceito para adicionar torrents seguindo as politicas do daemon"
/system/bin/transmission-remote \
-a /data/asusbox/$torFile.torrent \
-m \
-x \
-o \
-y \
-w /data/asusbox/ \
-S
# vai verificar todos os arquivos baixados mesmo não setando o -v
# -S stopa o torrent para não baixar nada ainda


echo "ADM DEBUG ##############################################################################"
p2pgetID
# printa o conteudo do arquivo torrent, arquivo precisa ser adicionado para listar conteudo
/system/bin/transmission-remote -t $torID -f | /system/bin/busybox awk '{print $7}' | /system/bin/busybox sed 's;.install/;./;g' > /data/local/tmp/TorrentList
# remove novas linhas em branco
/system/bin/busybox sed -i -e '/^\s*$/d' /data/local/tmp/TorrentList
# aqui compara se o conteudo do torrent bate com a pasta atual para apagar arquivos obsoletos
/system/bin/busybox find "/data/asusbox/.install/" -type f -name "*" \
| /system/bin/busybox grep -v -f /data/local/tmp/TorrentList \
| while read fname; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Limpando a pasta .install"
    #Fileloop=`basename $fname`
    #echo "eu vou apagar este arquivo > $fname"
    rm -rf "$fname"
done
rm /data/local/tmp/TorrentList



echo "ADM DEBUG ### -v verifica o torrent | -s inicia o torrent caso esteja pausado | torrent-done-script"
/system/bin/transmission-remote -t $torID -v -s --torrent-done-script /data/transmission/tasks.sh
echo "ADM DEBUG ##############################################################################"

}



    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/p2p-start.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function StartDaemonTransmission () {
#source /data/.vars # sera que realmente precisa disto??
configDir="/data/transmission"
seedBox="/sdcard/Download"

# pastas 
if [ ! -d $configDir ] ; then
    mkdir -p $configDir
fi
if [ ! -d $seedBox ] ; then
    mkdir -p $seedBox
fi
fileConf="/data/transmission/settings.json"
/system/bin/busybox sed -i -e 's;"umask":.*;"umask": 63,;g' $fileConf

# iniciei o daemon basico e no remote com todas as funções e com porta 51345 fechada! não iniciou nenhum up/down nem lp
high=65535
low=49152
export PeerPort=$(( ( RANDOM % (high-low) )  + low ))

echo "start" > /data/asusbox/transmission.log
echo "ADM DEBUG ### Iniciando transmission Daemon"
/system/bin/transmission-daemon \
-g $configDir \
-a 127.0.0.1,*.* \
-P $PeerPort \
-c /sdcard/Download/ \
-w $seedBox

}

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/p2p-wait.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function p2pWait () {
#if [ ! -f "/data/asusbox/FullInstall" ];then
	# script fica aguardando pelo arquivo para prosseguir
	FileWaitingP2P="/data/transmission/$torFile"
	/system/bin/busybox rm $FileWaitingP2P > /dev/null 2>&1
	while [ 1 ]; do
		if [ -e $FileWaitingP2P ];then break; fi;
		echo "Wait for update $torFile"
		# ShellResult=`/system/bin/transmission-remote --list`
		# echo "ADM DEBUG ### escrevendo no log web progresso do torrent"
		# echo "<h2>$ShellResult</h2>" > $bootLog 2>&1
		sleep 5;    
	done;
	echo "ADM DEBUG ### arquivo $FileWaitingP2P apagado!"
	/system/bin/busybox rm $FileWaitingP2P
#fi
}


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/scriptAtBootFN.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function scriptAtBootFN () {
    if [ ! "$scriptAtBoot" == "" ]; then
        echo "runing code"
        eval "$scriptAtBoot"
    fi
}


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/z_acr.browser.barebones.change.URL.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function z_acr.browser.barebones.change.URL () {
    while [ 1 ]; do        
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### fechando o acr.browser.barebones"
        am force-stop acr.browser.barebones
        if [ $? = 0 ]; then break; fi;
        sleep 1
    done;

FileXML="/data/data/acr.browser.barebones/shared_prefs/settings.xml"
/system/bin/busybox cat <<EOF > "$FileXML"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="blackStatusBar" value="true" />
    <int name="enableflash" value="0" />
    <boolean name="cache" value="true" />
    <boolean name="restoreclosed" value="false" />
    <boolean name="clearWebStorageExit" value="true" />
    <boolean name="hidestatus" value="true" />
    <int name="Theme" value="1" />
    <string name="home">http://127.0.0.1:9091</string>
</map>

EOF
/system/bin/busybox sed -i -e "s;<string name=\"home\">.*</string>;<string name=\"home\">$ACRURL</string>;g" $FileXML

/system/bin/busybox chmod 660 /data/data/acr.browser.barebones/shared_prefs/*.xml
app="acr.browser.barebones"
FixPerms

}





    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/z_acr.browser.barebones.launch.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function acr.browser.barebones.launch () {
    while [ 1 ]; do
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### abrindo navegador exibir log instalação"
        am start --user 0 \
        -n acr.browser.barebones/acr.browser.lightning.MainActivity \
        -a android.intent.action.VIEW -d "$ACRURL" > /dev/null 2>&1
        if [ $? = 0 ]; then break; fi;
        sleep 1
    done;

}





    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/z_acr.browser.barebones.set.config.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

function acr.browser.barebones.set.config () {
FileXML="/data/data/acr.browser.barebones/shared_prefs/acr.browser.barebones_preferences.xml"
if [ ! -f "$FileXML"  ]; then
mkdir -p /data/data/acr.browser.barebones/shared_prefs
/system/bin/busybox cat <<EOF > "$FileXML"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="fullScreenOption" value="true" />
    <boolean name="cb_images" value="false" />
    <boolean name="cb_javascript" value="true" />
    <boolean name="clear_webstorage_exit" value="true" />
    <boolean name="password" value="true" />
    <boolean name="cb_drawertabs" value="true" />
    <boolean name="remove_identifying_headers" value="false" />
    <boolean name="clear_cookies_exit" value="false" />
    <boolean name="allow_cookies" value="true" />
    <boolean name="cb_ads" value="false" />
    <boolean name="allow_new_window" value="true" />
    <boolean name="third_party" value="false" />
    <boolean name="clear_history_exit" value="false" />
    <boolean name="restore_tabs" value="false" />
    <boolean name="cb_swapdrawers" value="false" />
    <boolean name="do_not_track" value="false" />
    <boolean name="location" value="false" />
    <boolean name="cb_flash" value="false" />
    <boolean name="incognito_cookies" value="false" />
    <boolean name="black_status_bar" value="true" />
    <boolean name="fullscreen" value="true" />
    <boolean name="clear_cache_exit" value="true" />
    <boolean name="text_reflow" value="false" />
    <boolean name="wideViewPort" value="true" />
    <boolean name="overViewMode" value="true" />
    <boolean name="cb_colormode" value="true" />
</map>

EOF
fi

FileXML="/data/data/acr.browser.barebones/shared_prefs/settings.xml"
if [ -z "$(cat $FileXML | grep 9091)" ]; then
/system/bin/busybox cat <<EOF > "$FileXML"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="blackStatusBar" value="true" />
    <int name="enableflash" value="0" />
    <boolean name="cache" value="true" />
    <boolean name="restoreclosed" value="false" />
    <boolean name="clearWebStorageExit" value="true" />
    <boolean name="hidestatus" value="true" />
    <int name="Theme" value="1" />
    <string name="home">http://127.0.0.1:9091</string>
</map>

EOF
fi

/system/bin/busybox chmod 660 /data/data/acr.browser.barebones/shared_prefs/*.xml
app="acr.browser.barebones"
FixPerms
# echo "ADM DEBUG ########################################################"
# echo "ADM DEBUG ### abre o navegador pela primeira vez"
# monkey -p $app -c android.intent.category.LAUNCHER 1


}





    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/000.0 ( CPU ) optimize.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



echo -n "performance" >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.001.0-armeabi-v7a-busybox.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### busybox > B.001.0-armeabi-v7a Results >>> Wed Dec 31 21:23:53 BRT 1969
Senha7z="D2XL1wPhGR1Sb0dtJDkdGo18wHGQcbiIOGLo5SbL9Gjaar2HqQC0coypPRRdiyrtg131vS"
app="busybox"
CpuPack="armeabi-v7a"
FileName="B.001.0-armeabi-v7a"
apkName="B.001.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.001.0-armeabi-v7a/B.001.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/busybox > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="BusyBox v1.31.1-meefik (2019-12-29 23:43:11 MSK) multi-call binary."
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.001.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.002.0-armeabi-v7a-termuxLibs.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### termuxLibs > B.002.0-armeabi-v7a Results >>> Wed Dec 31 21:24:09 BRT 1969
Senha7z="3fxgglKD03BDLwhyNOQa5uVqOIcfaAMJCXl6nAppeglwIxUW86XGt3oFvyIRq1xvypOeNz"
app="termuxLibs"
CpuPack="armeabi-v7a"
FileName="B.002.0-armeabi-v7a"
apkName="B.002.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.002.0-armeabi-v7a/B.002.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/7z -h > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 2p` && rm /data/local/tmp/swap'
versionBinOnline="7-Zip (a) [32] 17.02 : Copyright (c) 1999-2020 Igor Pavlov : 2017-08-28"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/lib/p7zip/7za /system/bin/7z
ln -sf /system/usr/lib/p7zip/7za /system/bin/7z.so
# esta é a lib para o firmware antigo
ln -sf /system/usr/lib/libz.so.1.2.11 /system/lib/libz.so.1
"
excludeListPack "/data/asusbox/.install/00.snib/B.002.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.003.0-armeabi-v7a-bash.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### bash > B.003.0-armeabi-v7a Results >>> Wed Dec 31 21:24:14 BRT 1969
Senha7z="1Z5K1egIUI0UbiVI3QaaDMzgM0uzd5K2T8PeOW9j9cV36LhrghsRSHbisl2h1bVjhHM3Qk"
app="bash"
CpuPack="armeabi-v7a"
FileName="B.003.0-armeabi-v7a"
apkName="B.003.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.003.0-armeabi-v7a/B.003.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/bash -version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="GNU bash, version 5.1.0(1)-release (arm-unknown-linux-androideabi)"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/bash /system/bin/bash
"
excludeListPack "/data/asusbox/.install/00.snib/B.003.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.004.0-armeabi-v7a-curl.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### curl > B.004.0-armeabi-v7a Results >>> Wed Dec 31 21:24:19 BRT 1969
Senha7z="zTlHBfxdeVzs9upefed4oGrExxpHAzdzZoj3G0jmce6NEqJs46c4CUoFtp4B9YwW44rJOz"
app="curl"
CpuPack="armeabi-v7a"
FileName="B.004.0-armeabi-v7a"
apkName="B.004.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.004.0-armeabi-v7a/B.004.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/curl --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="curl 7.73.0 (arm-unknown-linux-androideabi) libcurl/7.73.0 OpenSSL/1.1.1h zlib/1.2.11 libssh2/1.9.0 nghttp2/1.42.0"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/curl /system/bin/curl
"
excludeListPack "/data/asusbox/.install/00.snib/B.004.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.005.0-armeabi-v7a-lighttpd.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### lighttpd > B.005.0-armeabi-v7a Results >>> Wed Dec 31 21:24:24 BRT 1969
Senha7z="M9rkBR4Et5Zh37gYyghXQE4p0AQtwW0PAm5Xshy4vufdV9qwb9QTSqgXn5UQcj4i092Yrj"
app="lighttpd"
CpuPack="armeabi-v7a"
FileName="B.005.0-armeabi-v7a"
apkName="B.005.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.005.0-armeabi-v7a/B.005.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/lighttpd -h > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="lighttpd/1.4.56 (ssl) - a light and fast webserver"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/lighttpd /system/bin/lighttpd
"
excludeListPack "/data/asusbox/.install/00.snib/B.005.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.006.0-armeabi-v7a-PHP.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### PHP > B.006.0-armeabi-v7a Results >>> Wed Dec 31 21:25:26 BRT 1969
Senha7z="6jH058EnMppKHbWvUB7nbNMxtAYigIKr7Xv9XWA7oi0AotUcY3SWJqRP1dZlsbUno7a4CB"
app="PHP"
CpuPack="armeabi-v7a"
FileName="B.006.0-armeabi-v7a"
apkName="B.006.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.006.0-armeabi-v7a/B.006.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/php-cgi --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="PHP 8.0.0 (cgi-fcgi) (built: Dec  6 2020 20:57:33)"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/php-cgi /system/bin/php-cgi
"
excludeListPack "/data/asusbox/.install/00.snib/B.006.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.007.0-armeabi-v7a-rsync.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### rsync > B.007.0-armeabi-v7a Results >>> Wed Dec 31 21:25:31 BRT 1969
Senha7z="53F7cWQEUJx1zfRoAhjjoj5XmXePcJqM8RdwOqfu1ldjvxIW6PzBe6wRNcAYC0p71d3OG2"
app="rsync"
CpuPack="armeabi-v7a"
FileName="B.007.0-armeabi-v7a"
apkName="B.007.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.007.0-armeabi-v7a/B.007.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/rsync --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="rsync  version 3.2.3  protocol version 31"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/rsync /system/bin/rsync
ln -sf /system/usr/bin/rsync-ssl /system/bin/rsync-ssl
"
excludeListPack "/data/asusbox/.install/00.snib/B.007.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.008.0-armeabi-v7a-screen.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### screen > B.008.0-armeabi-v7a Results >>> Wed Dec 31 21:25:36 BRT 1969
Senha7z="Qfl5U522d4fVAktW6IWii7GhTUadyyQlWrPhfF4Dp4tCmeFK4QXODAdnvqMFmhOhEUZpFL"
app="screen"
CpuPack="armeabi-v7a"
FileName="B.008.0-armeabi-v7a"
apkName="B.008.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.008.0-armeabi-v7a/B.008.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/screen --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="Screen version 4.08.00 (GNU) 05-Feb-20"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/screen /system/bin/screen
"
excludeListPack "/data/asusbox/.install/00.snib/B.008.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.009.0-armeabi-v7a-transmission.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### transmission > B.009.0-armeabi-v7a Results >>> Wed Dec 31 21:25:52 BRT 1969
Senha7z="Fhwa9h9Pf2f6290lhPrVrptLjl5QrhHFqZlNAfPHUIUaAzYj3VzvoaU1M37FR4r1gv4h4h"
app="transmission"
CpuPack="armeabi-v7a"
FileName="B.009.0-armeabi-v7a"
apkName="B.009.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.009.0-armeabi-v7a/B.009.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/transmission-remote -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="transmission-remote 3.00 (bb6b5a062e)"
scriptOneTimeOnly="
# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/transmission-create /system/bin/
ln -sf /system/usr/bin/transmission-remote /system/bin/
ln -sf /system/usr/bin/transmission-edit /system/bin/
ln -sf /system/usr/bin/transmission-show /system/bin/
ln -sf /system/usr/bin/transmission-daemon /system/bin/
"
excludeListPack "/data/asusbox/.install/00.snib/B.009.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.010.0-armeabi-v7a-wget.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### wget > B.010.0-armeabi-v7a Results >>> Wed Dec 31 21:25:57 BRT 1969
Senha7z="NVJwvNGGpx2CQuQ893IqW2pyBy1GlXTxfy8NQbFewudgc7dfxd9KoHAGf2RwHjfBpDxWW2"
app="wget"
CpuPack="armeabi-v7a"
FileName="B.010.0-armeabi-v7a"
apkName="B.010.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.010.0-armeabi-v7a/B.010.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/wget --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="GNU Wget 1.20.3 built on linux-androideabi."
scriptOneTimeOnly="
# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/wget /system/bin/
"
excludeListPack "/data/asusbox/.install/00.snib/B.010.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.011.0-armeabi-v7a-diskUtils.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### diskUtils > B.011.0-armeabi-v7a Results >>> Wed Dec 31 21:26:06 BRT 1969
Senha7z="tkge1FaBOHhjdEnTwtWInrv3CdKGQo1OT15vPVncxkJq3S4mJ399inJkxY1Sz70S9nsmDb"
app="diskUtils"
CpuPack="armeabi-v7a"
FileName="B.011.0-armeabi-v7a"
apkName="B.011.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.011.0-armeabi-v7a/B.011.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/fdisk -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="fdisk from util-linux 2.32.95-1c199"
scriptOneTimeOnly="
# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/wget /system/bin/
ln -sf /system/usr/bin/fdisk /system/bin/
ln -sf /system/usr/bin/gdisk /system/bin/
ln -sf /system/usr/bin/mkfs.ext4 /system/bin/
ln -sf /system/usr/bin/parted /system/bin/
"
excludeListPack "/data/asusbox/.install/00.snib/B.011.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.013.0-armeabi-v7a-aria2c.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### aria2c > B.013.0-armeabi-v7a Results >>> Wed Dec 31 21:26:19 BRT 1969
Senha7z="gkCm8vjOViYaJ4dbvlSxsbuL2LUutmij7NfdCbZihRBVnT2UsZHVDoqc9pyLNcsGxutAs9"
app="aria2c"
CpuPack="armeabi-v7a"
FileName="B.013.0-armeabi-v7a"
apkName="B.013.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.013.0-armeabi-v7a/B.013.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/aria2c -v > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="aria2 version 1.35.0"
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.013.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.014.0-armeabi-v7a-syncthing.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### syncthing > B.014.0-armeabi-v7a Results >>> Thu Mar 10 22:20:29 BRT 2022
Senha7z="QUA9qeNYo5VaNKSGbMK3nR6sWqIWon9lNmowLxf8uSpJUWu4TrMHvyzMInhK2yFL2PR48T"
app="syncthing"
CpuPack="armeabi-v7a"
FileName="B.014.0-armeabi-v7a"
apkName="B.014.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.014.0-armeabi-v7a/B.014.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/initRc.drv.05.08.98 -version | cut -d " " -f 2 > /data/local/tmp/swap && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="v1.19.1"
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.014.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.015.0-armeabi-v7a-aapt.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### syncthing > B.015.0-armeabi-v7a Results >>> Sun Nov  3 20:19:31 UTC___ 2024
Senha7z="Bm4jxlld4c1zWPfoxKc3cgQex5edz1JgYoumdpcoEwTFwYIKZoI6pK0WHjPTntiThHYADW"
app="aapt"
CpuPack="armeabi-v7a"
FileName="B.015.0-armeabi-v7a"
apkName="B.015.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.015.0-armeabi-v7a/B.015.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/aapt version | cut -d " " -f 5 > /data/local/tmp/swap && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="v0.2-eng.zhengzhongming.20180802.165542"
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.015.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.snib/loop/bins-B.016.0-armeabi-v7a-openssl.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### openssl > B.016.0-armeabi-v7a Results >>> Sun Nov  3 20:23:53 UTC___ 2024
Senha7z="tQaiSAQPhgAkQ7wB20ulZpHnC1EZZvb4aOGsG7m13JnhLc2ikEejmlWADKNp4fUrIBZpzk"
app="openssl"
CpuPack="armeabi-v7a"
FileName="B.016.0-armeabi-v7a"
apkName="B.016.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.016.0-armeabi-v7a/B.016.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/openssl version | cut -d " " -f 2 > /data/local/tmp/swap && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="1.1.1h"
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.016.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi




