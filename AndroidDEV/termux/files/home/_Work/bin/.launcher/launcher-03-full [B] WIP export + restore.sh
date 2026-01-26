#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )
package="dxidev.toptvlauncher2"
profile="launcher-03-full"

pm disable $package
#rm -rf /data/data/dxidev.toptvlauncher2/launcher*

# mkdir -p /data/data/dxidev.toptvlauncher2/launcher-01-Install-apps
# mkdir -p /data/data/dxidev.toptvlauncher2/launcher-02-update
mkdir -p /data/data/dxidev.toptvlauncher2/$profile
# mkdir -p /data/data/dxidev.toptvlauncher2/launcher-04-offline
# mkdir -p /data/data/dxidev.toptvlauncher2/launcher-05-vps-offline


# fix para generalizar todos no mesmo path
/system/bin/busybox sed -i -e 's;/sdcard/;/storage/emulated/0/;g' $path/$profile.xml

Files=`cat $path/$profile.xml | grep "/storage/emulated/0" | cut -d ">" -f 2 | cut -d "<" -f 1`
if [ ! "$Files" == "" ]; then
    echo "$Files" | while IFS= read -r line ; do
        #echo "$line"
        FileName=`basename "$line"`
        rsync "$line" /data/data/dxidev.toptvlauncher2/$profile/
        echo "editando o path do arquivo $FileName ao config"
        /system/bin/busybox sed -i -e "s;$line;/data/data/dxidev.toptvlauncher2/$profile/$FileName;g" $path/$profile.xml
    done
fi

# copy files config
cp $path/$profile.xml /data/data/$package/$profile.xml
cp /data/data/$package/$profile.xml /data/data/$package/shared_prefs/PREFERENCE_DATA.xml

# não utilizar symlink mais!
#ln -sf /data/data/$package/$profile.xml /data/data/$package/shared_prefs/PREFERENCE_DATA.xml


echo "limpando arquivos obsoletos"
/system/bin/busybox find "/data/data/$package/$profile" -type f -name "*" \
| while read fname; do
    check=`cat /data/data/$package/$profile.xml | grep "$fname"`
    if [ "$check" == "" ]; then
    echo " este arquivo não consta no arquivo xml:
    $fname
    o arquivo foi deletado!
    "
    rm "$fname"
    fi
done

chmod 777 -R /data/data/dxidev.toptvlauncher2/launcher*
uid=`dumpsys package $package \
| /system/bin/busybox grep "userId" \
| /system/bin/busybox cut -d "=" -f 2 \
| /system/bin/busybox cut -d " " -f 1`

/system/bin/busybox chown -R $uid:$uid /data/data/$package
/system/bin/busybox chmod 660 /data/data/$package/shared_prefs/*.xml
restorecon -FR /data/data/$package



echo "Criando backup temporario"
tar -czvf $path/$profile.tar.gz /data/data/$package



### para quem ja tiver a launcher só força o setting
pm enable $package
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
am start -a android.intent.action.MAIN -c android.intent.category.HOME

