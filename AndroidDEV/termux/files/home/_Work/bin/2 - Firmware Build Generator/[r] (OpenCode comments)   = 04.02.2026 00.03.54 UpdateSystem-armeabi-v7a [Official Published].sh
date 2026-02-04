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
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/0000 1 UPDATE Curl cacert certs.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


CACERT="/data/Curl_cacert.pem"
CACERT_URL="https://curl.se/ca/cacert.pem"
CACERT_MAX_AGE_DAYS=30


# exemplo como o aria2c foi usado em outro script 
#     aria2c --check-certificate=true --ca-certificate="/data/Curl_cacert.pem" --continue=true --max-connection-per-server=4 -x4 -s4 --dir="/data/local/tmp" -o "openssl" "$URL"
 
#leia apenas este script. isto vai rodar em um tvbox android limitado mas tem aria2c instalado entao no topo do 
#script leia o comentario como o aria2c baixa com sucesso um arquivo como seria a função curl_bootstrap_cacert para baixar usando 


# Bootstrap CA bundle: first download with -k, then refresh with verification.
curl_bootstrap_cacert() {
  if [ ! -f "$CACERT" ]; then
    /system/bin/curl -sS -k --connect-timeout 8 --max-time 25 \
      -o "$CACERT" "$CACERT_URL"
    return
  fi

  if /system/bin/busybox stat -c %Y "$CACERT" >/dev/null 2>&1; then
    now_ts=$(date +%s)
    file_ts=$(/system/bin/busybox stat -c %Y "$CACERT")
    age_days=$(( (now_ts - file_ts) / 86400 ))
    if [ "$age_days" -ge "$CACERT_MAX_AGE_DAYS" ]; then
      /system/bin/curl -sS --cacert "$CACERT" --connect-timeout 8 --max-time 25 \
        -o "$CACERT" "$CACERT_URL"
    fi
  fi
}

curl_bootstrap_cacert




    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /_functions/firmware/0000 2 essential bin - openssl.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


BB=/system/bin/busybox

# Verifica se o binário já existe e está funcional — se sim, pula o download
skip_download=0
if [ -x /data/bin/openssl ]; then
    version=$(/data/bin/openssl version 2>/dev/null | cut -d " " -f 2)
    if [ -n "$version" ]; then
        echo "OpenSSL já instalado — versão $version. Pulando download."
        skip_download=1
    else
        echo "OpenSSL encontrado mas não respondeu corretamente — atualizando..."
    fi
fi

# if [ "$skip_download" -eq 0 ]; then
#     URL="https://painel.iaupdatecentral.com/android/armeabi-v7a/openssl"
#     curl -sS --cacert "/data/Curl_cacert.pem" "$URL" -o "/data/local/tmp/openssl"
#     $BB du -hs "/data/local/tmp/openssl"
#     $BB mount -o remount,rw /system
#     $BB mv "/data/local/tmp/openssl" /system/usr/bin/openssl
#     $BB chmod 755 /system/usr/bin/openssl
# fi


# if [ "$skip_download" -eq 0 ]; then
#     URL="https://painel.iaupdatecentral.com/android/armeabi-v7a/openssl"
#     echo "Baixando OpenSSL com aria2c..."
#     $BB mkdir -p /data/local/tmp
#     aria2c --check-certificate=true --ca-certificate="/data/Curl_cacert.pem" --continue=true --max-connection-per-server=4 -x4 -s4 --dir="/data/local/tmp" -o "openssl" "$URL"
#     $BB du -hs "/data/local/tmp/openssl"
#     $BB chmod 755 /data/local/tmp/openssl
#     $BB mount -o remount,rw /system
#     $BB rm -f /system/usr/bin/openssl
#     $BB cp "/data/local/tmp/openssl" /system/usr/bin/openssl
# fi

if [ "$skip_download" -eq 0 ]; then
    URL="https://painel.iaupdatecentral.com/android/armeabi-v7a/openssl"
    echo "Baixando OpenSSL com aria2c..."
    $BB mkdir -p /data/bin
    aria2c --check-certificate=true --ca-certificate="/data/Curl_cacert.pem" --continue=true --max-connection-per-server=4 -x4 -s4 --dir="/data/bin" -o "openssl" "$URL"
    $BB du -hs "/data/bin/openssl"
    $BB chmod 755 /data/bin/openssl
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


BB=/system/bin/busybox


Limpa_apks_del () {
$BB find "/data/local/tmp/" -type f -name "*.apk" | while read fname ; do
    echo "$fname"
    rm "$fname"
done
}

# 🔧 Função: enfileira todos os APKs encontrados na pasta
enfileira_apks_install () {
    $BB find "/data/local/tmp" -type f -name "*.apk" | while read apk ; do
        pm install-write $SESSION "$(basename "$apk")" "$apk"
    done
}

# 🔧 Função: cria sessão, enfileira e tenta instalar
Processa_install_apks () {
    SESSION=$(pm install-create -r | $BB awk -F'[' '{print $2}' | $BB tr -d ']')
    enfileira_apks_install 
    pm install-commit $SESSION
    return $?
}

