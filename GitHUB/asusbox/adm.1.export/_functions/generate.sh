
#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib


# funções
file=$DIR/_functions/allFunctions.sh
rm $file > /dev/null 2>&1
/system/bin/busybox find "$DIR/_functions/loop" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    #echo $fname
    cat $fname >> $file
done

# # remove todos echo ADM comentando o mesmo
# /system/bin/busybox sed -i -e  's/echo "ADM DEBUG ###.*/#/g' $file
# # remove comentários
# /system/bin/busybox sed -i -e 's/\s*#.*$//' $file
# # remove TABS
# /system/bin/busybox sed -i -e 's|^[[:blank:]]*||g' $file
# /system/bin/busybox sed -i -e 's/[[:blank:]]*$//' $file
# # remove acho que novas linhas
# /system/bin/busybox sed -i -e '/^\s*$/d' $file
# # adiciona a primeira linha operator
# /system/bin/busybox sed -i '1s;^;#!/system/bin/sh \n;' $file



