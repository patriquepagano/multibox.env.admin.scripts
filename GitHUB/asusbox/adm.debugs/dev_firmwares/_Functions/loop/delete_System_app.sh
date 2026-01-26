function delete_System_app () {

file="${0%/*}/RemoveList/System-apps.sh.TMP"
cp "${0%/*}/RemoveList/System-apps.sh" "$file"
# remove comentários
/system/bin/busybox sed -i -e 's/\s*#.*$//' "$file"
# remove TABS
/system/bin/busybox sed -i -e 's|^[[:blank:]]*||g' "$file"
/system/bin/busybox sed -i -e 's/[[:blank:]]*$//' "$file"
# remove acho que novas linhas
/system/bin/busybox sed -i -e '/^\s*$/d' "$file"

files=`/system/bin/busybox cat "$file"`
for loop in $files; do	
app=`echo $loop | cut -d "/" -f 4`
data=`echo $loop | cut -d "=" -f 2`
    if [ -e /system/app/$app ] ; then
        echo 'Removendo ' $app
        echo 'Removendo data' $data
        /system/bin/busybox mount -o remount,rw /system
        pm disable $data
        rm -rf /system/app/$app
        rm -rf /data/data/$data
    fi
done
rm "$file"

if [ ! -f /system/app/org.cosinus.launchertv_1.5.3.apk ]; then
/storage/DevMount/GitHUB/asusbox/adm.debugs/_install_base_system/6_app_system/install.sh
fi

}