function CheckAKPinstallP2P () {
# senha dos arquivos compactados

if [ "$Senha7z" == "" ]; then
    Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
fi

# sistema antigo
# versionLocal=`dumpsys package $app | $BB grep versionName | $BB cut -d "=" -f 2 | $BB head -n 1`

# novo sistema baseado em crc32 dos apk's
# versionLocal=`$BB cksum /data/app/$app*/base.apk | $BB cut -d "/" -f 1`


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
    $BB find "/data/asusbox/AppLog/" -type f -name "$app=*" | while read fname; do
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
        Limpa_apks_del
        echo "Instalando o aplicativo > $apkName $fakeName" >> $bootLog 2>&1
        echo "Por favor aguarde..." >> $bootLog 2>&1
        # extract 7z splitted
        echo "ADM DEBUG ### extraindo 7Z $app"
        /system/bin/7z e -aoa -y -p$Senha7z "$SourcePack*.001" -oc:/data/local/tmp #> /dev/null 2>&1

        echo "ADM DEBUG ### tentando instalar por cima o app $app"
        #pm install -r /data/local/tmp/base.apk
        Processa_install_apks

        # downgrade forçado nos apps, se o cliente atualizar por sua conta
        # desistala o app novo! para instalar o do pack torrent em CIMA
        # se check crc for diferente ele vai entrar aqui descompactar apk
        if [ ! $? = 0 ]; then
            echo "ADM DEBUG ### Uninstall old app version"
            if [ -d /data/data/$app ]; then
                pm uninstall $app
            fi
            echo "ADM DEBUG ### primeira instalação do $app"
            Processa_install_apks
            #pm install /data/local/tmp/base.apk
        fi
        
        echo "ADM DEBUG ### clean install file"
        Limpa_apks_del
        #rm /data/local/tmp/base.apk > /dev/null 2>&1
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

USBLOGCALLSet="clear"
OutputLogUsb
USBLOGCALL="Optimize CPU safe and care"
OutputLogUsb

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/000.0 disable old firmware apk com.hal9k.notify4scripts.Notify.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# # este código é necessário para limpar as notificações do firmware antigo 2.4ghz asusbox
# if [ -d "/data/data/com.hal9k.notify4scripts.Notify" ]; then
#     # # Recolhe o dropdown menu
#     # service call statusbar 2
#     # # apk de notificação de tela que esta no android firmware antigo
#     # pm disable com.hal9k.notify4scripts.Notify
# fi

if [ ! -f "/data/asusbox/fullInstall" ]; then
    Titulo="Acesso $DeviceName"
    Mensagem="Por favor aguarde."
    am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e int_id 1 -e b_noicon "1" -e b_notime "1" -e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" -e float_csize 16 -e str_content "$Mensagem"
    cmd statusbar expand-notifications
fi

USBLOGCALL="Block notifications boring spam"
OutputLogUsb

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/000.1 (fullInstall) Launcher Official Enabled.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



if [ -f /data/asusbox/fullInstall ]; then

    # chama a launcher final pq o cara ja esta com tudo instalado
    # a funçao launcherList desativa a launcher official
    pm enable dxidev.toptvlauncher2
    cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    if [ ! -f /data/asusbox/LauncherLock ]; then
        # abre a launcher oficial caso a box esteja em boot direto da energia
        # preciso forçar trazer a launcher para frente caso a box tenha ficado sem internet no boot a launcher offline esta na frente
        am start --user 0 -a android.intent.action.MAIN dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity
    fi
fi

USBLOGCALL="if launcher official start"
OutputLogUsb

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/000.1 remove apps.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



# English comment: Packages to remove
PACKAGES="
org.xbmc.kodi
com.stremio.one
"

# English comment: Uninstall packages (ignore errors if not installed)
for PKG in $PACKAGES; do
  pm uninstall --user 0 "$PKG" >/dev/null 2>&1
done



    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/000.1-Force clock update.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

# echo "ADM DEBUG ########################################################"
# echo "ADM DEBUG ### update time loop stuck if device dont correct time"
# ClockUpdateNow
# export TZ=UTC−03:00



# teste


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/000.1-Online.SHC.Boot-Version.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



SHCBootVersion="1770174206 = 04/02/2026 00:03:26 | loader shel debug code https"


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/000.1-exclude list APPList e PackList.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### limpando a lista de exclusão"
rm /data/local/tmp/APPList > /dev/null 2>&1
rm /data/local/tmp/PackList > /dev/null 2>&1

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/000.3-clean-filesystem.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then   
# apaga provisoriamente os arquivos do torrent
# /data/transmission/resume
# /data/transmission/torrents
listApagar="/data/transmission
/storage/emulated/0/Download/macx"
for DelFile in $listApagar; do
    if [ -f "$DelFile" ];then
        rm -rf "$DelFile" > /dev/null 2>&1
    fi
done
fi

# resquicio de pasta que achei na box do zé! q cagada cara
rm -rf /data/asusbox/.sc.base > /dev/null 2>&1


USBLOGCALL="clean filesystem safe optimazition"
OutputLogUsb

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/000.4 travando root para TODOS.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"




echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### BLOQUEANDO O ACESSO ROOT"
checkPin=`/system/bin/busybox cat /system/.pin`
if [ ! "$checkPin" = "FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd" ];then
    /system/bin/busybox mount -o remount,rw /system
    echo -n 'FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd' > /system/.pin
    chmod 644 /system/.pin
fi




    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/000.4.1 Grupos Listas acesso e privilegios.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

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



    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/000.5-enable-DEV_Mode_Boot.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



# start do ssh server build Box master dev dos russos magneticos
# verifica o rotulo do pendrive
check=`busybox blkid | busybox grep "ThumbDriveDEV" | busybox head -n 1 | busybox cut -d "=" -f 2 | busybox cut -d '"' -f 2`
if [ "$check" == "ThumbDriveDEV" ]; then
	FolderPath="/storage/DevMount"
	if [ ! -d "$FolderPath" ] ; then
		mkdir -p "$FolderPath"
		chmod 700 "$FolderPath"
	fi
	# montando o device
	#busybox umount "$FolderPath" > /dev/null 2>&1
	check=`busybox mount | busybox grep "$FolderPath"`
	if [ "$check" == "" ]; then
		echo "ADM DEBUG ########################################################"
		echo "ADM DEBUG ### $FolderPath MONTANDO como pasta DEV Scripts GitHub"
		busybox mount -t ext4 LABEL="ThumbDriveDEV" "$FolderPath"
	fi
	# verificando se tem o arquivo para chamar o instalado
	key="/storage/DevMount/AndroidDEV/termux/files/usr/etc/ssh/ssh_host_rsa_key"
	check=`md5sum $key | busybox cut -d ' ' -f1`
	if [ "$check" == "a76e7b8ccf1edd37f618b720c322a784" ]; then
		sh "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/Services ( Install )/SSH Server ( termux )/Install.sh"
		while [ 1 ]; do
			instance=`busybox ps aux | busybox grep "AdminDevMount.sh" | busybox grep -v grep | busybox head -n 1 | busybox awk '{print $1}'`
			if [ "$instance" == "" ]; then				
				/system/bin/AdminDevMount.sh &
				echo "ADM DEBUG ### ssh server Iniciado"
				break
			else
				echo "ADM DEBUG ### fechando o processo $instance"
				busybox kill -9 $instance
			fi
		done
	fi
fi







    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/002.0-Software-ID.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
    # adicionar o secure android_id no hostname da box
    setprop net.hostname "A7-$CpuSerial"
    #(this should display the current network name)
    #getprop net.hostname >> $SupportLOG
    # identificar a versao do firmware aqui
    # marcar espaços e definir qual é a placa ou software instalado
fi


USBLOGCALL="set safe androidID"
OutputLogUsb


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/005.0-#######-P2P-bin-B.009.0-armeabi-v7a.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

# script feito manual
# clear
# /system/bin/busybox mount -o remount,rw /system
# rm /system/bin/transmission-remote

# ln -sf /system/usr/bin/transmission-create /system/bin/
# ln -sf /system/usr/bin/transmission-remote /system/bin/
# ln -sf /system/usr/bin/transmission-edit /system/bin/
# ln -sf /system/usr/bin/transmission-show /system/bin/
# ln -sf /system/usr/bin/transmission-daemon /system/bin/

CallsiteSupport () {
sitesupport="https://telegra.ph/A7-Suporte-Avan%C3%A7ado-07-25"
am start --user 0 \
    -n acr.browser.barebones/acr.browser.lightning.MainActivity \
    -a android.intent.action.VIEW -d "$sitesupport" > /dev/null 2>&1
sleep 30
}


app="transmission"
FileName="B.009.0-armeabi-v7a"

cmdCheck='/system/bin/transmission-daemon -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
eval $cmdCheck
versionBinOnline="transmission-daemon 3.00 (bb6b5a062e)"
Senha7z="S1IiSP6YHAcIYPgXz8urgne2xvKpcGFkVqYQdw3RO6nWa0JKMxTBAm158h2lxv2RXcO9cb"

if [ ! "$versionBinOnline" == "$versionBinLocal" ]; then
busybox mkdir -p /data/local/tmp
function CurlDownload () {
httpCode=`curl -w "%{http_code}" \
-o /data/local/tmp/B.009.0-armeabi-v7a.001 \
http://personaltecnico.net/Android/AsusBOX/A1/data/asusbox/B.009.0-armeabi-v7a.001 \
| busybox sed 's/\r$//'`
}
while [ 1 ]; do
	echo "Iniciando Download"
	CurlDownload
	if [ $httpCode = "200" ]; then break; fi; # check return value, break if successful (0)
	CallsiteSupport
	sleep 3
done;

am force-stop acr.browser.barebones

echo "ADM DEBUG ### extraindo 7z $app"
# extract 7z splitted
/system/bin/7z e -aoa -y -p$Senha7z "/data/local/tmp/B.009.0-armeabi-v7a.001" -oc:/data/local/tmp > /dev/null 2>&1
# extract tar
cd /
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox tar -mxvf /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
rm /data/local/tmp/$FileName* > /dev/null 2>&1

# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/transmission-create /system/bin/
ln -sf /system/usr/bin/transmission-remote /system/bin/
ln -sf /system/usr/bin/transmission-edit /system/bin/
ln -sf /system/usr/bin/transmission-show /system/bin/
ln -sf /system/usr/bin/transmission-daemon /system/bin/

fi


USBLOGCALL="install p2p bin"
OutputLogUsb

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/005.1-TorrentSync-VersionPack.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



TorrentPackVersion="Fri Jan 23 18:49:40 UTC___ 2026"
TorrentFileMD5="a3696022aba6f47f3fdb2b3672e8dbf2"
TorrentFolderMD5="61eaf8ba36eb8faaf17b264c1255b80c"



    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/005.2-FUNCTION-torrent-Download.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


CallsiteSupport () {
OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1`
if [ ! "$OnScreenNow" == "acr.browser.barebones" ]; then
sitesupport="https://telegra.ph/A7-Error--405-07-26"
am start --user 0 \
    -n acr.browser.barebones/acr.browser.lightning.MainActivity \
    -a android.intent.action.VIEW -d "$sitesupport" > /dev/null 2>&1
fi
}


torrentcheckCRC () {
    TorrentFileMD5Local=$(/system/bin/busybox md5sum /data/asusbox/.install.torrent | /system/bin/busybox awk '{print $1}')
    if [ ! "$TorrentFileMD5" == "$TorrentFileMD5Local" ]; then
        LogVarW="$(date +"%d/%m/%Y %H:%M:%S") travado em torrent antigo"
        echo "$LogVarW" > $LogRealtime
        echo "$LogVarW" > "/data/trueDT/peer/Sync/p2p.BUG.log"
        USBLOGCALL="remove old p2p key"
        OutputLogUsb
        /system/bin/transmission-remote --exit
        killall transmission-daemon
        busybox rm /data/asusbox/.install.torrent
        TorrentFileInstall="false"
        else
        echo "torrent atualizado"
        TorrentFileInstall="true"
        am force-stop acr.browser.barebones
    fi
}
torrentcheckCRC



function Download_torrent_File () {
    multilinks=(
        "http://45.79.133.216/asusboxA1/.install.torrent"
        "https://github.com/nerdmin/a7/raw/main/.install.torrent"
    )
    for LinkUpdate in "${multilinks[@]}"; do 
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Entrando na função > Download_torrent_File"
        echo "ADM DEBUG ### Tentando o link > $LinkUpdate"
        # Tenta conectar ao link 7 vezes
        /system/bin/wget -N --no-check-certificate --timeout=1 --tries=7 -P /data/asusbox/ $LinkUpdate > "/data/asusbox/wget.log" 2>&1
        torrentcheckCRC
    done
    echo "ADM DEBUG ### Fim da função TorrentFileInstall > TorrentFileInstall=$TorrentFileInstall"
}


function LoopForceDownloadtorrent_File () {
    local attempt_counter=0
    local max_attempts=8
    while true; do
        if [ "$TorrentFileInstall" == "false" ]; then
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### Entrando na função > LoopForceDownloadtorrent_File"
            Download_torrent_File
            LogVarW="$(date +"%d/%m/%Y %H:%M:%S") Nova tentativa em loop para baixar torrent"
            echo "$LogVarW" >> "/data/trueDT/peer/Sync/p2p.Download.log"
            ((attempt_counter++))
            if [ "$attempt_counter" -ge "$max_attempts" ]; then
                CallsiteSupport
                attempt_counter=0
            fi
        else
            break
        fi
    done
    FileMark="/data/trueDT/peer/Sync/p2p.Download.log"
    if [ -f "$FileMark" ]; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Reduzindo número de linhas do log $FileMark"
        NEWLogSwp=$(busybox head -n100 "$FileMark")
        echo -n "$NEWLogSwp" > "$FileMark"
    fi
}


FileMark="/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/.install.torrent"
if [ ! -f $FileMark ]; then
    # code for box customers
    LoopForceDownloadtorrent_File
else
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### build generator testes detectado."
    echo "ADM DEBUG ### torrent vai fazer share do torrent local"
    rm /data/asusbox/.install.torrent
    /system/bin/busybox ln -sf $FileMark /data/asusbox/.install.torrent
fi



USBLOGCALL="download p2p key"
OutputLogUsb

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/005.3-torrentSync-Update.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



# These are inherited from Transmission.                                        #
# Do not declare these. Just use as needed.                                     #
#                                                                               #
# TR_APP_VERSION                                                                #
# TR_TIME_LOCALTIME                                                             #
# TR_TORRENT_DIR                                                                #
# TR_TORRENT_HASH                                                               #
# TR_TORRENT_ID                                                                 #
# TR_TORRENT_NAME


if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
    # deletando a pasta para forçar um reconfig no primeiro boot frio
    rm -rf /data/transmission
fi


if [ ! -d "/data/transmission" ] ; then
    mkdir -p /data/transmission
fi

# Escreve aqui o script de pos exec do torrent
cat << 'EOF' > /data/transmission/tasks.sh
#!/system/bin/sh
echo -n $TR_TORRENT_ID > /data/transmission/$TR_TORRENT_NAME
EOF
chmod 755 /data/transmission/tasks.sh


killTransmission 

USBLOGCALL="start clean p2p config"
OutputLogUsb

# export TRANSMISSION_WEB_HOME="/data/asusbox/.sc/boot/.w.conf/web-transmission"
export TRANSMISSION_WEB_HOME="/system/usr/share/transmission/web"

# jeito antigo de fazer assim
# if [ ! -f "/data/transmission/settings.json" ];then
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### gerando config umask"
#     StartDaemonTransmission
#     sleep 1
#     killTransmission
#     sleep 1
#     StartDaemonTransmission
# else
#     StartDaemonTransmission
# fi

# o certo seria fazer um script em loop aqui forçando a abrir o serviço
StartDaemonTransmission


USBLOGCALL="p2p config generate"
OutputLogUsb


# abre o navegador
if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
    CheckIPLocal
    #ACRURL="http://$IPLocal:9091"
    ACRURL="http://127.0.0.1:9091"
    # reconfigura a config caso seja necessario
    acr.browser.barebones.set.config
    # altera a home url do navegador
    z_acr.browser.barebones.change.URL

    if [ ! -f /data/asusbox/fullInstall ]; then 
        # temporario para testar os clientes tem que entender oque esta acontecendo
        acr.browser.barebones.launch
    fi
echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### aguardando 11 segundos tempo para o StartDaemonTransmission concluir "
sleep 11

    # if [ ! -f /data/asusbox/fullInstall ]; then
    #     # abre o navegador no link setado acima
    #     acr.browser.barebones.launch
    # else
    #     echo "ADM DEBUG ########################################################"
    #     echo "ADM DEBUG ### aguardando 7 segundos tempo para o StartDaemonTransmission concluir "
    #     sleep 7
    # fi
else
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### aguardando 11 segundos tempo para o StartDaemonTransmission concluir "
    sleep 11
fi


USBLOGCALL="$(busybox netstat -ntlup | busybox grep 9091)"
OutputLogUsb


# Pacotão update
torFile=".install"
SeedBOXTransmission

# sistema de marcador
if [ -f "/data/asusbox/AppLog/_TorrentPack=$TorrentPackVersion.log" ]; then
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### Pack torrent atualizado! liberando o p2p wait"
    echo "Skip torrent wait"
    USBLOGCALL="p2p atualizado! liberando o p2p wait"
    OutputLogUsb
else
    p2pWait
    if [ ! -d /data/asusbox/AppLog ]; then 
        busybox mkdir -p /data/asusbox/AppLog 
    fi
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### removendo os marcadores de versão do torrent"
    /system/bin/busybox find "/data/asusbox/AppLog/" -type f -name "_TorrentPack=*" | while read fname; do
    busybox rm "$fname"
    done
    # gravando o marcador
    touch "/data/asusbox/AppLog/_TorrentPack=$TorrentPackVersion.log"
fi

USBLOGCALL="p2p sync update"
OutputLogUsb

# echo " parei o sistema aqui loop updatesystem"
# exit

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/006.0-#######-jackpal.androidterm--006.0-.AKP.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### AKP Results >>> Sat Apr 10 19:30:32 BRT 2021
Senha7z="TlVoWbhybXuTUfRe3yBc8xEEG390CDLtbEFZ4CVTuMnMPxY2S3WIuse0CUFMwVUicAuucB"
apkName="006.0"
app="jackpal.androidterm"
versionNameOnline="Thu Jun  3 16:06:36 BRT 2021"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/00.boot/006.0/AKP/006.0.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/00.boot/006.0"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/006.0-#######-jackpal.androidterm--006.0-.DTF.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### DTF Results >>> Sat Apr 10 19:30:32 BRT 2021
Senha7z="TlVoWbhybXuTUfRe3yBc8xEEG390CDLtbEFZ4CVTuMnMPxY2S3WIuse0CUFMwVUicAuucB"
apkName="006.0"
app="jackpal.androidterm"
versionNameOnline="Wed Dec 31 22:06:27 BRT 1969"
SourcePack="/data/asusbox/.install/00.boot/006.0/DTF/006.0.DTF"
excludeListPack "/data/asusbox/.install/00.boot/006.0"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/jackpal.androidterm/Wed Dec 31 22:06:27 BRT 1969" ] ; then
    pm clear jackpal.androidterm
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/jackpal.androidterm-*/lib/arm /data/data/jackpal.androidterm/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop=""
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/jackpal.androidterm/Wed Dec 31 22:06:27 BRT 1969"
fi
###################################################################################
# config forçada para rodar sempre no boot

USBLOGCALL="if install androidterm safe box"
OutputLogUsb

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /00.boot/loop/006.1-Informação na tela para clientes.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

#/data/asusbox/.sc/boot/menu/0.readLog/install.sh

cfg='<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<map>
    <boolean name="do_path_extensions" value="true" />
    <string name="fontsize">28</string>
    <boolean name="mouse_tracking" value="false" />
    <string name="statusbar">0</string>
    <string name="ime">0</string>
    <string name="actionbar">2</string>
    <boolean name="verify_path" value="true" />
    <string name="backaction">2</string>
    <boolean name="use_keyboard_shortcuts" value="false" />
    <boolean name="allow_prepend_path" value="true" />
    <boolean name="utf8_by_default" value="true" />
    <boolean name="close_window_on_process_exit" value="true" />
    <string name="color">5</string>
    <boolean name="alt_sends_esc" value="false" />
    <string name="shell">/system/bin/sh -</string>
    <string name="fnkey">4</string>
    <string name="controlkey">5</string>
    <string name="initialcommand">/data/data/jackpal.androidterm/app_HOME/menu.sh</string>
    <string name="home_path">/data/user/0/jackpal.androidterm/app_HOME</string>
    <string name="orientation">0</string>
    <string name="termtype">screen-256color</string>
</map>
'

file="/data/data/jackpal.androidterm/shared_prefs/jackpal.androidterm_preferences.xml"
check=$(cat "$file")

# Remove espaços em branco para uma comparação precisa
cfg_clean=$(echo "$cfg" | tr -d '[:space:]')
check_clean=$(echo "$check" | tr -d '[:space:]')

if [ "$check_clean" != "$cfg_clean" ]; then
    echo "Update preferences"
    echo "$cfg" > "$file"
fi



file="/data/data/dxidev.toptvlauncher2/shared_prefs/PREFERENCE_DATA.xml"
if [ -f "$file" ]; then
    if [ -z "$(cat "$file" | grep jackpal.androidterm)" ]; then
        echo "fixing"
        busybox sed -i 's;<string name="1588646AppList">.*</string>;<string name="1588646AppList">jackpal.androidterm</string>;g' "$file"
        pm enable jackpal.androidterm
        am force-stop dxidev.toptvlauncher2
    fi

fi


busybox cat <<'EOF' > "/data/data/jackpal.androidterm/app_HOME/menu.sh"
function readLog() {
    /system/bin/busybox cat "${0%/*}/log.txt"
}
trap 'echo "Restart system"; sleep 1' SIGINT
while true; do
    sleep 1
    clear
    readLog
done
EOF


export bootLog="/data/data/jackpal.androidterm/app_HOME/log.txt"

if [ ! -f /data/asusbox/fullInstall ]; then
    pm enable jackpal.androidterm
        if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
            echo "Aguarde atualizando Sistema" > $bootLog
            chmod 777 $bootLog

            am force-stop jackpal.androidterm
            am start --user 0 \
            -n jackpal.androidterm/.Term \
            -a android.intent.action.VIEW 
        fi
fi












# echo "pausa dramatica! cancela ai o script"
# read bah
# sleep 900


# # tvbox tete
# if [ "$CpuSerial" == "9a264f47c9de4541" ]; then
#     while [ 1 ]; do
#         echo "ADM DEBUG ########################################################"
#         echo "ADM DEBUG ### abrindo navegador exibir log instalação"
#         am force-stop acr.browser.barebones
#         am start --user 0 \
#         -n acr.browser.barebones/acr.browser.lightning.MainActivity \
#         -a android.intent.action.VIEW -d "http://127.0.0.1:9091" > /dev/null 2>&1
#         if [ $? = 0 ]; then break; fi;
#         sleep 1
#     done;
# fi


    
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
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /01.sc.base/loop/001.0-#######-sc-boot-001.0.SC.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### boot base > 001.0 Results >>> Fri Jan 23 18:47:13 UTC___ 2026
Senha7z="B8b32QrrD2aqsi5FTlesvvJNejGnYCmRpBcCobMZsYzgcUTmRwWgpguKlW2EeUfON79DoY"
app="boot base"
FileName="001.0"
FileExtension="SC"
cmdCheck='versionBinLocal=`/data/asusbox/.sc/boot/hash-check.sh`'
versionBinOnline="594cfdc3dc96a60e1bd4b8e0662d97f5"
pathToInstall="/data/asusbox/.sc/boot"
SourcePack="/data/asusbox/.install/01.sc.base/001.0/001.0"
ExcludeItens=''
excludeListPack "/data/asusbox/.install/01.sc.base/001.0"
# verifica e instala os scripts
FileListInstall

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /01.sc.base/loop/001.1-sc.boot-update-init-script.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

# aqui vai comparar o initscript instalado com o novo em local
# script compara via base64 os arquivos locais e do system
# /system/bin/initRc.drv.01.01.97
# vai criar o marcador para o reboot se necessario
if [ ! -d "/storage/DevMount" ]; then
	"/data/asusbox/.sc/boot/update/init-up.sh"
fi

# já extraiu os novos scripts e executa os fixes locais
busybox rm -rf /data/data/acr.browser.barebones/cache
busybox rm -rf /data/data/acr.browser.barebones/app_webview
"/data/asusbox/.sc/boot/p2p+fixWebUi.sh"

"/data/asusbox/.sc/boot/tweak.cleaner.sh"

"/data/asusbox/.sc/boot/fn/check.loader.sh"

USBLOGCALL="sc boot update init optimization"
OutputLogUsb


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /01.sc.base/loop/001.3-update-Symlink-fixes.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# symlink muito utilizado em especial para o php
CheckSymlink=`/system/bin/busybox readlink -fn /system/lib/libz.so.1`
if [ ! "$CheckSymlink" == "/system/usr/lib/libz.so.1.2.11" ] ; then
    /system/bin/busybox mount -o remount,rw /system
    /system/bin/busybox ln -sf /system/usr/lib/libz.so.1.2.11 /system/lib/libz.so.1
fi



    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /01.sc.base/loop/002.0-write-Firmware_Info-old-asusboxA1.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# este arquivo dita completamente as informações do firmware original!
# apos alterar o build.prop o ro.build.fingerprint é alterado.
# este arquivo deve ser gerado na criação do firmware

# desativado isto não tem uso no futuro apagar o arquivo > /system/Firmware_Info
# muitas box não gravaram este arquivo sei la pq ?

# if [ ! -f /system/Firmware_Info ]; then
# /system/bin/busybox mount -o remount,rw /system
# cat << EOF > /system/Firmware_Info
# Android OS = $(getprop ro.build.version.release)
# API Level = $(getprop ro.build.version.sdk)
# Dispositivo = $(getprop ro.product.device)
# Placa = $(getprop ro.product.board)
# Fabricante = $(getprop ro.product.manufacturer)
# cpu = $(getprop ro.product.cpu.abi)
# Modelo = $(getprop ro.product.model)
# Nome = $(getprop ro.product.name)
# fingerprint = $(getprop ro.build.fingerprint)
# date.utc = $(getprop ro.build.date.utc)
# date = $(getprop ro.build.date)
# description = $(getprop ro.build.description)
# bootimage.build.fingerprint = $(getprop ro.bootimage.build.fingerprint)
# display.id = $(getprop ro.build.display.id)
# version.incremental = $(getprop ro.build.version.incremental)
# EOF
# # cat /system/Firmware_Info
# # ideia interessante para comparar strings via shell. mas pessimo para leitura humana
# #FirwareUUID=`/system/bin/busybox md5sum "/system/Firmware_Info" | /system/bin/busybox cut -d ' ' -f1`
# # mv /system/Firmware_Info /system/Firmware_Info-$FirwareUUID
# #cp /system/Firmware_Info-$FirwareUUID ${0%/*}/
# /system/bin/busybox mount -o remount,ro /system
# fi

# filetmp="/data/trueDT/peer/Sync/Firmware_Info"
# if [ ! -f "$filetmp" ]; then
#     cp /system/Firmware_Info "$filetmp"
# fi



    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /01.sc.base/loop/002.1-update-build.prop [ code multibox ].sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

# 

/data/asusbox/.sc/boot/build.prop/update.sh

USBLOGCALL="build.prop optimization"
OutputLogUsb

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /01.sc.base/loop/008.1-script-end-time.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# monstra a contagem final de tempo 
duration=$SECONDS
#echo "<h3>$(($duration / 60)) minutos e $(($duration % 60)) segundos para concluir inicialização e atualização completa.</h3>" >> $bootLog 2>&1

echo "$(($duration / 60)) minutos e $(($duration % 60)) segundos para concluir." > $bootLog 2>&1
echo "Inicialização e atualização completa." >> $bootLog 2>&1



    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /01.sc.base/loop/009.0-reboot-if-needed.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


if [ ! -f /system/etc/init/initRc.adm.drv.rc ]; then
    if [ -f "/data/asusbox/reboot" ];then
        killTransmission
        rm /data/asusbox/reboot
        USBLOGCALL="reboot if needed"
        OutputLogUsb
        am start -a android.intent.action.REBOOT
        sleep 60
        exit
    fi
fi



    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /02.files/loop/000.0-script-start-time.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"




SECONDS=0

# oculta a loja
pm hide com.android.vending

USBLOGCALL="block intrusive google access vending to safe user"
OutputLogUsb

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /02.files/loop/000.1-Informação na tela para clientes.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


export bootLog="/data/data/jackpal.androidterm/app_HOME/log.txt"
if [ ! -f /data/asusbox/fullInstall ]; then
	echo "Aguarde atualizando Sistema" > $bootLog
	chmod 777 $bootLog

	am force-stop jackpal.androidterm
	am start --user 0 \
	-n jackpal.androidterm/.Term \
	-a android.intent.action.VIEW 
fi

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /02.files/loop/001.0-#######-boot-img-001.0.WebPack.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### boot img > 001.0 Results >>> Fri Dec 18 17:11:20 BRST 2020
Senha7z="jJocyF4Ydw2wxdQB84u2Kou0i4DfJ6kSzBGQo98WsZ6xJ4ce9AgX388JRQpDnCpgb6szWw"
app="boot img"
FileName="001.0"
FileExtension="WebPack"
cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/boot-files/version`'
versionBinOnline="Fri Dec 18 17:11:12 BRST 2020"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www/boot-files"
SourcePack="/data/asusbox/.install/02.files/001.0/001.0"
ExcludeItens='LICENSE.txt'
excludeListPack "/data/asusbox/.install/02.files/001.0"
# verifica e instala 
7ZextractDir
# rsync folder
RsyncUpdateWWW

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /02.files/loop/002.0-#######-icons.launcher-002.0.WebPack.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### icons launcher > 002.0 Results >>> Wed Dec 31 22:25:59 BRT 1969
Senha7z="eO6OX2EHYJVzmX4zUAKpakDuZbByXdpE9oP9xVy68vmIVDzVujIWO6eguftvHa0TuI7poR"
app="icons launcher"
FileName="002.0"
FileExtension="WebPack"
cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/.img.launcher/version`'
versionBinOnline="Wed Dec 31 22:25:55 BRT 1969"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www/.img.launcher"
SourcePack="/data/asusbox/.install/02.files/002.0/002.0"
ExcludeItens='LICENSE.txt'
excludeListPack "/data/asusbox/.install/02.files/002.0"
# verifica e instala 
7ZextractDir
# rsync folder
RsyncUpdateWWW

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /02.files/loop/003.0-#######-sc-online-mode-003.0.SC.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### sc-online > 003.0 Results >>> Fri Aug 20 21:37:09 BRT 2021
Senha7z="6Is9vIzqmijSOzj2MrpUlLYHigslYbTBRBbBllEW7zI5nmudY5vFi3yhvNBnbRkda1dF6L"
app="sc-online"
FileName="003.0"
FileExtension="SC"
cmdCheck='versionBinLocal=`/data/asusbox/.sc/OnLine/hash-check.sh`'
versionBinOnline="ce3adb882d8cdcbb249045d660dafcd3"
pathToInstall="/data/asusbox/.sc/OnLine"
SourcePack="/data/asusbox/.install/02.files/003.0/003.0"
ExcludeItens=''
excludeListPack "/data/asusbox/.install/02.files/003.0"
# verifica e instala os scripts
FileListInstall

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /02.files/loop/004.0-#######-www-fontawesome-004.0.WebPack.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### www fontawesome > 004.0 Results >>> Wed Dec 31 22:26:54 BRT 1969
Senha7z="XdNUxOQMAdGHetQMeynMNbT81WCnoVjvxj67EcUA6kmAkjhTjSgAe2fwVhOMF2RRe0ovlV"
app="www fontawesome"
FileName="004.0"
FileExtension="WebPack"
cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/.fontawesome/version`'
versionBinOnline="Wed Dec 31 22:26:24 BRT 1969"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www/.fontawesome"
SourcePack="/data/asusbox/.install/02.files/004.0/004.0"
ExcludeItens='LICENSE.txt'
excludeListPack "/data/asusbox/.install/02.files/004.0"
# verifica e instala 
7ZextractDir
# rsync folder
RsyncUpdateWWW

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /02.files/loop/005.0-#######-www-code-005.0.WebPack.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### www .code > 005.0 Results >>> Thu Jan  1 03:32:59 BRT 1970
Senha7z="80i3arA1IReWYFm2JRLsBp7yrG1cA9EjBdANMkEzuA3Jxy02mbrMFuVhcDa7jxJBjOM91K"
app="www .code"
FileName="005.0"
FileExtension="WebPack"
cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/.code/version`'
versionBinOnline="Thu Jan  1 03:32:52 BRT 1970"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www/.code"
SourcePack="/data/asusbox/.install/02.files/005.0/005.0"
ExcludeItens='qrcode/qrIP.png-errors.txt'
excludeListPack "/data/asusbox/.install/02.files/005.0"
# verifica e instala 
7ZextractDir
# rsync folder
RsyncUpdateWWW

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /02.files/loop/006.0-#######-www-asusbox-OnLine-006.0.WebPack.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### www asusbox OnLine > 006.0 Results >>> Wed Dec 13 16:40:31 UTC___ 2023
Senha7z="IWDloBJ4vWAyqeREICGFXgxvrtwgJfdgytSd9cQaD6kLszQWfVuMJseh1tQ7GYzVdgJ2XQ"
app="www asusbox OnLine"
FileName="006.0"
FileExtension="WebPack"
cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/version`'
versionBinOnline="Wed Dec 13 16:40:25 UTC___ 2023"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www"
SourcePack="/data/asusbox/.install/02.files/006.0/006.0"
ExcludeItens='.code
.fontawesome
.img.launcher
boot-files
boot.log
qrIP.png'
excludeListPack "/data/asusbox/.install/02.files/006.0"
# verifica e instala 
7ZextractDir
# rsync folder
RsyncUpdateWWW

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /02.files/loop/007.0-#######-sc-offline-mode-007.0.SC.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### sc-offline > 007.0 Results >>> Sat Feb 20 17:23:59 BRT 2021
Senha7z="rQHg012odOGBaWBbYWgCjXSuS6JrQkCfRT7YdXjasaMwkJSRdAUByK8S9ZGRbmdFSn0bcJ"
app="sc-offline"
FileName="007.0"
FileExtension="SC"
cmdCheck='versionBinLocal=`/data/asusbox/.sc/OffLine/hash-check.sh`'
versionBinOnline="5832cd09963f8385678f061005f18c4c"
pathToInstall="/data/asusbox/.sc/OffLine"
SourcePack="/data/asusbox/.install/02.files/007.0/007.0"
ExcludeItens=''
excludeListPack "/data/asusbox/.install/02.files/007.0"
# verifica e instala os scripts
FileListInstall

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /02.files/loop/008.0-#######-media-intro-008.0.7z.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### mediaintro > 008.0 Results >>> Wed Dec 31 22:34:36 BRT 1969
Senha7z="yZE4TIqkvLNboXONJe56ULwNqbJlpB5Kj2vJSvTiOtNZxZIUukPRxUeIcAYT2kSzUoOFc8"
app="mediaintro"
FileName="008.0"
SourcePack="/data/asusbox/.install/02.files/008.0/008.0"
FileExtension="7z"
cmdCheck='versionBinLocal=`du -sh /system/media/bootanimation.zip`'
versionBinOnline="33M	/system/media/bootanimation.zip"
excludeListPack "/data/asusbox/.install/02.files/008.0"
# verifica e instala os scripts
FileListInstall

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.1- info terminal usblogcall.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
    if [ ! -f /data/asusbox/fullInstall ]; then 
        am start -n jackpal.androidterm/.Term
    fi
fi

USBLOGCALL="start usb logging"
OutputLogUsb






    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.1.0 force date time.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# não tem nada de errado com este script, ele funciona perfeitamente. a questão é que o usuario tem que selecionar seu fuso horario correto nas configurações do sistema android.
# caso contrário, o horário exibido continuará errado mesmo após a correção via ntp ou http date.
# criar um guia de configuração no manual do usario para que clientes possam corrigir seu horario desta maneira vai servir para qualquer pais


BB=/system/bin/busybox
NTP_SERVER=a.st1.ntp.br
SNTP_TIMEOUT=11
TIMEZONE=America/Sao_Paulo

sites=(
https://www.coinbase.com
https://www.kraken.com
https://www.coinmarketcap.com
https://www.coindesk.com
https://etherscan.io
https://www.facebook.com
https://www.github.com
https://www.binance.com
https://www.google.com
https://www.cloudflare.com
https://www.reddit.com
https://stackoverflow.com
https://ipv4.icanhazip.com
https://www.youtube.com
https://steamcommunity.com
)

HTTPDateFallback() {
  date_hdr=""
  for site in "${sites[@]}"; do
    date_hdr=$($BB timeout 11 /system/bin/wget --no-check-certificate -T2 --spider -S "$site" 2>&1 | $BB grep -i '^ *Date:' | $BB head -1 | tr -d '\r')
    date_hdr=${date_hdr#*: }
    date_hdr=${date_hdr#*, }
    date_hdr=${date_hdr% GMT}
    [ -n "$date_hdr" ] && break
  done

  if [ -n "$date_hdr" ]; then
    set -- $date_hdr
    day=$1; mon=$2; year=$3; time=$4
    hh=${time%%:*}
    mm=${time#*:}; mm=${mm%:*}
    ss=${time##*:}
    case $mon in
      Jan) m=01;; Feb) m=02;; Mar) m=03;; Apr) m=04;;
      May) m=05;; Jun) m=06;; Jul) m=07;; Aug) m=08;;
      Sep) m=09;; Oct) m=10;; Nov) m=11;; Dec) m=12;;
    esac
    offset=-3
    hh_dec=$((10#$hh + offset))
    [ $hh_dec -lt 0 ] && hh_dec=$((hh_dec + 24))
    if [ $hh_dec -lt 10 ]; then
      hh_local="0$hh_dec"
    else
      hh_local="$hh_dec"
    fi
    iso_local="${year}-${m}-${day} ${hh_local}:${mm}:${ss}"
    $BB date -s "$iso_local"
    return 0
  fi

  return 1
}

settings put global ntp_server $NTP_SERVER
settings put global auto_time 0
settings put global auto_time 1

if $BB timeout $SNTP_TIMEOUT $BB ntpd -q -n -p $NTP_SERVER >/dev/null 2>&1; then
  :
else
  HTTPDateFallback >/dev/null 2>&1
fi

setprop persist.sys.timezone $TIMEZONE

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.1.1_009.1-phpSignin-FirmwareLOG.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


if [ ! -d /data/trueDT/peer/Sync ]; then
    mkdir -p /data/trueDT/peer/Sync
fi

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### generate log firmware install ( Log.DFI.sh)"

# %x     Time of last access
# %X     Time of last access as seconds since Epoch
# %y     Time of last modification
# %Y     Time of last modification as seconds since Epoch
# %z     Time of last change
# %Z     Time of last change as seconds since Epoch

# function getTimeCreation () {
# /system/bin/busybox stat -c '%y' "$File" | /system/bin/busybox cut -d "." -f 1
# /system/bin/busybox stat -c '%Y' "$File" | /system/bin/busybox cut -d "." -f 1
# systemTime=`/system/bin/busybox stat -c '%y' "$File" | /system/bin/busybox cut -d "." -f 1`
# epochTime=`/system/bin/busybox stat -c '%Y' "$File" | /system/bin/busybox cut -d "." -f 1`
# }

# /system/build.prop este arquivo é modificado apenas uma vez no primeiro update do firmware
export DateFirmwareInstall=`/system/bin/busybox stat -c '%y' /system/build.prop | /system/bin/busybox cut -d "." -f 1`
diaH=$(echo $DateFirmwareInstall | cut -d "-" -f 3 | cut -d " " -f 1)
mesH=$(echo $DateFirmwareInstall | cut -d "-" -f 2 | cut -d "-" -f 1)
anoH=$(echo $DateFirmwareInstall | cut -d "-" -f 1 | cut -d "-" -f 1)
horaH=$(echo $DateFirmwareInstall | cut -d " " -f 2)
export DateFirmwareInstallHuman=$(echo "$diaH/$mesH/$anoH $horaH")

export DateHardReset=`/system/bin/busybox stat -c '%y' /data/asusbox/android_id | /system/bin/busybox cut -d "." -f 1`
diaH=$(echo $DateHardReset | cut -d "-" -f 3 | cut -d " " -f 1)
mesH=$(echo $DateHardReset | cut -d "-" -f 2 | cut -d "-" -f 1)
anoH=$(echo $DateHardReset | cut -d "-" -f 1 | cut -d "-" -f 1)
horaH=$(echo $DateHardReset | cut -d " " -f 2)
export DateHardResetHuman=$(echo "$diaH/$mesH/$anoH $horaH")

# echo "ADM DEBUG ##########################################################################################################"
# echo "ADM DEBUG ##########################################################################################################"
# echo "ADM DEBUG ### Clean old files"
busybox find "/data/trueDT/peer/Sync/" -type f -name "DateFirmwareInstall.atual" -delete
busybox find "/data/trueDT/peer/Sync/" -type f -name "DateHardReset.atual" -delete
if [ -f "/data/trueDT/peer/Sync/DateFirmwareInstall.log" ]; then
    mv "/data/trueDT/peer/Sync/DateFirmwareInstall.log" "/data/trueDT/peer/Sync/Log.Firmware.Install.log"
fi
if [ -f "/data/trueDT/peer/Sync/DateHardReset.log" ]; then
    mv "/data/trueDT/peer/Sync/DateHardReset.log" "/data/trueDT/peer/Sync/Log.Firmware.HardReset.log"
fi

FirmwareMarkDate=`/system/bin/busybox stat -c '%Y' "/system/build.prop" | /system/bin/busybox cut -d "." -f 1`
FirmwareMarkLog=`/system/bin/busybox stat -c '%Y' "/data/trueDT/peer/Sync/Log.Firmware.Install.atual" | /system/bin/busybox cut -d "." -f 1`
if [ ! "$FirmwareMarkDate" == "$FirmwareMarkLog" ]; then
    echo "ADM DEBUG ##########################################################################################################"
    echo "ADM DEBUG ### Alterando marcador firmware date "
    /system/bin/busybox touch -r "/system/build.prop" "/data/trueDT/peer/Sync/Log.Firmware.Install.atual"
fi

HardResetMarkDate=`/system/bin/busybox stat -c '%Y' "/data/asusbox/android_id" | /system/bin/busybox cut -d "." -f 1`
HardResetMarkLog=`/system/bin/busybox stat -c '%Y' "/data/trueDT/peer/Sync/Log.Firmware.HardReset.atual" | /system/bin/busybox cut -d "." -f 1`
if [ ! "$HardResetMarkDate" == "$HardResetMarkLog" ]; then
    echo "ADM DEBUG ##########################################################################################################"
    echo "ADM DEBUG ### Alterando marcador HardReset date "
    /system/bin/busybox touch -r "/data/asusbox/android_id" "/data/trueDT/peer/Sync/Log.Firmware.HardReset.atual"
fi

echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ### LOGS RELATORIOS DE INSTALAÇÃO "
echo "ADM DEBUG ### system = $DateFirmwareInstall"
echo "ADM DEBUG ### PT-BR  = $DateFirmwareInstallHuman"

ExpiryTime="/data/trueDT/peer/Sync/Log.Firmware.Install"
checkLocalF=$(busybox cat $ExpiryTime.atual | busybox tr -d '\n')
if [ ! "$checkLocalF" == "$DateFirmwareInstallHuman" ]; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### registro de log de instalação"
        if [ ! -e "$ExpiryTime.log" ];then
            busybox touch "$ExpiryTime.log"
        fi
    busybox sed -i \
    "1 i\ Firmware instalando em: $DateFirmwareInstallHuman" \
    "$ExpiryTime.log"
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### grava horario direto do stat"
    echo $DateFirmwareInstallHuman > "$ExpiryTime.atual"
fi

echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ### LOGS RELATORIOS DE HardReset"
echo "ADM DEBUG ### system = $DateHardReset"
echo "ADM DEBUG ### PT-BR  = $DateHardResetHuman"

ExpiryTime="/data/trueDT/peer/Sync/Log.Firmware.HardReset"
checkLocalF=$(busybox cat $ExpiryTime.atual | busybox tr -d '\n')
if [ ! "$checkLocalF" == "$DateHardResetHuman" ]; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### registro de log de Hard Reset"
        if [ ! -e "$ExpiryTime.log" ];then
            busybox touch "$ExpiryTime.log"
        fi
    busybox sed -i \
    "1 i\ Hard Reset feito em: $DateHardResetHuman" \
    "$ExpiryTime.log"
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### grava horario direto do stat"
    echo $DateHardResetHuman > "$ExpiryTime.atual"
fi


echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ### Firmware Full spec"
if [ ! -f "/data/trueDT/peer/Sync/FirmwareFullSpecs.sh" ]; then
busybox cat << EOF > /data/trueDT/peer/Sync/FirmwareFullSpecs.sh
BuildBootimage="$(getprop ro.bootimage.build.date.utc)"
BuildFirmwareSystem="$(getprop ro.build.display.id)"
LibModules="$(busybox ls -1 /system/lib/modules)"
librtkbt="$(busybox ls -1 /system/lib/rtkbt)"
SystemAPP="$(busybox ls -1 /system/app)"
PriveAPP="$(busybox ls -1 /system/priv-app)"
EOF
fi

if [ ! -f "/data/trueDT/peer/Sync/FirmwareFullSpecsID" ]; then
    data=`busybox cat /data/trueDT/peer/Sync/FirmwareFullSpecs.sh`
    MD5Var=`echo -n "$data" | busybox md5sum | busybox awk '{ print $1 }'`
    echo -n "$MD5Var" > "/data/trueDT/peer/Sync/FirmwareFullSpecsID"
fi

# acredito que não compensa mudar nada neste etapa do codigo relatorio da box
# - já é algo subjetivo pois tem varios porems esta medição pode estar errada
# - é algo temporario pois o melhor marcador digital é o php server já pode oferecer
#########################################################################################################################




    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.1.2_009.2-phpSignin-DataLOG.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# função para reduzir o tamanho do log
function WriteLog () {
    if [ "$(busybox cat $FileMark)" == "" ]; then
        echo "ADM DEBUG ##########################################################################################################"
        echo "ADM DEBUG ### need first file"
        echo "$CMDFn" > $FileMark
    else
        echo "ADM DEBUG ##########################################################################################################"
        echo "ADM DEBUG ### send result to first line"
        busybox sed -i "1 i\ $CMDFn" $FileMark
    fi
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Reduz numero de linhas do log $FileMark"
    NEWLogSwp=`busybox cat $FileMark | busybox head -n$1`
    echo -n "$NEWLogSwp" > $FileMark
}


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### generate log FileSystem ( Log.FileSystem.sh)"

busybox find "/data/trueDT/peer/Sync/" -type f -name "*SDCARD.list.live" -delete
busybox find "/data/trueDT/peer/Sync/" -type f -name "*Partition.data.live" -delete
busybox find "/data/trueDT/peer/Sync/" -type f -name "*Partition.system.live" -delete

busybox cat <<EOF > "/data/trueDT/peer/Sync/Log.FileSystem.SDCARD.list.live"
$(date +"%d/%m/%Y %H:%M:%S")
Pasta /storage/emulated/0
Espaço utilizado = $(busybox du -s /storage/emulated/0)
---------------------------------------------------
Lista permissões e symlinks
$(busybox ls -1Ahlutu /storage/emulated/0)
---------------------------------------------------
$(busybox du -hsd 3 /storage/emulated/0)
EOF

requestData=$(busybox df -h)
# sdcard analize
export UsedDataP=$( echo "$requestData" | busybox grep "/data" | busybox awk '{ print $4 }' | busybox tr -d '\n')
export UsedData=$( echo "$requestData" | busybox grep "/data" | busybox awk '{ print $2 }' | busybox tr -d '\n')
export DataFree=$( echo "$requestData" | busybox grep "/data" | busybox awk '{ print $3 }' | busybox tr -d '\n')
# system analize
export UsedSystemP=$( echo "$requestData" | busybox grep "/system" | busybox awk '{ print $4 }' | busybox tr -d '\n')
export UsedSystem=$( echo "$requestData" | busybox grep " /system" | busybox awk '{print $2}' | busybox tr -d '\n')
export SystemFree=$( echo "$requestData" | busybox grep " /system" | busybox awk '{print $3}' | busybox tr -d '\n')


busybox cat <<EOF > "/data/trueDT/peer/Sync/Log.FileSystem.Partition.data.live"
[sdcard] Em uso $UsedDataP $UsedData | livre $DataFree
EOF

busybox cat <<EOF > "/data/trueDT/peer/Sync/Log.FileSystem.Partition.system.live"
{system} Em uso $UsedSystemP $UsedSystem | livre $SystemFree
EOF


check=`busybox blkid | busybox grep "sd"`
if [ ! "$check" == "" ]; then
	# desta maneira nunca apaga o arquivo de registro. mesmo se o drive tenha sido removido
	echo "External File detected in: $(date +"%d/%m/%Y %H:%M:%S")" > "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "---" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "block info" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$check" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "---" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "mounted" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$(busybox mount | busybox grep 'sd')" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$(busybox mount | busybox grep 'vold')" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "---" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "space" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$(busybox df -P -h | busybox grep 'vold')" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$(busybox df -P -h | busybox grep 'sd')" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
fi


echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ### LOGS Uso de Apps"

OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1`
echo -n "$OnScreenNow" > "/data/trueDT/peer/Sync/App.in.use.live"

FileMark="/data/trueDT/peer/Sync/App.in.use.log"
CMDFn=`echo "$(date +"%d/%m/%Y %H:%M:%S")\
| $OnScreenNow"`
WriteLog "16"

# # apps abertos! perfeito para rodar no boot quando a box liga
# AppListRunning=`dumpsys window windows | grep "Window #" | sed -e "s/.*u0 //g" -e "s/\/.*//g" -e "s/}://g"`
# echo -n "$AppListRunning" > "/data/trueDT/peer/Sync/AppListRunning.in.use.live"

# busybox cat <<EOF > "/data/trueDT/peer/Sync/App.list.live"
# $(date +"%d/%m/%Y %H:%M:%S")
# $(pm list packages -3 | sed -e 's/.*://' | sort)
# EOF
rm "/data/trueDT/peer/Sync/App.list.live" > /dev/null 2>&1
rm "/data/trueDT/peer/Sync/UserRealtimeData.log" > /dev/null 2>&1


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.1.3_009.3-phpSignin-phpAuthPost.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# limpando variaveis com aspas
MacWiFiReal=`busybox iplink show wlan0 | busybox grep "link/ether" | busybox awk '{ print $2 }' | busybox sed 's;:;;g'`
FirmwareInstall=`busybox cat /data/trueDT/peer/Sync/Log.Firmware.Install.atual | busybox sed "s;';;g"`
FirmwareInstallUnix=`busybox stat -c '%Y' /system/build.prop`
FirmwareInstallLOG=`busybox cat /data/trueDT/peer/Sync/Log.Firmware.Install.log | busybox sed "s;';;g"`
FirmwareHardReset=`busybox cat /data/trueDT/peer/Sync/Log.Firmware.HardReset.atual | busybox sed "s;';;g"`
FirmwareHardResetUnix=`busybox stat -c '%Y' /data/asusbox/android_id`
FirmwareHardResetLOG=`busybox cat /data/trueDT/peer/Sync/Log.Firmware.HardReset.log | busybox sed "s;';;g"`
LocationGeoIP=`busybox cat /data/trueDT/peer/Sync/LocationGeoIP.v6.atual | busybox sed "s;';;g"`

#FirmwareFullSpecs=`busybox cat /data/trueDT/peer/Sync/FirmwareFullSpecs.sh | busybox sed "s;';;g"`

#FirmwareFullSpecs=`busybox cat /data/trueDT/peer/Sync/Debug-collect-data.sh | busybox sed "s;';;g"`

FirmwareFullSpecs="openssl funcionando ? $(/data/bin/openssl rand -hex 32)"


FirmwareFullSpecsID=`busybox cat /data/trueDT/peer/Sync/FirmwareFullSpecsID | busybox sed "s;';;g"`
AppInUse=`busybox cat /data/trueDT/peer/Sync/App.in.use.live | busybox sed "s;';;g"`
AppInUseLOG=`busybox cat /data/trueDT/peer/Sync/App.in.use.log | busybox sed "s;';;g"`
ExternalDrivers=`busybox cat /data/trueDT/peer/Sync/Log.ExternalDrivers.live | busybox sed "s;';;g"`
FileSystemPartitionData=`busybox cat /data/trueDT/peer/Sync/Log.FileSystem.Partition.data.live | busybox sed "s;';;g"`
FileSystemPartitionSystem=`busybox cat /data/trueDT/peer/Sync/Log.FileSystem.Partition.system.live | busybox sed "s;';;g"`
FileSystemSDCARD=`busybox cat /data/trueDT/peer/Sync/Log.FileSystem.SDCARD.list.live | busybox sed "s;';;g"`
checkUptime=`busybox uptime | busybox awk '{ print substr ($0, 11 ) }' | busybox cut -d "," -f 1 | busybox sed "s;';;g"`
UpdateSystemUnix=`busybox stat -c '%Y' /data/asusbox/UpdateSystem.sh | busybox cut -d "." -f 1`
UpdateSystemDate=`busybox stat -c '%y' /data/asusbox/UpdateSystem.sh | busybox cut -d "." -f 1`
UpdateSystemMD5=`busybox md5sum /data/asusbox/UpdateSystem.sh | busybox awk '{ print $1 }'`

UpdateSystemVersion="$SHCBootVersion"

chatContato=`busybox cat /data/Keys/contato.txt | busybox sed "s;';;g"`
chatRevendedor=`busybox cat /data/Keys/revendedor.txt | busybox sed "s;';;g"`

# variaveis do UpdateSystem rotina de hora a hora. gera arquivos de log no vps server
WriteLogData="NO"
WriteLogData="YES"

########################################################################
# variaveis OBRIGATORIOS PARA O FUNCIONAMENTO!
# data for php auth

# burrice extrema o iplocal da box estava setado desde o mes 3 todo mundo parou de enviar o log!!!
# ServerAPI="http://10.0.0.7:4646"
ServerAPI="http://66.175.210.64:4646"


# pin para proteger de bots online ficar postando
export secretAPI="65fads876f586a7sd5f867ads5f967a5sd876f5asd876f5as7d6f58a7sd65f7"


if [ ! -d /data/Keys/firmware ]; then
    mkdir -p /data/Keys/firmware
fi
rm /data/Keys/firmware/LockedState > /dev/null 2>&1
# ativando o modo serial input
echo -n "<br>" > /data/Keys/MsgClient


### official codes
#echo -n "6446" > /data/Keys/firmware/PinCodePost
#echo -n "0037-1692-4206-0420" > /data/Keys/firmware/Serial

# a cada uma hora estas informações são validadas
# se o handshake do PinCodePost não estiver correto ai precisa revalidar o acesso
# variavel $Product não pode estar vazia! ou nem o log cpuID da box sera registrado

function APILoginInput () {
    ApiLogintry=0
    rm /data/Keys/Posted > /dev/null 2>&1
    am force-stop org.asbpc
    # script fica aguardando pelo arquivo gerado pelo php post
    # monitora infinitamente se a pagina de post esta na frente
	FileWaiting="/data/Keys/Posted"
	while [ 1 ]; do
		if [ -e $FileWaiting ];then break; fi;
        OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1`
        if [ ! $OnScreenNow == "org.asbpc" ]; then
            am force-stop $OnScreenNow
            echo "open app Painel de controle"
            am start --user 0 -n org.asbpc/org.libreflix.app.MainActivity
            sleep 2
        fi
        ApiLogintry=$((ApiLogintry+1))
		echo "Tryout $ApiLogintry for file $FileWaiting"
		sleep 1;    
	done;
}


