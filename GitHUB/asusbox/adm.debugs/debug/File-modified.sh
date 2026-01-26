#!/system/bin/sh


clear

app="asusbox.tv"
/system/bin/busybox cksum /data/app/$app*/base.apk | /system/bin/busybox cut -d "/" -f 1
exit

/system/bin/busybox md5sum /data/app/com.asx4k*/base.apk | /system/bin/busybox cut -d "/" -f 1
/system/bin/busybox md5sum /data/app/com.zntv*/base.apk | /system/bin/busybox cut -d "/" -f 1
/system/bin/busybox md5sum /data/app/asusbox.tv*/base.apk | /system/bin/busybox cut -d "/" -f 1
# real    0m0.964s
# user    0m0.720s
# sys     0m0.200s
exit



/system/bin/busybox cksum /data/app/com.asx4k*/base.apk | /system/bin/busybox cut -d "/" -f 1
/system/bin/busybox cksum /data/app/com.zntv*/base.apk | /system/bin/busybox cut -d "/" -f 1
/system/bin/busybox cksum /data/app/asusbox.tv*/base.apk | /system/bin/busybox cut -d "/" -f 1
# real    0m0.795s
# user    0m0.450s
# sys     0m0.290s
exit






# zntv mostra mensagem pra os users








# apps atuais
4d85a58d4e511601a37502bb33285914  /data/app/com.asx4k-1/base.apk
3ff3b87c23dcd1883af94b8dd8171a14  /data/app/com.zntv-1/base.apk
97062c88a0a1631e001747d55f298652  /data/app/asusbox.tv-1/base.apk

# apps novos
7ff4e5984da6b09d42bdc7b6b878c3a9  /data/app/com.asx4k-2/base.apk
4e7f93b41e0fa76c213a11fd7e4b75cd  /data/app/com.zntv-2/base.apk
ecca7798fc917209310b645352b95730  /data/app/asusbox.tv-2/base.apk









versão que eu instalei nova
usar baseado em date


ls -l /data/app/com.asx4k*/base.apk
-rw-r--r-- 1 system system 30837647 2021-04-10 10:11 /data/app/com.asx4k-2/base.apk


/system/bin/busybox stat /data/app/com.asx4k*/base.apk

/system/bin/busybox du /data/app/com.asx4k*/base.apk



/system/bin/busybox du /data/app/com.asx4k*/base.apk
/system/bin/busybox du /data/app/com.zntv*/base.apk
/system/bin/busybox du /data/app/asusbox.tv*/base.apk


30116   /data/app/com.asx4k-2/base.apk
10280   /data/app/com.zntv-1/base.apk
14784   /data/app/asusbox.tv-1/base.apk




# sistema antigo pesquisa pela versão do app
if [ -d /data/data/$app ] ; then
    versionLocal=`dumpsys package $app | /system/bin/busybox grep versionName | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox head -n 1`
else

fi

echo $versionLocal



#####################################

versionNameOnline="App exportado em = Sat Apr 10 12:25:09 BRT 2021"
versionNameOnline="3.30"



versionNameOnline="App exportado em = $(date)"


app="asusbox.tv"


checkVar=`echo $versionNameOnline | /system/bin/busybox cut -d "=" -f 1`
if [ "$checkVar" == "App exportado em " ]; then
        echo "Novo sistema de verificação por data do export"


# gravando o registro de versão do apk
if [ ! -d /data/asusbox/log.app ]; then
mkdir -p /data/asusbox/log.app
fi

/system/bin/busybox cat <<EOF > "/data/asusbox/log.app/$app"
$app
$versionNameOnline
$apkName
$apkFakeName
EOF

# extraindo a versao do apk


    else
        echo "sistema antigo"
fi



/system/bin/busybox sed -n '2p' < "/data/asusbox/log.app/$app"



# echo $versionNameOnline 


exit



$versionNameOnline.appVersion






df -h | grep "rknand_userdata"
df -h | grep "rknand_system"



du -h -d 1 /data/asusbox/.install




exit

min="5"

path=$(dirname $0)
FindPath="/system"

/system/bin/busybox find $FindPath -mmin -$min > $path/fileModified-system-$min.log 2>&1

path=$(dirname $0)
FindPath="/data"
/system/bin/busybox find $FindPath -mmin -$min > $path/fileModified-data-$min.log 2>&1



exit
















PROCESS="daemonsu"
/system/bin/busybox ps -eaf | grep -v grep | grep $PROCESS | grep -v $$








