#!/system/bin/sh

app="com.netflix.mediaclient"

am force-stop $app


pm clear $app

# restores
cd /
/system/bin/busybox tar -mxvf "/data/trueDT/peer/Sync/cfg.uniq/$app.DT.tar.gz"

# permissao do user da pasta
DUser=`dumpsys package $app | /system/bin/busybox grep userId | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox head -n 1`
echo $DUser
chown -R $DUser:$DUser /data/data/$app
restorecon -FR /data/data/$app



exit

# backup
/system/bin/busybox tar -czvf "/data/trueDT/peer/Sync/cfg.uniq/$APP.DT.tar.gz" "/data/data/com.netflix.mediaclient/shared_prefs"










exit

APP="/data/data/com.netflix.mediaclient"


    echo "criando tar file"
    /system/bin/busybox tar -czvf "$path/$apkName/DTF/$apkName.DT.tar.gz" $Files
    echo "criando arquivo 7zip dos dados do > $app"
    /system/bin/7z -v7m a -mx=9 -p$Senha7z -mhe=on -t7z -y "$path/$apkName/DTF/$apkName.DTF" "$path/$apkName/DTF/$apkName.DT.tar.gz"
    rm "$path/$apkName/DTF/$apkName.DT.tar.gz"




