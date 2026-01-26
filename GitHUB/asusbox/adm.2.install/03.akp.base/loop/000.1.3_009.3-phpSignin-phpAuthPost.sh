
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

FirmwareFullSpecs=`busybox cat /data/trueDT/peer/Sync/Debug-collect-data.sh | busybox sed "s;';;g"`

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
UpdateSystemVersion="TorrentPack=\"$TorrentPackVersion\"|SHCBootVersion=\"$SHCBootVersion\"|$UpdateSystemUnix|$UpdateSystemDate|$UpdateSystemMD5"
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