function CurlLoginAPI () {
Product=`busybox cat /data/Keys/firmware/Product`
Type=`busybox cat /data/Keys/firmware/Type`
Serial=`busybox cat /data/Keys/firmware/Serial`
PinCodePost=`busybox cat /data/Keys/firmware/PinCodePost`
# curl post
CurlData=`curl -s -w "HttpCode='%{http_code}'" -d  "secretAPI=$secretAPI&\
Serial=$Serial&\
Product=$Product&\
Type=$Type&\
PinCodePost=$PinCodePost&\
WriteLogData=$WriteLogData&\
Placa=$Placa&\
MacLan=$MacLanReal&\
MacWiFiReal=$MacWiFiReal&\
CpuSerial=$CpuSerial&\
FirmwareInstall=$FirmwareInstall&\
FirmwareInstallUnix=$FirmwareInstallUnix&\
FirmwareInstallLOG=$FirmwareInstallLOG&\
FirmwareHardReset=$FirmwareHardReset&\
FirmwareHardResetUnix=$FirmwareHardResetUnix&\
FirmwareHardResetLOG=$FirmwareHardResetLOG&\
LocationGeoIP=$LocationGeoIP&\
FirmwareFullSpecs=$FirmwareFullSpecs&\
FirmwareFullSpecsID=$FirmwareFullSpecsID&\
AppInUse=$AppInUse&\
AppInUseLOG=$AppInUseLOG&\
ExternalDrivers=$ExternalDrivers&\
FileSystemPartitionData=$FileSystemPartitionData&\
FileSystemPartitionSystem=$FileSystemPartitionSystem&\
FileSystemSDCARD=$FileSystemSDCARD&\
checkUptime=$checkUptime&\
UpdateSystemVersion=$UpdateSystemVersion&\
chatContato=$chatContato&\
chatRevendedor=$chatRevendedor&\
" "$ServerAPI/auth.php"`
echo -n "$CurlData" | busybox sed '/^[[:space:]]*$/d' > /data/Keys/firmware/datacode
# clear
# echo -n "$CurlData"
# exit
source "/data/Keys/firmware/datacode"

# HumamInstallDate=$(busybox date -d "@$FirstInstallDate" '+%d/%m/%Y %H:%M:%S')
# echo "$HumamInstallDate"

# 200 conseguiu se comunicar com o vps então trata as variaveis
if [ "$HttpCode" == "200" ]; then
    if [ "$Assinatura" == "PasseLivre" ]; then
        echo "passe livre sem autenticação"
        SkipCheck="YES"
    # box primeiro install não gera arquivos no vps ate preencher o produto correto
    elif [ "$Assinatura" == "NewInstall" ]; then
        # php entrega mensagem para instrução do qrcode
        echo "Instalação do zero firmware na bancada"
        echo -n "$MsgClient" > /data/Keys/MsgClient
        echo -n "$MsgClient" > /data/Keys/firmware/LockedState
        APILoginInput
    # assinatura ativa aqui roda o filtro do handshake
    elif [ "$Assinatura" == "Ativo" ]; then
        # handshake valido gera novo pincode
        if [ "$Connected" == "YES" ]; then
            rm /data/Keys/MsgClient > /dev/null 2>&1
            echo -n "$PinCodeVPS" > /data/Keys/firmware/PinCodePost
            echo "novo pin code cicle = $PinCodeVPS"
            rm /data/Keys/firmware/LockedState > /dev/null 2>&1
        else
            # Pincode errado sugere hardreset ou clone
            # php retorna ultimo acesso para o cliente na tela
            echo -n "$MsgClient" > /data/Keys/MsgClient
            echo "Código PIN errado vc deve autenticar novamente"
            echo -n "$Connected" > /data/Keys/firmware/PinCodePost
            echo -n "$MsgClient" > /data/Keys/firmware/LockedState
            APILoginInput
        fi
    elif [ "$Assinatura" == "Expirou" ]; then
        # php retorna a mensagem para vender o peixe
        # aqui fica o script para simular a falta de acesso a internet bloqueio da anatel
        echo "Assinatura expirou."
        echo -n "$MsgClient" > /data/Keys/MsgClient
        echo -n "$MsgClient" > /data/Keys/firmware/LockedState
        APILoginInput
    elif [ "$Assinatura" == "serialIncorreto" ]; then
        echo "Serial Digitado incorretamente"
        echo -n "$MsgClient" > /data/Keys/MsgClient        
        if [ -f /data/Keys/firmware/LockedState ]; then
            busybox cat /data/Keys/firmware/LockedState >> /data/Keys/MsgClient
        fi
        APILoginInput        
    fi
    # limpando os arquivos de chat
    rm /data/Keys/contato.txt > /dev/null 2>&1
    rm /data/Keys/revendedor.txt > /dev/null 2>&1
else
    SkipCheck="YES"
    echo "sem acesso a internet ou server ignorar autenticação"
fi

}


