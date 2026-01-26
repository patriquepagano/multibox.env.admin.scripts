
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



