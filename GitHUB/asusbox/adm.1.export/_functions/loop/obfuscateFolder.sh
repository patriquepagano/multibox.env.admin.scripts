function obfuscateFolder () {
echo "############################################################################"
echo "Deseja compilar via shc digite on"
echo "############################################################################"
echo ""
read input
shc=$input

GenPackF="/data/local/tmp/GenPack/"
mkdir -p $GenPackF > /dev/null 2>&1
# copiar a pasta para o TMP
/system/bin/rsync --progress -avz --delete --recursive --force $DevFolder/ $GenPackF > /dev/null 2>&1
# limpar os códigos
/system/bin/busybox find $GenPackF -type f \( -iname \*.sh \) | /system/bin/busybox sort | while read fname; do
    #echo "$fname"
    if [ "$shc" = "on" ];then
        # remove TABS
        /system/bin/busybox sed -i -e 's|^[[:blank:]]*||g' "$fname"
        # remove todos echo ADM comentando o mesmo
        /system/bin/busybox sed -i -e  's/echo "ADM DEBUG ###.*/#barbaridade/g' "$fname"
        # remove comentários
        /system/bin/busybox sed -i -e 's/\s*#.*$//' "$fname"
        # insere na primeira linha
        /system/bin/busybox sed -i -e '1i#!/system/bin/sh\' "$fname"
        #/system/bin/busybox sed -i -e '1i#!/system/usr/bin/bash\' "$fname"
        # remove novas linhas
        /system/bin/busybox sed -i -e '/^\s*$/d' "$fname"
        # altera os paths
        /system/bin/busybox sed -i -e 's;/storage/DevMount/GitHUB/asusbox/adm.build;/data/asusbox/.sc;g' "$fname"

        if [ ! -f /system/bin/cc ];then
            /system/bin/busybox mount -o remount,rw /system
            ln -sf /storage/DevMount/AndroidDEV/termux/files/usr/bin/shc /system/bin/shc
            ln -sf /storage/DevMount/AndroidDEV/termux/files/usr/bin/clang-10 /system/bin/cc
            ln -sf /storage/DevMount/AndroidDEV/termux/files/usr/bin/strip /system/bin/strip
        fi
        if [ -f /data/data/com.termux/files/usr/bin/shc ];then
            clear
            echo "Termux + SHC detectado!"
            echo "Compilando script via shc"
            # shc File
            # /data/data/com.termux/files/usr/bin/shc -v -f "$fname" -e 20/10/2035
            /data/data/com.termux/files/usr/bin/shc -vr -f "$fname"
            rm "$fname.x.c"
            mv "$fname.x" "$fname"
        fi
    fi

    chmod 700 "$fname"
done

rm $GenPackF/keys.hash > /dev/null 2>&1
/system/bin/busybox find $GenPackF -type f \( -iname \*.sh -o -iname \*.ini -o -iname \.vars -o -iname \*.conf -o -iname fcgiserver \) | /system/bin/busybox sort | while read fname; do
    #echo "$fname"
    /system/bin/busybox md5sum "$fname" | /system/bin/busybox cut -d ' ' -f1 >> $GenPackF/keys.hash 2>&1
done
# seta a nova variavel da versão para a ficha tecnica
echo ""
echo "Alterado na ficha técnica do $app versionBinOnline abaixo"
export versionBinOnline=`/system/bin/busybox md5sum "$GenPackF/keys.hash" | /system/bin/busybox cut -d ' ' -f1`
echo "versionBinOnline=\"$versionBinOnline\""
echo ""
# alterando o version da ficha técnica
sed -i -e "s/versionBinOnline=".*"/versionBinOnline=\"$versionBinOnline\"/g" $SCRIPT
}





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



