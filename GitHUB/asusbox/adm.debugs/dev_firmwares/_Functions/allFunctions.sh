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


function delete_system_files () {

file="${0%/*}/RemoveList/system_files.sh.TMP"
cp "${0%/*}/RemoveList/system_files.sh" "$file"
# remove comentários
/system/bin/busybox sed -i -e 's/\s*#.*$//' "$file"
# remove TABS
/system/bin/busybox sed -i -e 's|^[[:blank:]]*||g' "$file"
/system/bin/busybox sed -i -e 's/[[:blank:]]*$//' "$file"
# remove acho que novas linhas
/system/bin/busybox sed -i -e '/^\s*$/d' "$file"

files=`/system/bin/busybox cat "$file"`

/system/bin/busybox mount -o remount,rw /system

for loop in $files; do
echo "vou apagar $loop"
/system/bin/busybox rm -rf "$loop"
done

df -h | grep system

}

function list_System_app () {

# para gerar a lista na box
export APPs=`pm list packages -f | grep -e '/system/app/' | sort`
APPsList=`echo "$APPs" | cut -d ":" -f 2`
echo "$APPsList"

}


function list_priv_app () {

# para gerar a lista na box
export APPs=`pm list packages -f | grep -e '/system/priv-app/' | sort`
APPsList=`echo "$APPs" | cut -d ":" -f 2`
echo "$APPsList"

}


function uninstall_user_apps () {
    
remove=`pm list packages -3 | sed -e 's/.*://' | sort \
| grep -v "com.termux" \
| grep -v "org.cosinus.launchertv" \
| grep -v "berserker.android.apps.sshdroid"`
for loop in $remove; do
echo $loop
pm uninstall $loop
done

}


