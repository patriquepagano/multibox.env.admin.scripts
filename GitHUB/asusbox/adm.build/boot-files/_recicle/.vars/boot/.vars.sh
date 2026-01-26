export PATH=/system/bin:/system/xbin
export LD_LIBRARY_PATH=/system/lib
export Senha7z="6ads5876f45a9sdf7as975a87"
export Produto="asusbox"
export PHome="/data/$Produto"
export HOME="/data/$Produto"


# sempre escreve no boot o android id
GetID=`settings get secure android_id` # puxa o ultimo id do android
export ID=`cat /data/$Produto/android_id` # id variavel que muda no hard reset
# compara para escrever apenas se mudou
if [ ! "$GetID" = "$ID" ];then
	echo "novo id instalado"
	echo -n $GetID > /data/$Produto/android_id # escreve novo id
	export ID=`cat /data/$Produto/android_id` # carrega o novo id
fi

# novo sistema que trava em loop até conseguir baixar o uuid
# em breve o uuid sera o seria key
export UUID=`cat /system/UUID`
if [ "$UUID" = "" ] ; then
while [ 1 ]; do
    echo "Baixando novo UUID"
	while [ 1 ]; do
		UUID=`/system/bin/curl "http://personaltecnico.net/Android/RebuildRoms/keyaccess.php"`
		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
		sleep 1;
	done;
	/system/bin/busybox mount -o remount,rw /system
	echo -n $UUID > /system/UUID
    export UUID=`cat /system/UUID`
     echo "Verificando UUID > $UUID"   
    if [  "$UUID" = "" ];then
        $?="1"	
    fi
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
fi



export ID=`cat /data/$Produto/android_id`
export UUID=`cat /system/UUID`
export CPU=`getprop ro.product.cpu.abi | sed -e 's/ /_/g'`
export Modelo=`getprop ro.product.model`
export RomBuild=`getprop ro.build.description | sed -e 's/ /_/g'`
export chmod="/system/bin/busybox chmod"
export chown="/system/bin/busybox chown"
export sleep="/system/bin/busybox sleep"
export mkdir="/system/bin/busybox mkdir"
export date="/system/bin/busybox date"
export rm="/system/bin/busybox rm"
export cat="/system/bin/busybox cat"
export dos2unix="/system/bin/busybox dos2unix"
export sed="/system/bin/busybox sed"
export wget="/system/bin/wget"
export Zip="/system/bin/7z"
export aria2c="/system/bin/aria2c"
export curl="/system/bin/curl"
export rsync="/system/bin/rsync"
export grep="/system/bin/busybox grep"
export awk="/system/bin/busybox awk"
export mount="/system/bin/busybox mount"
export md5sum="/system/bin/busybox md5sum"
export head="/system/bin/busybox head"
export du="/system/bin/busybox du"
export base64="/system/bin/busybox base64"
export ls="/system/bin/busybox ls"
export kill="/system/bin/busybox kill"
export pgrep="/system/bin/busybox pgrep"
export cp="/system/bin/busybox cp"
export mv="/system/bin/busybox mv"
export tar="/system/bin/busybox tar"
export cut="/system/bin/busybox cut"
export find="/system/bin/busybox find"
export sort="/system/bin/busybox sort"
export xargs="/system/bin/busybox xargs"
export stat="/system/bin/busybox stat"
export shellBin=`echo IyEvc3lzdGVtL2Jpbi9zaA== | $base64 -d`
export onLauncher="pm enable dxidev.toptvlauncher2"
export conf="/data/$Produto/.conf"
export www="$EXTERNAL_STORAGE/Android/data/$Produto/.www"
export systemLog="$www/system.log"
export wgetLog="$www/wget.log"
export bootLog="$www/boot.log"
export userLog="$www/user.log"
export lighttpd="/system/bin/lighttpd"
export php="$conf/fcgiserver"
export wwwup="$EXTERNAL_STORAGE/Android/data/$Produto/.updates"
export fileUpdates="/data/$Produto/.updates"
# export fileChanges="$www/filechanges"
# export SystemShare=/system/share

# if [ ! -d $SystemShare ];then
#     /system/bin/busybox mount -o remount,rw /system
#     $mkdir -p $SystemShare
# fi

# if [ ! -d $fileChanges ];then
#     $mkdir -p $fileChanges
# fi

if [ ! -d $conf ];then
    $mkdir -p $conf
fi








# end



