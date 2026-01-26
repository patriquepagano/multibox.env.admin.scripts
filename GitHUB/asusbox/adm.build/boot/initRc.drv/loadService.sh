#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )
syncthing="/system/bin/initRc.drv.05.08.98"

ConfigPath="/data/trueDT/peer/config"
defaultConfig="$ConfigPath/config.xml"

# marcador de serviço ativo
rm /data/trueDT/peer/Sync/start.initRc.drv.date > /dev/null 2>&1

if [ ! -d $ConfigPath ]; then
    mkdir -p $ConfigPath
fi

# cliente mesmo gera os certificados e salva na system em caso de hardreset
if [ ! -f "$ConfigPath/key.pem" ] ; then    
    if [ -f "/system/vendor/pemCerts.7z" ] ; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### em caso de hardreset aqui restaura o pack"
        Senha7z="98as6d5876f5as876d5f876as5d8f765as87d"
        /system/bin/7z x -aoa -y -p$Senha7z "/system/vendor/pemCerts.7z" -oc:$ConfigPath > /dev/null 2>&1
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### gerando config.xml e omitindo geraçao de novas keys"
        $syncthing -generate="$ConfigPath"
        if [ ! -f /data/trueDT/peer/config/config.xml ];then
        while [ 1 ]; do
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### aguardando config.xml ser escrito"
            if [ -f /data/trueDT/peer/config/config.xml ];then break; fi;
            echo "Wait for file"
            sleep 1;
        done;
        fi
    else
        # gera um novo key e faz o backup na system
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### First boot, gerando novas keys.pem"
        HOME="/data/trueDT/peer"
        $syncthing -generate="$ConfigPath"
        if [ ! -f /data/trueDT/peer/config/config.xml ];then
        while [ 1 ]; do
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### aguardando config.xml ser escrito"
            if [ -f /data/trueDT/peer/config/config.xml ];then break; fi;
            echo "Wait for file"
            sleep 1;
        done;
        fi
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### 7Z backup pemCerts.7z"
        Senha7z="98as6d5876f5as876d5f876as5d8f765as87d"
        Files="$ConfigPath/*.pem"        
        /system/bin/7z a -mx=9 -p$Senha7z -mhe=on -t7z -y "$ConfigPath/pemCerts" $Files
        # move os certificados para system em caso de restore
        /system/bin/busybox mount -o remount,rw /system
        mkdir -p /system/vendor
        mv "$ConfigPath/pemCerts.7z" /system/vendor/
        /system/bin/busybox mount -o remount,ro /system
    fi
fi

WebPort=$(cat "/data/trueDT/peer/config/config.xml" | grep "127.0.0.1" | cut -d ":" -f 2 | cut -d "<" -f 1)
if [ ! "$WebPort" == "4442" ]; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### First config | alterando para porta 4442"
    killall initRc.drv.05.08.98
    killall initRc.drv.05.08.98
    killall initRc.drv.05.08.98
    /system/bin/busybox sed -i -e 's;<address>127.0.0.1:.*</address>;<address>127.0.0.1:4442</address>;g' /data/trueDT/peer/config/config.xml
fi


# precisa ficar sempre aqui no start do service para sempre overwrite
echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### extrai o syncID"
SyncID=`$syncthing -device-id -home=$ConfigPath`
echo -n $SyncID > /data/trueDT/peer/Sync/serial.live

date +"%d/%m/%Y %H:%M:%S" > /data/trueDT/peer/Sync/start.initRc.drv.date

HOME="/data/trueDT/peer"
$syncthing --unpaused --no-browser --no-default-folder -home=$HOME/config