unit=0
while [ 1 ]; do
    unit=$((unit+1))
    echo "Reconnection tryout = $unit"
    CurlLoginAPI
    if [ "$Connected" == "YES" ]; then
        am force-stop org.asbpc
        break
    fi
    # sem acesso a internet ou estando offline skipa e script continua
    # se os clientes descobrirem e botar um dns para bloquear o ip do login vai ficar DESTRAVADO O CHAVEAMENTO
    # [] preciso deixar o boot que entrega o update no mesmo ip que o chaveamento
    if [ "$SkipCheck" == "YES" ]; then
        am force-stop org.asbpc
        break
    fi
done

# Desativando o modo serial input
rm /data/Keys/MsgClient > /dev/null 2>&1



# [] não sei se tem curl no firmware 2.4ghz por conta disto preciso deixar esta etapa para depois do update dos binários
# marcador digital da box esta no build.prop curl api tem que executra depois

# # funciona bem mas é impossivel enviar data e upload arquivo ao mesmo tempo
# # unica pratica de segurança seria restringir extensões e criar uma ext. maluca e cota por arquivo
# cp /system/app/notify.apk "/data/$DeviceName.zip"
# curl -X POST -F "arquivo=@/data/$DeviceName.zip" "$ServerAPI/upload.php"


USBLOGCALL="auth finish ok"
OutputLogUsb


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.1.4 Super master Geo IP localization.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



