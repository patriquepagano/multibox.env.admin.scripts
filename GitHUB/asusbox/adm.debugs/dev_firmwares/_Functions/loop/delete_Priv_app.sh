function delete_Priv_app () {

file="${0%/*}/RemoveList/priv-apps.sh.TMP"
cp "${0%/*}/RemoveList/priv-apps.sh" "$file"
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
    if [ -e /system/priv-app/$app ] ; then
        echo 'Removendo ' $app
        /system/bin/busybox mount -o remount,rw /system
        pm disable $data
        rm -rf /system/priv-app/$app
        rm -rf /data/data/$data
    fi
done
rm "$file"

}


