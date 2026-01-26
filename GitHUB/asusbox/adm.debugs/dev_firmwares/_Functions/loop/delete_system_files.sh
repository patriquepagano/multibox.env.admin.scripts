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