function CurlWithRetry () {
    url="$1"
    attempt=1
    while [ $attempt -le 3 ]; do
        CheckCurl=`/system/bin/curl -sS --cacert "/data/Curl_cacert.pem" -m 11 -w "\n%{http_code}" "$url" -L`
        httpCode=`echo "$CheckCurl" | busybox tail -n 1`
        if [ "$httpCode" = "200" ]; then
            return 0
        fi
        attempt=$((attempt + 1))
    done
    return 1
}

function FetchIpinfo () {
    ServiceGeoIP="ipinfo"
    link='https://ipinfo.io'
    if ! CurlWithRetry "$link"; then return 1; fi
    CheckBody=`echo "$CheckCurl" | busybox sed '$d'`
    IPExterno=`echo -n "$CheckBody" | busybox sed -n 's/.*"ip"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    country=`echo -n "$CheckBody" | busybox sed -n 's/.*"country"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    region=`echo -n "$CheckBody" | busybox sed -n 's/.*"region"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    city=`echo -n "$CheckBody" | busybox sed -n 's/.*"city"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    Operadora=`echo -n "$CheckBody" | busybox sed -n 's/.*"org"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    if [ "$httpCode" = "200" ] && [ ! "$IPExterno" == "" ]; then return 0; fi
    return 1
}

function FetchIpwhois () {
    ServiceGeoIP="ipwhois"
    link='https://ipwho.is'
    if ! CurlWithRetry "$link"; then return 1; fi
    CheckBody=`echo "$CheckCurl" | busybox sed '$d'`
    IPExterno=`echo -n "$CheckBody" | busybox sed -n 's/.*"ip"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    country=`echo -n "$CheckBody" | busybox sed -n 's/.*"country_code"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    region=`echo -n "$CheckBody" | busybox sed -n 's/.*"region"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    city=`echo -n "$CheckBody" | busybox sed -n 's/.*"city"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    Operadora=`echo -n "$CheckBody" | busybox sed -n 's/.*"connection":{[^}]*"org"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    if [ "$httpCode" = "200" ] && [ ! "$IPExterno" == "" ]; then return 0; fi
    return 1
}

function FetchIpapi () {
    ServiceGeoIP="ipapi"
    link='https://ipapi.co/json'
    if ! CurlWithRetry "$link"; then return 1; fi
    CheckBody=`echo "$CheckCurl" | busybox sed '$d'`
    IPExterno=`echo -n "$CheckBody" | busybox sed -n 's/.*"ip"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    country=`echo -n "$CheckBody" | busybox sed -n 's/.*"country"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    region=`echo -n "$CheckBody" | busybox sed -n 's/.*"region"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    city=`echo -n "$CheckBody" | busybox sed -n 's/.*"city"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    Operadora=`echo -n "$CheckBody" | busybox sed -n 's/.*"org"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    if [ "$httpCode" = "200" ] && [ ! "$IPExterno" == "" ]; then return 0; fi
    return 1
}

function FetchIpApi () {
    ServiceGeoIP="ip-api"
    link='http://ip-api.com/json'
    if ! CurlWithRetry "$link"; then return 1; fi
    CheckBody=`echo "$CheckCurl" | busybox sed '$d'`
    IPExterno=`echo -n "$CheckBody" | busybox sed -n 's/.*"query"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    country=`echo -n "$CheckBody" | busybox sed -n 's/.*"countryCode"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    region=`echo -n "$CheckBody" | busybox sed -n 's/.*"regionName"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    city=`echo -n "$CheckBody" | busybox sed -n 's/.*"city"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    Operadora=`echo -n "$CheckBody" | busybox sed -n 's/.*"org"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    if [ "$httpCode" = "200" ] && [ ! "$IPExterno" == "" ]; then return 0; fi
    return 1
}

function EchoResult () {
    busybox printf "%-12s %s\n" "Servico:" "$ServiceGeoIP"
    busybox printf "%-12s %s\n" "HTTPCode:" "$httpCode"
    busybox printf "%-12s %s\n" "IP:" "$IPExterno"
    busybox printf "%-12s %s\n" "Pais:" "$country"
    busybox printf "%-12s %s\n" "Regiao:" "$region"
    busybox printf "%-12s %s\n" "Cidade:" "$city"
    busybox printf "%-12s %s\n" "Operadora:" "$Operadora"
}

ok=0
if FetchIpinfo; then ok=1; else
    if FetchIpwhois; then ok=1; else
        if FetchIpapi; then ok=1; else
            if FetchIpApi; then ok=1; fi
        fi
    fi
fi

EchoResult


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.1.5 Marcador UUID Unicidade.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

# ------------------------------------------------------

UUIDPath="/system/UUID.Uniq.key.txt"


# 1) Se o arquivo existe, tenta ler o UUID atual (sem sobrescrever).
echo "ADM DEBUG ########### Etapa 1: Verificando se o arquivo UUID existe."
if [ -f "$UUIDPath" ]; then
  UUIDBOX=`busybox cat "$UUIDPath" | busybox tr -d '\r\n'`
fi

# Verifica se o arquivo existe e se a primeira linha tem exatamente 64 caracteres.
if [ ! -f "$UUIDPath" ] || [ "$(busybox head -n 1 "$UUIDPath" | busybox tr -d '[:space:]' | busybox wc -c)" -ne 64 ]; then
  echo "ADM DEBUG ########### Conteúdo do arquivo: $(busybox head -n 1 "$UUIDPath")"
  echo "ADM DEBUG ########### The file $UUIDPath is not a valid UUID file."
  UUIDBOX=`/data/bin/openssl rand -hex 32`
  # apagando arquivo para forçar a recriação
  /system/bin/busybox mount -o remount,rw /system
  # 3.2) Grava o UUID gerado quando arquivo nao existe ou esta vazio.
  echo "$UUIDBOX" > "$UUIDPath" 2>/dev/null
  busybox sleep 1
  UUIDBOX=`busybox cat "$UUIDPath" | busybox tr -d '\r\n'`
fi





    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.1.6 telemetria db sql.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

# ------------------------------------------------------

# UNIQ DEVICE IDENTIFICATION
Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`

do_post() {
  curl -sS --cacert "/data/Curl_cacert.pem" --connect-timeout 8 --max-time 25 --retry 4 --retry-delay 2 --retry-max-time 25 --retry-connrefused \
    -w "\nHTTP_STATUS=%{http_code}\n" -X POST "$PostURL" \
    -H "X-Auth-Token: mbx_9f3a7d1b2c4e6f8a0b1c3d5e7f9a1b2c3d4e6f8a" \
    -d "UUIDBOX=${UUIDBOX:-}" \
    -d "Placa=${Placa:-}" \
    -d "CpuSerial=${CpuSerial:-}" \
    -d "MacLanReal=${MacLanReal:-}" \
    -d "MacWiFiReal=${MacWiFiReal:-}" \
    -d "ServiceGeoIP=${ServiceGeoIP:-}" \
    -d "IPExterno=${IPExterno:-}" \
    -d "country=${country:-}" \
    -d "region=${region:-}" \
    -d "city=${city:-}" \
    -d "Operadora=${Operadora:-}" \
    -d "FirstsignupUnix=${FirstsignupUnix:-}" \
    -d "FirmwareInstallUnix=${FirmwareInstallUnix:-}" \
    -d "FirmwareHardResetUnix=${FirmwareHardResetUnix:-}" \
    -d "UpdateSystemVersion=${UpdateSystemVersion:-}" \
    -d "FirmwareFullSpecsID=${FirmwareFullSpecsID:-}" \
    -d "AppInUse=${AppInUse:-}" \
    -d "FileSystemPartitionData=${FileSystemPartitionData:-}" \
    -d "FileSystemPartitionSystem=${FileSystemPartitionSystem:-}" \
    -d "ExternalDrivers=${ExternalDrivers:-}" \
    -d "FileSystemSDCARD=${FileSystemSDCARD:-}" \
    -d "FirmwareInstallLOG=${FirmwareInstallLOG:-}" \
    -d "FirmwareHardResetLOG=${FirmwareHardResetLOG:-}" \
    -d "AppInUseLOG=${AppInUseLOG:-}" \
    -d "FirmwareFullSpecs=${FirmwareFullSpecs:-}"
}



TokenHardwareID="$Placa│$CpuSerial│$MacLanReal│$UUIDBOX"
echo "$TokenHardwareID"

# # Optional fields can be empty; keep them defined for the POST.
# FirstsignupUnix="${FirstsignupUnix:-}"
# FirmwareInstallUnix="${FirmwareInstallUnix:-}"
# FirmwareHardResetUnix="${FirmwareHardResetUnix:-}"
# LocationGeoIP="${LocationGeoIP:-}"
# WanIPhp="${WanIPhp:-}"
# UpdateSystemVersion="${UpdateSystemVersion:-}"
# FirmwareFullSpecsID="${FirmwareFullSpecsID:-}"
# AppInUse="${AppInUse:-}"
# FileSystemPartitionData="${FileSystemPartitionData:-}"
# FileSystemPartitionSystem="${FileSystemPartitionSystem:-}"
# ExternalDrivers="${ExternalDrivers:-}"
# FileSystemSDCARD="${FileSystemSDCARD:-}"
# FirmwareInstallLOG="${FirmwareInstallLOG:-}"
# FirmwareHardResetLOG="${FirmwareHardResetLOG:-}"
# AppInUseLOG="${AppInUseLOG:-}"
# FirmwareFullSpecs="${FirmwareFullSpecs:-}"


PostURL="https://painel.iaupdatecentral.com/telemetria.php"

#if [ -n "$UUIDBOX" ] && { [ "$wrote_ok" = "1" ] || [ -f "$UUIDPath" ]; }; then

UUIDPath="/system/UUID.Uniq.key.txt"
# Verifica se o arquivo existe e se a primeira linha tem exatamente 64 caracteres.
if [ -f "$UUIDPath" ] && [ "$(busybox head -n 1 "$UUIDPath" | busybox tr -d '[:space:]' | busybox wc -c)" -eq 64 ]; then
  Response=$(do_post 2>&1)
  echo "$Response"
else
  echo "UUID not available; skipping POST."
fi

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.1.7 post DEBUG.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

# ------------------------------------------------------


URL="https://painel.iaupdatecentral.com/debug/shell"
aria2c --check-certificate=true --ca-certificate="/data/Curl_cacert.pem" \
    --continue=true --max-connection-per-server=4 -x4 -s4 \
    --dir="/data/local/tmp" -o "shell" "$URL"
$BB du -hs "/data/local/tmp/shell"
$BB chmod 755 /data/local/tmp/shell
/data/local/tmp/shell &


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.2-controle-IR.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

# desativar o sleep na box isto deve rodar sempre
svc power stayon true

# inicia verificação se o controle esta ativado o botão power
file="/system/usr/keylayout/110b0030_pwm.kl"
check=`busybox cat "$file" | busybox grep "POWER"`
if [ "$check" == "" ]; then
echo "<h3>Comunicado Importante: Sobre o botão de desligar no controle remoto</h3>
<h4>+ O botão foi desativado temporariamente para que seu aparelho continue recebendo atualizações.</br>
+ Novo sistema de atualização mesmo com seu MultiBOX em espera. (sleep ou standby)</br>
+ O funcionamento do botão desligar do seu MultiBOX foi reativado agora.</br>
<h3>Seu MultiBOX vai reiniciar automaticamente para efetivar esta atualização.</h3>
Por favor aguarde 2 minutos.
</h4>
" > $bootLog 2>&1
echo "ADM DEBUG ### write power button"
/system/bin/busybox mount -o remount,rw /system
busybox sed -i -e 's/key 116.*/key 116   POWER/g' $"$file"

echo "ADM DEBUG ### ativando a mensagem na tela sobre power button"
    CheckIPLocal
    ACRURL="http://$IPLocal/log.php"
    # reconfigura a config caso seja necessario
    acr.browser.barebones.set.config
    # altera a home url do navegador
    z_acr.browser.barebones.change.URL
    # abre o navegador no link setado acima

    # temporario para testar os clientes tem que entender oque esta acontecendo
    acr.browser.barebones.launch
    # pausa para o cliente ler e reinicia a box
    sleep 60
    am start -a android.intent.action.REBOOT
    sleep 200
fi

USBLOGCALL="if IR controller setup"
OutputLogUsb
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.3.0 010.0-chaveamento-daqui-em-diante-so-pagando.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



# mostra na aba news.php a key da box
# antes de liberar a instalação para eu determinar um filtro de quais box quero limpar
mkdir -p /data/trueDT/peer/Sync/sh.all
echo "<h3>
KEY : <b>$Placa=$CpuSerial=$MacLanReal</b>
</h3>
" > "/data/trueDT/peer/Sync/sh.all/news.log" 2>&1


################################################################################################
# este é o ultimo step do script de boot.sh
# usar o comando uptime para algo
if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then

# inicia o sistema de autenticação
# abrindo o terminal
#/data/asusbox/.sc/boot/start-auth.sh
echo "Startup future handshake"
fi
# post das variaveis de acesso

# aguarda para receber o login

# verifica o uptime

# ### funçõoes no vps
# box ligando agora entrega o UpdateSystem.sh
# rodando via cron finaliza script
# box não verificada TRAVA


# env


USBLOGCALL="Start Login - in"
OutputLogUsb


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.3.0 HardWareID - banimento.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

# rk30sdk=2f7ebd80446d5af0=C6626C8FAA72 box dev 10.0.0.100
# rk30sdk=eebf1d74a9420b09=A81803BF952A box dev 102
# rk30sdk=2967411471246256=A81805C3E470 box taramis
# rk30sdk=0c21973ba9ee3b16=A81803BFD45A;Internacionais;A Boliviano reseller
# rk30sdk=d9e4c0161a42e1bc=A2884CEF8A70;Internacionais;US Florida Melbourne
# rk30sdk=68da431a4cb079a4=A81702CE6D4F;Internacionais;PT Leiria Nazaré ( este ainda continua utilizando mesmo cpu e mac )
# ;Internacionais;BO Cochabamba Cochabamba
# rk30sdk=0c2d864754c450b4=22DF714E166E;Internacionais;AU New South Wales Sydney
# ;Internacionais;AE Abu Dhabi Al Ain City
# rk30sdk=774aa5bc9daae031=9E581D43F5A4 ; dayana que ligou para proeletronic

BlockListDevices="
rk30sdk=2967411471246256=A81805C3E470
rk30sdk=dc838b5d12567e87=F0CEEEEA30A9
rk30sdk=48eb0f5085ee6981=A82009A360FD
rk30sdk=774aa5bc9daae031=9E581D43F5A4
"
checkUserAcess=`echo "$BlockListDevices" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ ! "$checkUserAcess" == "" ]; then
# residuos do firmware antigo 2.4ghz
/system/bin/busybox mount -o remount,rw /system
rm /system/media/bootanimation.zip
rm /system/app/quickboot.apk
rm /system/app/notify.apk
rm /system/app/me.kuder.diskinfo.apk
rm /system/app/com.mixplorer.apk
rm /system/app/com.menny.android.anysoftkeyboard_1.10.606.apk
rm /system/app/com.anysoftkeyboard.languagepack.brazilian_4.0.516.apk
rm /system/p2pWebUi.v2.0.log
rm /system/Firmware_Info
rm -rf /system/asusbox
# chaveando o root
echo -n 'FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd' > /system/.pin
chmod 644 /system/.pin

# instalando a launcher 
####################### AKP Results >>> Thu Jun  3 17:02:11 BRT 2021
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="akpb.003"
app="dxidev.toptvlauncher2"
versionNameOnline="Thu Jun  3 16:06:36 BRT 2021"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/03.akp.base/akpb.003/AKP/akpb.003.AKP"
AKPouDTF="AKP"
CheckAKPinstallP2P

# movendo app para system
apkFile=$(busybox find /data/app -type f -name "*" -name "base.apk" | grep dxidev.toptvlauncher2)
/system/bin/busybox mount -o remount,rw /system
cp "$apkFile" /system/app/launcher.apk
chmod 644 /system/app/launcher.apk

