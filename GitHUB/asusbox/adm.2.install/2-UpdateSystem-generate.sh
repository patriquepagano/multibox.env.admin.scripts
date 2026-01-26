#!/system/bin/sh

DIR=$(dirname $0)
CPU=`getprop ro.product.cpu.abi`
file="$DIR/UpdateSystem-$CPU.sh"

echo "#!/system/bin/sh" > $file
#echo "#!/system/usr/bin/bash" > $file
echo "" >> $file

#############################################################################################################################
# funções
path="$DIR/_functions/firmware"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    echo "$fname"
    cat "$fname" >> $file
done
#############################################################################################################################

# 02.files
path="$DIR/02.files/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    echo "$fname"
    cat "$fname" >> $file
done

# 03.akp.base
path="$DIR/03.akp.base/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    echo "$fname"
    cat "$fname" >> $file
done

# 04.akp.oem
path="$DIR/04.akp.oem/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    echo "$fname"
    cat "$fname" >> $file
done

# # 05.akp.cl
# path="$DIR/05.akp.cl/loop"
# /system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
#     echo "$fname"
#     cat "$fname" >> $file
# done

# 06.final.steps
path="$DIR/06.final.steps/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    echo "$fname"
    cat "$fname" >> $file
done


echo "############################################################################"
echo "Deseja compilar via shc digite on"
echo "############################################################################"
echo ""
read input
shc=$input

if [ "$shc" == "on" ]; then
#############################################################################################################################
    # remove todos echo ADM comentando o mesmo
    /system/bin/busybox sed -i -e  's/echo "ADM DEBUG ###.*/#barbaridade/g' $file
    # remove comentários
    /system/bin/busybox sed -i -e 's/\s*#.*$//' $file
    # remove TABS
    /system/bin/busybox sed -i -e 's|^[[:blank:]]*||g' $file
    /system/bin/busybox sed -i -e 's/[[:blank:]]*$//' $file
    # remove acho que novas linhas
    /system/bin/busybox sed -i -e '/^\s*$/d' $file
    # adiciona a primeira linha operator
    /system/bin/busybox sed -i '1s;^;#!/system/bin/sh \n;' $file
    # shc File
    #/data/data/com.termux/files/usr/bin/shc -v -f $file -e 20/10/2035
    /data/data/com.termux/files/usr/bin/shc -vr -f "$file"
    rm $file.x.c
    mv $file.x $file    
fi






# permissão de execução
chmod 700 $file*


# sobre o shc
# https://github.com/yanncam/UnSHc
# root@server:~/shc/shc-3.8.9# shc -h
# shc Version 3.8.9, Generic Script Compiler
# shc Copyright (c) 1994-2012 Francisco Rosales <frosal@fi.upm.es>
# shc Usage: shc [-e date] [-m addr] [-i iopt] [-x cmnd] [-l lopt] [-rvDTCAh] -f script
# -e %s Expiration date in dd/mm/yyyy format [none]
# -m %s Message to display upon expiration [&quot;Please contact your provider&quot;]
# -f %s File name of the script to compile
# -i %s Inline option for the shell interpreter i.e: -e
# -x %s eXec command, as a printf format i.e: exec('%s',@ARGV);
# -l %s Last shell option i.e: --
# -r Relax security. Make a redistributable binary
# -v Verbose compilation
# -D Switch ON debug exec calls [OFF]
# -T Allow binary to be traceable [no]
# -C Display license and exit
# -A Display abstract and exit
# -h Display help and exit
# Environment variables used:
# Name Default Usage
# CC cc C compiler command
# CFLAGS C compiler flags
# Please consult the shc(1) man page.