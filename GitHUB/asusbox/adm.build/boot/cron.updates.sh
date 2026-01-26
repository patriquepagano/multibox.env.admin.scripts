#!/system/bin/sh
clear

date > /data/asusbox/crontab/LOCK_cron.updates


DIR=$( cd "${0%/*}" && pwd -P )
if [ "$DIR" == "/storage/DevMount/GitHUB/asusbox/adm.build/boot" ] ; then
    EnableDEVMode="YES"
fi


# atenção dev do futuro! este code abaixo derruba o UpdateSystem.sh na ronda do cron a cada 1 hora caso esteja travado em loop
ScriptFile="UpdateSystem.sh"
while true ;do    
    killPort=`/system/bin/busybox ps aux | grep $ScriptFile | /system/bin/busybox grep -v grep | awk '{print $1}'`    
	if [ ! "$killPort" == "" ]; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $ScriptFile rodando na porta > $killPort "
        echo "ADM DEBUG ### close $ScriptFile > $killPort"
        /system/bin/busybox kill -9 $killPort
        logcat -c
    else
        break
    fi
done

ScriptFile="p2p+check.sh"
while true ;do    
    killPort=`/system/bin/busybox ps aux | grep $ScriptFile | /system/bin/busybox grep -v grep | awk '{print $1}'`    
	if [ ! "$killPort" == "" ]; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $ScriptFile rodando na porta > $killPort "
        echo "ADM DEBUG ### close $ScriptFile > $killPort"
        /system/bin/busybox kill -9 $killPort
        logcat -c
    else
        break
    fi
done

ScriptFile="update+check.sh"
while true ;do    
    killPort=`/system/bin/busybox ps aux | grep $ScriptFile | /system/bin/busybox grep -v grep | awk '{print $1}'`    
	if [ ! "$killPort" == "" ]; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $ScriptFile rodando na porta > $killPort "
        echo "ADM DEBUG ### close $ScriptFile > $killPort"
        /system/bin/busybox kill -9 $killPort
        logcat -c
    else
        break
    fi
done


####################################################################################################
# novo sistema!
# verificar se o pacote torrent é novo e baixa o torrent e atualiza o pacote
if [ "$EnableDEVMode" == "YES" ] ; then
    "/storage/DevMount/GitHUB/asusbox/adm.build/boot/p2p+check.sh"
else
    "/data/asusbox/.sc/boot/p2p+check.sh"
fi

# verificar se o updatesystem.sh é novo e baixa se for
if [ "$EnableDEVMode" == "YES" ] ; then
    "/storage/DevMount/GitHUB/asusbox/adm.build/boot/update+check.sh"
else
    "/data/asusbox/.sc/boot/update+check.sh"
fi