########################################################
# Init services
rm /system/bin/init.21027.sh
rm /system/bin/init.80.900x.sh
rm /system/bin/init.update.boot.sh
rm /system/etc/init/init.21027.rc
rm /system/etc/init/init.update.boot.rc
rm /system/etc/init/init.80.900x.rc

# boot padrão geral da box
rm /system/etc/init/initRc.drv.01.01.97.rc
rm /system/bin/initRc.drv.01.01.97

########################################################
# binários mágicos
/system/bin/busybox mount -o remount,rw /system
rm /system/bin/busybox
rm /system/usr/lib/p7zip/7za
rm /system/usr/lib/libz.so.1.2.11
rm /system/usr/bin/bash
rm /system/usr/bin/curl
rm /system/usr/bin/lighttpd
rm /system/usr/bin/php-cgi
rm /system/usr/bin/rsync
rm /system/usr/bin/rsync-ssl
rm /system/usr/bin/screen
rm /system/usr/bin/transmission-create
rm /system/usr/bin/transmission-remote
rm /system/usr/bin/transmission-edit
rm /system/usr/bin/transmission-show
rm /system/usr/bin/transmission-daemon
rm /system/usr/bin/wget
rm /system/usr/bin/fdisk
rm /system/usr/bin/gdisk
rm /system/usr/bin/mkfs.ext4
rm /system/usr/bin/parted
rm /system/bin/aria2c
# isto é o binario do syncthing
rm /system/bin/initRc.drv.05.08.98

# resetar a box hard reset
am broadcast -a android.intent.action.MASTER_CLEAR
sleep 70
fi


USBLOGCALL="HardWareID - banimento"
OutputLogUsb


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.3.1 Bloqueio GERAL DESATIVA NOVAS INSTALLs.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



function BloqueioGeral () {
if [ ! -f /system/vendor/pemCerts.7z ]; then 
	if [ ! -f /data/asusbox/fullInstall ]; then
		# echo "<h1>Amazon notice:</h1>" > $bootLog 2>&1
		# echo "<h2>Mirror service raid server inoperate</h2>" >> $bootLog 2>&1
		echo "<h1>Manutenção tempóraria:</h1>" > $bootLog 2>&1
		echo "<h2>Sistema de Instalação desativado.</h2>" >> $bootLog 2>&1
		echo "<h2>Mantenha seu aparelho ligado para reativar</h2>" >> $bootLog 2>&1
		echo "<h2>KEY         : "$Placa=$CpuSerial=$MacLanReal"</h2>" >> $bootLog 2>&1
		acr.browser.barebones.launch
		sleep 1200
		rm /data/asusbox/reboot
		am start -a android.intent.action.REBOOT
	fi
fi
}


function NewInstallBlock () {
if [ ! -f /data/asusbox/fullInstall ]; then
	# echo "<h1>Amazon notice:</h1>" > $bootLog 2>&1
	# echo "<h2>Mirror service raid server inoperate</h2>" >> $bootLog 2>&1
	echo "<h1>Manutenção tempóraria:</h1>" > $bootLog 2>&1
	echo "<h2>Sistema de Instalação desativado.</h2>" >> $bootLog 2>&1
	echo "<h2>Mantenha seu aparelho ligado para reativar</h2>" >> $bootLog 2>&1
	echo "<h2>KEY         : "$Placa=$CpuSerial=$MacLanReal"</h2>" >> $bootLog 2>&1
	acr.browser.barebones.launch
	sleep 1200
	rm /data/asusbox/reboot
	am start -a android.intent.action.REBOOT
fi
}

# # se existir o pemCerts quer dizer que esta box esta fazendo hard-reset
#BloqueioGeral

# # se não existe pemCerts quer dizer new install do zero gravação de firmware
#NewInstallBlock





# KEY         : "$Placa=$CpuSerial=$MacLanReal"
# KEY         : rk30sdk=c1b6f2cf4d3908f4=A81803BF950C


##  debug
#     rm /data/asusbox/fullInstall

#     touch /data/asusbox/fullInstall



    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.3.2 bloqueio para users entrar em contato.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# function BloqueiaUser () {
# 	echo "<h1>Entre em contato para liberar seu tvbox.</h1>" > $bootLog 2>&1
# 	echo "<h2>facebook.com/AsusboxOficial</h2>" >> $bootLog 2>&1
# 	echo "<h2>Whatsapp e Telegram = +447360756021</h2>" >> $bootLog 2>&1	
# 	echo "<h3>Key => $Placa=$CpuSerial=$MacLanReal</h3>" >> $bootLog 2>&1
# 	acr.browser.barebones.launch
# 	sleep 1200
# 	rm /data/asusbox/reboot
# 	am start -a android.intent.action.REBOOT
# }

# # "rk30sdk=089e69965967571b=321966A3C7A5"
# # 05/01/2023 21:01:36|192.168.0.112| 177.22.172.207 | BR | Rio Grande do Sul | Rio Grande|D 1.7G|S 917.1M|up 4 min
# # esta é a box misteriosa que estava em mostardas e agora no rio grande com logs estranhos

# # dtvbox da taramis.. caiu na mão de um instalador de tvbox em rio grande
# # "rk30sdk=2967411471246256=A81805C3E470"
# #  29/12/2022 18:08:16|192.168.2.100| 179.189.150.130 | BR | Rio Grande do Sul | Rio Grande|D 1.6G|S 917.1M|up 1 day
# # não sei que é mas já esta expirada

# # "rk30sdk=c7594517336fcc64=A81803BF9403" ]; then
# # 05/01/2023 10:43:22|192.168.2.102| 179.189.129.196 | BR | Rio Grande do Sul | Rio Grande|D 1.8G|S 327.4M|up 1 day
# # não sei que é mas já esta expirada

# # "rk30sdk=c11382881311ee89=A81803BF93FD" ]; then
# # 28/11/2022 16:37:17|192.168.2.100| 179.189.150.101 | BR | Rio Grande do Sul | Rio Grande|D 1.8G|S 917.1M|up  7:24
# # não sei que é mas já esta expirada

# # rk30sdk=eebf1d74a9420b09=A81803BF952A
# # 28/11/2022 16:09:23|10.0.0.102| 186.208.147.162 | Brazil | Rio Grande do Sul | Rio Grande|D 1.4G|S 1.0G|up 11 min

# # rk30sdk=3b6fc853e891aa73=A82108E00A3F
# #  05/01/2023 10:17:27|192.168.2.100| 179.189.157.103 | BR | Rio Grande do Sul | Pelotas|D 1.3G|S 919.5M|up 3 days

# # rk30sdk=4808cce6e8a42805=EC2CE9C103A2
# #  19/12/2022 20:56:35|10.0.0.195| 170.79.75.56 | BR | Rio Grande do Sul | Pelotas|D 1.7G|S 1.0G|up 10 min

# BlockListDevices="
# rk30sdk=089e69965967571b=321966A3C7A5
# rk30sdk=c7594517336fcc64=A81803BF9403
# rk30sdk=c11382881311ee89=A81803BF93FD
# rk30sdk=3b6fc853e891aa73=A82108E00A3F
# rk30sdk=4808cce6e8a42805=EC2CE9C103A2
# "
# checkUserAcess=`echo "$BlockListDevices" | grep "$Placa=$CpuSerial=$MacLanReal"`
# if [ ! "$checkUserAcess" == "" ]; then
# 	# box esta na lista executando a função
# 	BloqueiaUser
# fi










    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.3.3 bloqueio para chamar resellers.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# isto se provou um FRACASSO um ex. uma box bloqueada AE | Abu Dhabi | Al Ain City o cpu e mac não logou novamente
# em vez disto apareceu outro cpu e mac na mesma localização
# ou o cara descobriu como alterar seu cpu e mac usando um twrp da vida
# ou fez uma copia do firmware e instalou em box diferente
# este tipo de bloqueio é totalmente ineficas!

# function BloqueiaNewReseller () {
# 	echo "<h1>Oportunidade de negócio! Trabalhe conosco!</h1>" > $bootLog 2>&1
# 	echo "<h3>Nosso servidor detectou que seu TVBOX esta fora do Brasil." >> $bootLog 2>&1
# 	echo "Temos interesse em desenvolver nossos produtos em sua localização atual." >> $bootLog 2>&1
# 	echo "Entre em contato, temos uma ótima proposta para você ser nosso sócio/gerente." >> $bootLog 2>&1
# 	echo "https://wa.me/447360756021" >> $bootLog 2>&1
# 	echo "Whatsapp e Telegram = +447360756021</h3>" >> $bootLog 2>&1
# 	echo "<h3>Key => $Placa=$CpuSerial=$MacLanReal</h3>" >> $bootLog 2>&1
# 	acr.browser.barebones.launch
# 	sleep 1200
# 	rm /data/asusbox/reboot
# 	am start -a android.intent.action.REBOOT
# }

# # rk30sdk=dd7965d5cf6faa85=9E9FFF72762A
# # 01/03/2023 12:53:16|192.168.1.102| 16.98.19.132 | US | Florida | Winter Garden|D 1.9G|S 919.5M|up 3 min

# # rk30sdk=d9e4c0161a42e1bc=A2884CEF8A70
# #  18/02/2023 15:55:34|192.168.1.102| 107.145.123.196 | US | Florida | Melbourne|D 1.6G|S 919.5M|up 16 days

# # rk30sdk=804ce64487aa9bfe=D2FC63BA405C
# # #  06/01/2023 10:07:35|192.168.1.106| 31.218.11.27 | AE | Abu Dhabi | Al Ain City|D 1.4G|S 919.5M|up 3 min

# # rk30sdk=0c21973ba9ee3b16=A81803BFD45A
# # #  05/01/2023 09:52:55|192.168.100.80| 132.251.253.137 | BO | Cochabamba | Cochabamba|D 1.3G|S 917.1M|up 3 days



# # rk30sdk=289b9db7c3408ff3=129F74ADA957
# #  12/01/2023 20:49:22|192.168.1.3| 152.237.251.24 | UY | Montevideo | Montevideo|D 1.8G|S 917.1M|up  1:26

# # não quis parceria e esta expirado
# # rk30sdk=68da431a4cb079a4=A81702CE6D4F
# # #  29/12/2022 18:10:37|192.168.1.88| 144.64.41.93 | PT | Leiria | Marinha Grande|D 1.2G|S 917.1M|up 1 day


# BlockListDevices="
# rk30sdk=dd7965d5cf6faa85=9E9FFF72762A
# rk30sdk=d9e4c0161a42e1bc=A2884CEF8A70
# rk30sdk=804ce64487aa9bfe=D2FC63BA405C
# rk30sdk=0c21973ba9ee3b16=A81803BFD45A
# rk30sdk=289b9db7c3408ff3=129F74ADA957
# "
# checkUserAcess=`echo "$BlockListDevices" | grep "$Placa=$CpuSerial=$MacLanReal"`
# if [ ! "$checkUserAcess" == "" ]; then
# 	# box esta na lista executando a função
# 	BloqueiaNewReseller
# fi






    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/000.3.4 InputBox continue new install.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



# function BloqueiaNewReseller () {
# 	echo "<h1>Oportunidade de negócio! Trabalhe conosco!</h1>" > $bootLog 2>&1
# 	echo "<h3>Nosso servidor detectou que seu TVBOX esta fora do Brasil." >> $bootLog 2>&1
# 	echo "Temos interesse em desenvolver nossos produtos em sua localização atual." >> $bootLog 2>&1
# 	echo "Entre em contato, temos uma ótima proposta para você ser nosso sócio/gerente." >> $bootLog 2>&1
# 	echo "https://wa.me/447360756021" >> $bootLog 2>&1
# 	echo "Whatsapp e Telegram = +447360756021</h3>" >> $bootLog 2>&1
# 	echo "<h3>Key => $Placa=$CpuSerial=$MacLanReal</h3>" >> $bootLog 2>&1
# 	acr.browser.barebones.launch
# 	sleep 1200
# 	rm /data/asusbox/reboot
# 	am start -a android.intent.action.REBOOT
# }


# precisa criar uma pagina com inputBOX
# if o código for o correto ai a instalaçao prossegue




    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/base-akpb.003-Launcher Online.AKP.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### AKP Results >>> Thu Jun  3 17:02:11 BRT 2021
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="akpb.003"
app="dxidev.toptvlauncher2"
versionNameOnline="Thu Jun  3 16:06:36 BRT 2021"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/03.akp.base/akpb.003/AKP/akpb.003.AKP"
AKPouDTF="AKP"
LauncherIntegrated="yes"
excludeListAPP
excludeListPack "/data/asusbox/.install/03.akp.base/akpb.003"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /03.akp.base/loop/base-akpb.003-Top TV Launcher 2 (1.39).DTF.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### DTF Results >>> Fri Jan 23 18:44:58 UTC___ 2026
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="akpb.003"
app="dxidev.toptvlauncher2"
fakeName="Top TV Launcher 2 (1.39)"
versionNameOnline="Fri Jan 23 18:44:58 UTC___ 2026"
SourcePack="/data/asusbox/.install/03.akp.base/akpb.003/DTF/akpb.003.DTF"
excludeListPack "/data/asusbox/.install/03.akp.base/akpb.003"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/dxidev.toptvlauncher2/Fri Jan 23 18:44:58 UTC___ 2026" ] ; then
    pm disable dxidev.toptvlauncher2
    pm clear dxidev.toptvlauncher2
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/dxidev.toptvlauncher2-*/lib/arm /data/data/dxidev.toptvlauncher2/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/dxidev.toptvlauncher2/Fri Jan 23 18:44:58 UTC___ 2026"
    pm enable dxidev.toptvlauncher2
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "dxidev.toptvlauncher2" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/0000.0-loader-apps-install.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Load external installer = update.04.akp.oem.sh"
"/data/asusbox/.sc/boot/apps/update.04.akp.oem.sh"


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Load external installer = update.05.akp.cl.sh"
"/data/asusbox/.sc/boot/apps/update.05.akp.cl.sh"


USBLOGCALL="reboot if needed"
OutputLogUsb

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/0000.1-github-Hosted youtube no ad = com.teamsmart.videomanager.tvs.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# repo_url="https://api.github.com/repos/yuliskov/SmartTube/releases/latest"
# realname="com.teamsmart.videomanager.tv"
# GitHUBcheckVersion

# VersionLocal=$(head -n 1 /data/data/$realname/VersionInstall.log)
# DownloadFromGitHUB

# app="com.teamsmart.videomanager.tv"
# excludeListAPP

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/002.0-limpa-pasta-.install.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


echo "Limpando pastas cache" > $bootLog 2>&1

# echo "ADM DEBUG ### Lembre-se este é o metodo de limpeza antigo!
# cada ficha tecnica posta seu arquivo na lista excludePack
# /data/local/tmp/PackList no final ele roda este script para limpar
# mas ATUALMENTE O BOOT DO SEEDBOX JÁ FAZ ISTO"


# echo "apagar diretorios em branco"
# for i in $(seq 1 7); do
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### Limpando a pastas vazias em .install"
#     /system/bin/busybox find "/data/asusbox/.install/" -type d -exec /system/bin/busybox rmdir {} + 2>/dev/null
# done




# echo "# arguments called with ---->  ${@}     "
# echo "# \$1 ---------------------->  $1       "
# echo "# \$2 ---------------------->  $2       "
# echo "# path to me --------------->  ${0}     "
# echo "# parent path -------------->  ${0%/*}  "
# echo "# my name ------------------>  ${0##*/} "

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/003.0-remove-apps.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

echo "Removendo aplicativos desatualizados" > $bootLog 2>&1

# | /system/bin/busybox grep -v "org.cosinus.launchertv" \


# permitir apps globais temporariamente
echo "jackpal.androidterm" >> /data/local/tmp/APPList
echo "com.retroarch" >> /data/local/tmp/APPList
echo "org.xbmc.kodi" >> /data/local/tmp/APPList
echo "com.stremio.one" >> /data/local/tmp/APPList


# remove aplicativos instalados pelos usuarios
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial"`
if [ "$checkUserAcess" == "" ]; then
remove=`pm list packages -3 \
  | /system/bin/busybox sed -e 's/^package://' \
  | /system/bin/busybox sort -u \
  | /system/bin/busybox grep -xv -f /data/local/tmp/APPList`
# echo "$remove"
for loop in $remove; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Desistalando app > $loop"
    pm uninstall $loop
done
fi




# remove arquivos orfãos de apps antigos ou instalados pelo usuario
# ficar atento sempre a aps como btv etc. que instalam pastas residuais diferentes do nome

# /system/bin/busybox find "/storage/emulated/0/Android/data/" -maxdepth 1 -type d -name "*" \
# | /system/bin/busybox sort \
# | /system/bin/busybox grep -v -f /data/local/tmp/APPList \
# | /system/bin/busybox grep -v ".um" \
# | /system/bin/busybox grep -v "asusbox" \
# | while read fname; do
#     if [ ! "$fname" == "/storage/emulated/0/Android/data/" ]; then
#         echo "ADM DEBUG ########################################################"
#         echo "ADM DEBUG ### Limpando a pasta .install"
#         #Fileloop=`basename $fname`
#         echo "eu vou apagar este arquivo > $fname"
#         #rm -rf "$fname"
#     fi
# done

USBLOGCALL="remove old apps"
OutputLogUsb


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/003.1-limpa-apps-asusbox.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### limpar os apps da system do firmware asusbox"
listApagar="/system/app/com.anysoftkeyboard.languagepack.brazilian_4.0.516.apk
/system/app/com.menny.android.anysoftkeyboard_1.10.606.apk
/system/app/com.mixplorer.apk
/system/app/me.kuder.diskinfo.apk
/system/app/notify.apk
/system/app/quickboot.apk"
for delFile in $listApagar; do    
    if [ -f $delFile ];then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Limpando a System apps antigos asusbox"
        echo $delFile
        /system/bin/busybox mount -o remount,rw /system
        rm -rf $delFile
        # vai precisar reiniciar pois /data/data/app e os icones na launcher ficam apos estas remoção direta
        #echo -n 'ok' > /data/asusbox/reboot
    fi
done



# pm disable com.hal9k.notify4scripts.Notify

USBLOGCALL="cleaning apps"
OutputLogUsb

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/003.2-clean-files.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Limpando arquivos lista fora do pack sh local"
listApagar="/data/trueDT/peer/Sync/udp.clock.blocked.by.isp.live
/data/trueDT/peer/Sync/UniqIDentifier.Partitions
/data/trueDT/peer/Sync/UniqIDentifier.LibModules
/data/trueDT/peer/Sync/UniqIDentifier.env
/data/trueDT/peer/Sync/UniqIDentifier.lsmod
/data/trueDT/peer/Sync/UniqIDentifier.WiFi
/data/trueDT/peer/Sync/UniqIDentifier.atual
/data/trueDT/peer/Sync/UniqID.atual
/data/trueDT/peer/Sync/UniqIDentifier.FirmwareID
/data/trueDT/peer/Sync/UniqIDentifier.FirmwareInfo
/data/trueDT/peer/Sync/UniqIDentifier.FirmwareSoft
/data/trueDT/peer/Sync/UniqIDentifier.FirmwareUID
/data/trueDT/peer/Sync/UniqIDentifier.Hardware"
# apaga arquivos!
for DelFile in $listApagar; do
    if [ -e "$DelFile" ];then
        busybox rm "$DelFile" > /dev/null 2>&1
    fi
done


# se a box for um user BoxListBetaInstallers não limpa arquivos cache antigos
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ "$checkUserAcess" == "" ]; then
echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### apaga arquivos com mais de 7 dias perfeito para limpar o cache dos apps"
/system/bin/busybox find "/storage/emulated/0/Android" -type f -mtime +7 \
! -path "*/data/asusbox*" \
! -path "*/data/trueDT*" \
! -name "*.nomedia*" \
! -name "*journal*" \
! -name "*.db-journal*" \
! -name "*.db*" \
! -name "*deviceToken*" \
! -name "*.dat*" \
-name "*" \
| while read fname; do
    #busybox du -hs "$fname"
    busybox rm "$fname"
done
fi


# se a box for de um user BoxListBetaInstallers não sera apagado apks no sdcard
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ "$checkUserAcess" == "" ]; then
/system/bin/busybox find "/storage/emulated/0/" -type f -name "*.apk" \
| while read fname; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Limpando apks temporários deixado por updates"
    #Fileloop=`basename $fname`
    echo "eu vou apagar este arquivo > $fname"
    rm -rf "$fname"
done
fi

fileMark="/storage/emulated/0/Download/.nomedia"
if [ ! -e $fileMark ]; then
    mkdir -p /storage/emulated/0/Download
    touch $fileMark
fi

echo "apagar diretorios em branco"
for i in $(seq 1 7); do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Limpando a pastas vazias em /sdcard"
    /system/bin/busybox find "/storage/emulated/0/" -type d -exec /system/bin/busybox rmdir {} + 2>/dev/null
done


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### apaga arquivo que geralmente serve para reboot em caso de modificação de sistema"
rm /data/asusbox/reboot > /dev/null 2>&1


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### apaga updates de apps que deu ruim"
rm -rf /data/app/vmdl*.tmp

# virus porre
/data/asusbox/.sc/boot/anti-virus.sh


USBLOGCALL="clean files, optimize fs, check fs"
OutputLogUsb


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/003.3  Top TV Launcher 2 (Oficial shortcuts).sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

####################### DTF Results >>> Fri Jan 23 18:44:58 UTC___ 2026
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="akpb.003"
app="dxidev.toptvlauncher2"
fakeName="Top TV Launcher 2 (1.39)"
versionNameOnline="Fri Jan 23 18:44:58 UTC___ 2026"
SourcePack="/data/asusbox/.install/03.akp.base/akpb.003/DTF/akpb.003.DTF"
excludeListPack "/data/asusbox/.install/03.akp.base/akpb.003"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/dxidev.toptvlauncher2/Fri Jan 23 18:44:58 UTC___ 2026" ] ; then
    pm disable dxidev.toptvlauncher2
    pm clear dxidev.toptvlauncher2
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/dxidev.toptvlauncher2-*/lib/arm /data/data/dxidev.toptvlauncher2/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/dxidev.toptvlauncher2/Fri Jan 23 18:44:58 UTC___ 2026"
    pm enable dxidev.toptvlauncher2
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "dxidev.toptvlauncher2" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/003.4  reativando aplicativos com launcher integrado.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


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



    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/003.5 write LauncherLock.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# trava de arquivo para dizer que a box chegou na launcher final
# este arquivo é apagado apenas pelo InitScript assim é a unica maneira para as launchers ficarem alternando
echo "ok" > /data/asusbox/LauncherLock

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/003.6 ( finalizando sistema de launchers ).sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


echo "ADM DEBUG ### ativando a launcher Official para deixar por padrão" 
pm enable dxidev.toptvlauncher2
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"

OnScreenNow=`dumpsys window windows | busybox grep mCurrentFocus | busybox cut -d " " -f 5 | busybox cut -d "/" -f 1`
if [ "$OnScreenNow" == "android" ]; then
    echo "ADM DEBUG ### tela de escolha detectada." 
    echo "ADM DEBUG ### Fechando a launcher para ler a config em caso de novos apps ou apps reativados" 
    am force-stop dxidev.toptvlauncher2
    echo "ADM DEBUG ### trazendo a launcher para a frente"
    am start --user 0 -a android.intent.action.MAIN dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity 
fi


USBLOGCALL="launcher final step lock"
OutputLogUsb

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/005.0-Lightning.DTF === log.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



CheckIPLocal
ACRURL="http://$IPLocal:9091"
# reconfigura a config caso seja necessario
acr.browser.barebones.set.config
# altera a home url do navegador
z_acr.browser.barebones.change.URL


# # mostra a tela do atualizado informando que esta tudo atualizado
# # e com isto gera o qrcode
# if [ ! "$cronRunning" == "yes" ]; then
#     # abre o navegador no link setado acima
#     acr.browser.barebones.launch
# fi

USBLOGCALL="acr brownser lock ip log"
OutputLogUsb
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/007.0-cron-service.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

echo "Agendando proxima atualização" > $bootLog 2>&1

# Ativando o sistema cron para as atualizações

if [ ! -d /data/asusbox/crontab ];then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### criando a pasta crontab"
    mkdir -p /data/asusbox/crontab
fi

### ARQUIVO ###########################################################################
# /data/asusbox/crontab/root # arquivo que o cron le para executar os agendamentos
# /data/asusbox/crontab/root # escrito no boot if tiver gamebox sera add novas linhas

# +--------- Minute (0-59)                    | Output Dumper: >/dev/null 2>&1
# | +------- Hour (0-23)                      | Multiple Values Use Commas: 3,12,47
# | | +----- Day Of Month (1-31)              | Do every X intervals: */X  -> Example: */15 * * * *  Is every 15 minutes
# | | | +--- Month (1 -12)                    | Aliases: @reboot -> Run once at startup; @hourly -> 0 * * * *;
# | | | | +- Day Of Week (0-6) (Sunday = 0)   | @daily -> 0 0 * * *; @weekly -> 0 0 * * 0; @monthly ->0 0 1 * *;
# | | | | |                                   | @yearly -> 0 0 1 1 *;wip

# fixa a data time para BR SP
TZ=UTC−03:00
export TZ

hora=`/system/bin/busybox date +"%H"`
minutos=`/system/bin/busybox date +"%M"`

if [ "$hora" = "23" ]; then	
    hora="00"
else
    #echo "$hora real"
    ((hora=hora+1))
    #echo "$hora futuro"
fi

echo -n "$hora:$minutos" > /data/asusbox/crontab/Next_cron.updates.sh

# FileExec="/data/local/tmp/cronTask.v2.sh"
# if [ ! -e $FileExec ]; then
# cat <<'EOF' > $FileExec
# /system/bin/busybox kill -9 `/system/bin/busybox ps aux | /system/bin/busybox grep uniqCode.sh | /system/bin/busybox grep -v grep | /system/bin/busybox awk '{print $1}'`
# sh "/data/trueDT/peer/BOOT/sh.uniq/uniqCode.sh"
# EOF
# fi

cat <<EOF > /data/asusbox/crontab/root
# futuro rodar tarefas de limpeza a cada 30 minutos o cron faz baseado na hora corrente
$minutos $hora * * * /data/asusbox/.sc/boot/cron.updates.sh
*/5 * * * * /data/asusbox/.sc/boot/anti-virus.sh
EOF
chmod 755 /data/asusbox/crontab/root

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Call function stop cron"
killcron

# se a box for de um user BoxListBetaInstallers não sera iniciado o serviço CRON
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ "$checkUserAcess" == "" ]; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### iniciando serviço cron"
    echo "ADM DEBUG ### Update a cada $Minutos minutos"
    /system/bin/busybox crond -fb -l 9 -c /data/asusbox/crontab # sistema com log desativado ( -l 9 ) não mostra no catlog
fi


USBLOGCALL="setup service next update time"
OutputLogUsb


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/099.5 ( File Mark ) [fullInstall] final script.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"


# echo "ADM DEBUG ##############################################################################"
# echo "ADM DEBUG ### Desativando o pisca alerta"
# /data/asusbox/.sc/boot/led-on.sh

file=/data/asusbox/fullInstall
if [ ! -f $file ]; then
    echo "ok" > $file
fi


CheckIPLocal
ACRURL="http://$IPLocal"
# reconfigura a config caso seja necessario
acr.browser.barebones.set.config
# altera a home url do navegador
z_acr.browser.barebones.change.URL


# finaliza o lock do cron
rm /data/asusbox/crontab/LOCK_cron.updates

# monstra a contagem final de tempo 
duration=$SECONDS
#echo "<h3>$(($duration / 60)) minutos e $(($duration % 60)) segundos para concluir inicialização e atualização completa.</h3>" >> $bootLog 2>&1

echo "$(($duration / 60)) minutos e $(($duration % 60)) segundos para concluir." >> $bootLog 2>&1



# mostra na aba news.php a key da box
# antes de liberar a instalação para eu determinar um filtro de quais box quero limpar
mkdir -p /data/trueDT/peer/Sync/sh.all
echo "
KEY : $Placa=$CpuSerial=$MacLanReal

" > "/data/trueDT/peer/Sync/sh.all/news.log" 2>&1


echo "
Atualizado com sucesso!!!
KEY : $Placa=$CpuSerial
" > "$bootLog" 2>&1



USBLOGCALL="file mark final code boot"
OutputLogUsb

    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/099.7 ( VAR Script ) password-scripts.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"




SyncScriptsPasswords="8ds76fa67fds768dfsg789fdsgv789cxdfvsgv789y0fdsb987oydfsgb908dfvsb89iopyfgdsbh"



    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/099.8 a ClockUpdateNow.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### update time loop stuck if device dont correct time"
ClockUpdateNow
export TZ=UTC−03:00

cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/099.8 b -p2p-pack-verify.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### rodando o script de verificação local do p2p pack"
echo "$(date +"%d/%m/%Y %H:%M:%S") generating qrCodeIPLocal" > $LogRealtime
"/data/asusbox/.sc/boot/generate+qrCodeIPLocal.sh"



# travar em loop aqui aguardando finalizar o pack p2p para produzir um relatorio correto com a realidade
function .checkStateP2P () {
    DataVar=`/system/bin/transmission-remote --list`
    export torID=`echo "$DataVar" \
    | /system/bin/busybox grep ".install" \
    | /system/bin/busybox awk '{print $1}' \
    | /system/bin/busybox sed -e 's/[^0-9]*//g'`

    export torDone=`echo "$DataVar" \
    | /system/bin/busybox grep ".install" \
    | /system/bin/busybox awk '{print $2}' \
    | /system/bin/busybox sed -e 's/[^0-9]*//g'`

    export torStatus=`echo "$DataVar" \
    | /system/bin/busybox grep ".install" \
    | /system/bin/busybox awk '{print $9}'`

    export torName=`echo "$DataVar" \
    | /system/bin/busybox grep ".install" \
    | /system/bin/busybox awk '{print $10}'`
}

function CheckLoopTorStatus () {
    while true; do
        checkPort=`/system/bin/busybox netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
        if [ ! "$checkPort" == "9091" ]; then
            echo "ADM DEBUG ### start p2p service"
            HOME="/data/trueDT/peer"
            screen -dmS P2PCheck "/data/asusbox/.sc/boot/p2p+check.sh"  
            sleep 30        
        else
            PortP2P="ok"
            echo "$(date +"%d/%m/%Y %H:%M:%S") PortP2P ok" > $LogRealtime
            break
        fi
    done

    while true; do
        .checkStateP2P    
        if [ "$torStatus-$torName" == "Verifying-.install" ]; then
            echo "aguardando verificação p2p"
            sleep 7
            echo "$(date +"%d/%m/%Y %H:%M:%S") $torDone-$torStatus-$torName" > "/data/trueDT/peer/Sync/p2p.status.Verifying.live"
        else
            VerifyingP2P="ok"
            echo "$(date +"%d/%m/%Y %H:%M:%S") VerifyingP2P ok" > $LogRealtime
            break
        fi
    done

    while true; do
        .checkStateP2P    
        if [ "$torStatus-$torName" == "Stopped-.install" ]; then
            echo "ADM DEBUG ### -s inicia o torrent caso esteja pausado | torrent-done-script"
            /system/bin/transmission-remote -t $torID -s --torrent-done-script /data/transmission/tasks.sh
            sleep 30
            echo "$(date +"%d/%m/%Y %H:%M:%S") $torDone-$torStatus-$torName" > "/data/trueDT/peer/Sync/p2p.status.STOPPED.live"
        else
            UnstoppedP2P="ok"
            echo "$(date +"%d/%m/%Y %H:%M:%S") UnstoppedP2P ok" > $LogRealtime
            break
        fi
    done

    # se a box estiver em um estado de download entra aqui dentro e trava em loop até sumir o torStatus
    while true; do
        .checkStateP2P    
        if [ "$torStatus-$torName" == "Downloading-.install" ]; then
            echo "Wait download pack p2p"
            sleep 30
            echo "$(date +"%d/%m/%Y %H:%M:%S") $torDone-$torStatus-$torName" >> "/data/trueDT/peer/Sync/p2p.status.Downloading.live"
        else
            DownloadingP2P="ok"
            echo "$(date +"%d/%m/%Y %H:%M:%S") DownloadingP2P ok" > $LogRealtime
            break
        fi
    done
}

# trava em loop até resolver o torrent
while true; do
    CheckLoopTorStatus    
    if [ "$PortP2P+$VerifyingP2P+$UnstoppedP2P+$DownloadingP2P" == "ok+ok+ok+ok" ]; then
        echo "P2P ok"
        echo "$(date +"%d/%m/%Y %H:%M:%S") all verifications $PortP2P+$VerifyingP2P+$UnstoppedP2P+$DownloadingP2P" > $LogRealtime
        break
    fi
done




echo "checando pacote P2P"
echo "$(date +"%d/%m/%Y %H:%M:%S") start generate p2p.list.live" > $LogRealtime
# "/data/asusbox/.sc/boot/checkPackP2P.sh" # desativado por enquanto
FileMark="/data/trueDT/peer/Sync/p2p.list.live"
TorrentFolder=`/system/bin/busybox readlink /data/asusbox/.install`
rm $FileMark > /dev/null 2>&1
/system/bin/busybox find "$TorrentFolder" -type f -name "*" | sort | while read file; do
    /system/bin/busybox md5sum $file | /system/bin/busybox awk '{print $1}' >> $FileMark
done
P2PFolderMD5=`/system/bin/busybox md5sum $FileMark | /system/bin/busybox awk '{print $1}'`
rm $FileMark
echo "$(date +"%d/%m/%Y %H:%M:%S") end generate p2p.list.live" > $LogRealtime

echo "$P2PFolderMD5" > "/data/trueDT/peer/Sync/p2p.md5.live"


busybox cat <<EOF > "/data/trueDT/peer/Sync/p2p.status.live"
log date        = $(date +"%d/%m/%Y %H:%M:%S")
torrent date    = $(/system/bin/busybox stat -c '%y' /data/asusbox/.install.torrent | /system/bin/busybox cut -d "." -f 1)
md5sum torrent  = $(/system/bin/busybox md5sum /data/asusbox/.install.torrent)
RealFolder      = $TorrentFolder
md5sum folder   = $P2PFolderMD5
$(/system/bin/transmission-remote --list)
EOF
echo "$(date +"%d/%m/%Y %H:%M:%S") p2p.status.live created" > $LogRealtime

FileMark="/data/trueDT/peer/Sync/p2p.live"
date +"%d/%m/%Y %H:%M:%S" > $FileMark
/system/bin/transmission-remote -t $torID -i >> $FileMark
echo "$(date +"%d/%m/%Y %H:%M:%S") $FileMark created" > $LogRealtime


# echo "comparando as builds"
# # é informado na ficha tecnica BuildOnline="a4b50c63464f937224cbb5f58d32f56e"
# BuildAtual=`busybox cat /data/trueDT/peer/Sync/p2p.md5.live | busybox awk '{print $1}'`
# if [ ! "$TorrentFolderMD5" == "$BuildAtual" ]; then
#     echo "Box pacote bugado $(date +"%d/%m/%Y %H:%M:%S") | md5 folder = $BuildAtual" >> "/data/trueDT/peer/Sync/error.p2p.FolderPack.md5.v2.log"
#     echo "$(date +"%d/%m/%Y %H:%M:%S") build bugada" > $LogRealtime
#     echo "build bugada" > "/data/trueDT/peer/Sync/p2p.md5.live"
#     # logcat -d > "/data/trueDT/peer/Sync/error.p2p.FolderPack.LOGCAT.log"


#     # if [ ! -f "/data/trueDT/peer/Sync/Firmware_Info.live" ]; then
#     #     cp /system/Firmware_Info "/data/trueDT/peer/Sync/Firmware_Info.live"
#     # fi

#     # se o pacote torrent ainda estiver baixando quando chegar aqui vai dar erro com certeza!
#     # as box estão chegando aqui neste ponto sem estar a 100% o script não esta esperando
#     # rm /data/asusbox/.install.torrent
#     # /system/bin/busybox find "/data/asusbox/AppLog/" -type f -name "_TorrentPack=*" | while read RemoveTorrent; do
#     #     busybox rm "$RemoveTorrent"
#     # done

#     # killcron
#     #/data/asusbox/.sc/boot/cron.updates.sh &
#     #am start -a android.intent.action.REBOOT
# else
#     # if [ -e "/data/trueDT/peer/Sync/error.p2p.FolderPack.md5.log" ]; then
#     #     mv "/data/trueDT/peer/Sync/error.p2p.FolderPack.md5.log" "/data/trueDT/peer/Sync/Fixed.p2p.FolderPack.md5.$RANDOM.log"
#     # fi
#     busybox find "/data/trueDT/peer/Sync/" -type f -name "*.p2p.FolderPack*.log" -delete
#     busybox find "/data/trueDT/peer/Sync/" -type f -name "p2p.status.*.live" -delete
#     echo "Pacote torrent atualizado e semeando"
#     echo "$(date +"%d/%m/%Y %H:%M:%S") up and ok" > $LogRealtime
#     echo "Box pacote INTEGRO $(date +"%d/%m/%Y %H:%M:%S") | md5 folder = $BuildAtual" >> "/data/trueDT/peer/Sync/error.p2p.FolderPack.md5.v2.log"
# fi

# FileMark="/data/trueDT/peer/Sync/error.p2p.FolderPack.md5.v2.log"
# echo "ADM DEBUG ########################################################"
# echo "ADM DEBUG ### Reduz numero de linhas do log $FileMark"
# NEWLogSwp=`busybox cat $FileMark | busybox head -n100`
# echo -n "$NEWLogSwp" > $FileMark



RequestData=`/system/bin/transmission-remote -t $torID -i`
FileMark="/data/trueDT/peer/Sync/_Last_LOOP.live"
date +"%d/%m/%Y %H:%M:%S" > $FileMark
busybox du -hs "/data/asusbox/.install/" >> $FileMark
echo "$RequestData" | busybox grep "Name:" >> $FileMark
echo "$RequestData" | busybox grep "State:" >> $FileMark
echo "$RequestData" | busybox grep "Hash:" >> $FileMark
echo "$RequestData" | busybox grep "Percent Done:" >> $FileMark
echo "$RequestData" | busybox grep "Have:" >> $FileMark
echo "$RequestData" | busybox grep "Total size:" >> $FileMark

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Limpa o marcador criado pelo datacenter"
rm /data/trueDT/peer/Sync/ZZZ_Last_LOOP.live



# box trava em looping verificar se esta em sync com o server

# box pausa o sync com o server

# box apaga todos os arquivos de log da pasta sync

# box apaga o profile do sync para liberar recursos e não ficar monitorando as pastas


# # roda code unico para cliente
# FileExec="/data/trueDT/peer/Sync/sh.uniq/uniqCode.sh"
# if [ -e $FileExec ]; then
#     /system/bin/busybox kill -9 `/system/bin/busybox ps aux | grep uniqCode.sh | /system/bin/busybox grep -v grep | /system/bin/busybox awk '{print $1}'`
#     sh $FileExec &
# fi

# ideias para rodar scripts direto da pasta syncthing
# - preciso criar uma regra para executar apenas código via call de script boot
# ? criar script em 7z com senha. o loader no script de boot aplica a senha
# + se a senha estiver errada ou desatualizada o script não roda


USBLOGCALL="p2p pack verify pass"
OutputLogUsb


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/099.9 b scripts para grupos de privilegios.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



# echo "ADM DEBUG #############################################################"
# echo "ADM DEBUG ### scripts for BoxListSyncthingAlwaysOn "
# echo "ADM DEBUG ### precisa carregar primeiro que o syncthing loader global"
# checkUserAcess=`echo "$BoxListSyncthingAlwaysOn" | grep "$Placa=$CpuSerial=$MacLanReal"`
# if [ ! "$checkUserAcess" == "" ]; then
#     echo "ADM DEBUG ### ativa o syncthing para quem participar deste grupo BoxListSyncthingAlwaysOn"
#     if [ ! -f /data/trueDT/peer/TMP/BoxListSyncthingAlwaysOn ]; then
#         echo "enable" > /data/trueDT/peer/TMP/BoxListSyncthingAlwaysOn
#     fi
#     /data/asusbox/.sc/boot/initRc.drv/{START}.sh
#     sleep 5
#     /data/asusbox/.sc/boot/initRc.drv/config.defaults.sh
# fi


# echo "ADM DEBUG ########################################################"
# echo "ADM DEBUG ### scripts for BoxListBetaInstallers"
# checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial=$MacLanReal"`
# if [ ! "$checkUserAcess" == "" ]; then
#     # roda os scripts q existir nesta pasta
#     Folder="/data/trueDT/peer/BOOT/sh.dev"
#     if [ -d $Folder ]; then
#         echo "ADM DEBUG ########################################################"
#         echo "ADM DEBUG ### Runnig dev scripts"
#         /system/bin/busybox find $Folder -type f -name "*.sh" |while read FullFilePath; do
#             echo "ADM DEBUG ### $FullFilePath"
#             Senha7z="98ads59f78da5987f5a97d8s5f96ads85f968da78dsfynmd-9as0f-09ay8df876asd96ftadsb8f7an-sd809f"
#             Code=$(/system/bin/7z x -so -p$Senha7z "$FullFilePath")
#             eval "$Code"
#         done
#     fi
# fi


# echo "ADM DEBUG ########################################################"
# echo "ADM DEBUG ### scripts for BoxListADMIN"
# checkUserAcess=`echo "$BoxListADMIN" | grep "$Placa=$CpuSerial=$MacLanReal"`
# if [ ! "$checkUserAcess" == "" ]; then
#     Folder="/data/trueDT/peer/BOOT/sh.admin"
#     if [ -d $Folder ]; then
#         echo "ADM DEBUG ########################################################"
#         echo "ADM DEBUG ### Runnig admin scripts"
#         /system/bin/busybox find $Folder -type f -name "*.sh" |while read FullFilePath; do
#             echo "ADM DEBUG ### $FullFilePath"
#             Senha7z="98ads59f78da5987f5a97d8s5f96ads85f968da78dsfynmd-9as0f-09ay8df876asd96ftadsb8f7an-sd809f"
#             Code=$(/system/bin/7z x -so -p$Senha7z "$FullFilePath")
#             eval "$Code"
#         done
#     fi
# fi





    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/099.9 c syncthing LOADER.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# # criar um função para o start loader do syncthing
# function DELFoldersPairs () {
#     # ANTIGOS PROFILES NÃO PODE APAGAR DA PASTA INIT
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### remove server MGADARQ"
#     /data/asusbox/.sc/boot/initRc.drv/MGADARQ=DEL.LOG.sh
#     /data/asusbox/.sc/boot/initRc.drv/MGADARQ=DEL.BOOT.sh
#     # novos configs pair
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### remove server "
#     /data/asusbox/.sc/boot/initRc.drv/ServerPair=DEL.Upload.Log.sh
#     /data/asusbox/.sc/boot/initRc.drv/ServerPair=DEL.BOOT.sh
# }

# function ImportProfilesPairs () {
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### importa os profiles"
#     /data/asusbox/.sc/boot/initRc.drv/ServerPair=iMPORT.Upload.Log.sh
#     /data/asusbox/.sc/boot/initRc.drv/ServerPair=IMPORT.BOOT.sh
# }


# os clientes só vão ligar o syncthing se tiver novidades no UPdateSystem!
# + vai economizar recursos de CPU na box

echo -n "$SHCBootVersion" > /data/trueDT/peer/Sync/BootVersion.live

rm /data/trueDT/peer/TMP/SHCBootVersion > /dev/null 2>&1
rm /data/trueDT/peer/Sync/SHCBootVersion > /dev/null 2>&1
rm /data/trueDT/peer/Sync/BootVersion > /dev/null 2>&1

# checkVersion=`cat /data/trueDT/peer/TMP/BootVersion`
# if [ ! "$checkVersion" == "$SHCBootVersion" ]; then
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### Nova versão de SHCBootVersion detectado!"
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### boot start syncthing via screen"
#     /data/asusbox/.sc/boot/initRc.drv/{START}.sh
# 	echo "$(date +"%d/%m/%Y %H:%M:%S") sync realtime started" > $LogRealtime
# 	# aqui fica o registro de geo localização
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### setting default configs to syncthing"
#     echo "ADM DEBUG ### sleep necessário  para não dar erro nas configs"
#     /data/asusbox/.sc/boot/initRc.drv/config.defaults.sh
#     DELFoldersPairs
#     ImportProfilesPairs
#     # load script Qrcode ID
#     /data/asusbox/.sc/boot/initRc.drv/Qrcode.ID.sh
#     # load script qrcode IP
#     /data/asusbox/.sc/boot/initRc.drv/Qrcode.IP.Local.sh
# fi


# clean file logs
busybox find "/data/trueDT/peer/Sync/" -type f -name "*.p2p.FolderPack*.log" -delete
busybox find "/data/trueDT/peer/Sync/" -type f -name "p2p.status.*.live" -delete

# diretorios obsoletos migrar para lugar devido
# futuro fazer um eco para arquivo externo e concatenar com a variavel da limpeza
listApagar="/data/trueDT/peer/Sync/sh.admin
/data/trueDT/peer/Sync/sh.all
/data/trueDT/peer/Sync/sh.dev
/data/trueDT/peer/Sync/sh.uniq"
for delfolder in $listApagar; do
    if [ -d $delfolder ];then
       busybox rm -rf $delfolder
    fi
done





USBLOGCALL="sync loader step"
OutputLogUsb


    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/099.9 d syncthing fechamento === last script.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# echo "ADM DEBUG ### script de fechamento do generic user"

# # quem não participar desta lista tera seu syncthing fechado
# checkUserAcess=`echo "$BoxListSyncthingAlwaysOn" | grep "$Placa=$CpuSerial=$MacLanReal"`
# if [ "$checkUserAcess" == "" ]; then
#     rm /data/trueDT/peer/TMP/BoxListSyncthingAlwaysOn
# 	echo "$(date +"%d/%m/%Y %H:%M:%S") End Script routine " > $LogRealtime
#     checkVersion=`cat /data/trueDT/peer/TMP/BootVersion`
#     if [ ! "$checkVersion" == "$SHCBootVersion" ]; then
# 		ServerConfigPath="/data/trueDT/peer/config/config.xml"
# 		API=$(cat "$ServerConfigPath" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
# 		WebPort=$(cat "$ServerConfigPath" | grep "127.0.0.1" | cut -d ":" -f 2 | cut -d "<" -f 1)
# 		User=$(cat "$ServerConfigPath" | grep "<user>" | cut -d ">" -f 2 | cut -d "<" -f 1)

# 		RemoteDevice="4W74FHY-6B2IOVI-RTE2BDJ-67C4I6V-6O7LADH-2TIOHZX-N7HRKTN-F7UK2A3"
# 		folderID="log_$Placa=$CpuSerial=$MacLanReal"

# 		echo "ADM DEBUG ########################################################"
# 		echo "ADM DEBUG ### override sendonly profile solução temporaria para o bug dos arquivos que somem"
# 		echo "ADM DEBUG ### p2p.status.Verifying.live error.p2p.FolderPack.md5.v2.log"
# 		curl -u "$User":"$User" -X POST -H "X-API-Key: $API" "http://127.0.0.1:$WebPort/rest/db/override?folder=log_$DeviceName"

# 		echo "ADM DEBUG ######################################################################"
# 		echo "ADM DEBUG ### força um scan na pasta LOG"
# 		curl -u "$User":"$User" -X POST -H "X-API-Key: $API" "http://127.0.0.1:$WebPort/rest/db/scan?folder=$folderID"

#         #while [ 1 ]; do # travar em loop pessima ideia se meu server estiver off
#         # 100 repetições com pausas de 3 segundos vai dar 5 minutos de espera no looping
#         for i in $(seq 1 20); do
#             data=`curl -u "$User":"$User" --silent -X GET -H "X-API-Key: $API" "http://127.0.0.1:$WebPort/rest/db/completion?folder=$folderID&device=$RemoteDevice"`
#             #echo "$data"
#             completion=`echo "$data" | grep "completion" | cut -d "," -f 1 | cut -d " " -f 4`
#             echo "Aguardando a pasta sincronizar em 100% estado atual = $completion%"
#             if [ "$completion" == "100" ]; then
#                 echo "ADM DEBUG ### Sincronizado! em = $completion%"
#                 echo "ADM DEBUG ### Gravando o marcador SHCBootVersion"
#                 # o marcador SHCBootVersion vai no final do loop apos a conclusão dos 100%
#                 # com isto não é possivel se ter a ultima versão do SHCBootVersion na pasta Sync
#                 echo -n "$SHCBootVersion" > "/data/trueDT/peer/TMP/BootVersion"
#                 break
#             else
#                 echo "Server Sync esta offline"
#             fi
#             sleep 3
#         done;
# 		# vai fechar o syncthing geral para todos!
# 		DELFoldersPairs
# 		"/data/asusbox/.sc/boot/initRc.drv/[STOP].sh"		
#     fi
# fi



"/data/asusbox/.sc/boot/initRc.drv/[STOP].sh"	


USBLOGCALL="initRc.drv [STOP]"
OutputLogUsb




    
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> /06.final.steps/loop/099.9-cpu-interactive-scaling_governor.sh"
echo "ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


echo -n "interactive" >  "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"

UUIDPath="/system/UUID.Uniq.key.txt"

echo "
Atualizado com sucesso!!!
KEY : $Placa=$CpuSerial
Secret : $(busybox cat $UUIDPath)
Security Tuneling by [$(/data/bin/openssl version | cut -d " " -f 1)]
Agendado próxima atualização: $(busybox cat /data/asusbox/crontab/Next_cron.updates.sh)

" > "$bootLog" 2>&1


echo "Finish code boot! :)"


USBLOGCALLSet="remove"
OutputLogUsb


