#!/system/bin/sh
clear

pathRoot=$( cd "${0%/*}" && pwd -P )

# echo "Compile NEW shc Boot
# press ok to continue"
# read bah
# if [ "$bah" == "ok" ]; then
# "$HOME/_Work/bin/.stop/1 STOP ALL HERE !!!.sh"
# fi

"/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/[ STOP ] Services/1 STOP ALL HERE !!!.sh" "skip"

export TZ=UTC−03:00
dateHuman="$(busybox date +"%d/%m/%Y %H:%M:%S")"
dateEpoch="$(busybox date +%s)"

echo ""
echo ""
echo "Digite qual mudança feita neste código de boot? ( mensagem será exibida para clientes )"
read wip

# gerando o marcador de versão do boot para ser empacotado junto.
echo "

SHCBootVersion=\"$dateEpoch = $dateHuman | $wip\"

" > "/storage/DevMount/GitHUB/asusbox/adm.2.install/00.boot/loop/000.1-Online.SHC.Boot-Version.sh"


CPU=`getprop ro.product.cpu.abi`
DIRFirm="/storage/DevMount/GitHUB/asusbox/adm.2.install"
DirPath="/storage/DevMount/GitHUB/asusbox/adm.3.Online/asusboxA1/boot/$CPU"

if [ ! -d $DirPath ]; then
    mkdir -p $DirPath
fi

file="$DirPath/UpdateSystem.sh"

# limpeza arquivos antigos
/system/bin/busybox find "$pathRoot" -maxdepth 1 -type f -name '*UpdateSystem-*[Official*Published]*.sh' | sort | while read fname; do
    echo "Apagando versão antiga > $(echo "$fname" | sed 's;/storage/DevMount/GitHUB/asusbox/adm.2.install;;g')"
    rm "$fname"
done


# rm /data/data/com.termux


echo "#!/system/bin/sh" > "$file"
#echo "#!/system/usr/bin/bash" > "$file"
echo "" >> "$file"

function WriteCodeHere () {
echo "    
echo \"ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\"
echo \"ADM DEBUG ### *** @@@ SCRIPT CODE PART =>>> $(echo "$fname" | sed 's;/storage/DevMount/GitHUB/asusbox/adm.2.install;;g')\"
echo \"ADM DEBUG ### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\"
" >> "$file"
cat "$fname" >> "$file"
echo "Loaded file = $(echo "$fname" | sed 's;/storage/DevMount/GitHUB/asusbox/adm.2.install;;g') to boot script."
}


#############################################################################################################################
# funções
path="$DIRFirm/_functions/firmware"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    WriteCodeHere
done
#############################################################################################################################


# 00.boot
path="$DIRFirm/00.boot/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    WriteCodeHere
done

# 00.snib
path="$DIRFirm/00.snib/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    WriteCodeHere
done

# 01.sc.base
path="$DIRFirm/01.sc.base/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    WriteCodeHere
done


# 02.files
path="$DIRFirm/02.files/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    WriteCodeHere
done

# 03.akp.base
path="$DIRFirm/03.akp.base/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    WriteCodeHere
done

# fichas tecnicas fazem parte do pacote torrent agora rodam como script offline
# # 04.akp.oem
# path="$DIRFirm/04.akp.oem/loop"
# /system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
#     echo "$fname"
#     cat "$fname" >> "$file"
#     echo "Loaded file = $(echo "$fname" | sed 's;/storage/DevMount/GitHUB/asusbox/adm.2.install;;g') to boot script."
# done

# # 05.akp.cl
# path="$DIRFirm/05.akp.cl/loop"
# /system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
#     echo "$fname"
#     cat "$fname" >> "$file"
#     echo "Loaded file = $(echo "$fname" | sed 's;/storage/DevMount/GitHUB/asusbox/adm.2.install;;g') to boot script."
# done

# 06.final.steps
path="$DIRFirm/06.final.steps/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    WriteCodeHere
done

cp "$file" "$pathRoot/[r] (OpenCode comments)   = $(date +"%d.%m.%Y %H.%M.%S" | sed 's;:;.;g') UpdateSystem-armeabi-v7a [Official Published].sh"

#############################################################################################################################
# # remove todos echo ADM comentando o mesmo
# /system/bin/busybox sed -i -e  's/echo "ADM DEBUG ###.*/#barbaridade/g' "$file"
# # remove comentários
# /system/bin/busybox sed -i -e 's/\s*#.*$//' "$file"
# # remove TABS
# /system/bin/busybox sed -i -e 's|^[[:blank:]]*||g' "$file"
# /system/bin/busybox sed -i -e 's/[[:blank:]]*$//' "$file"
# # remove acho que novas linhas
# /system/bin/busybox sed -i -e '/^\s*$/d' "$file"
# # adiciona a primeira linha operator
# /system/bin/busybox sed -i '1s;^;#!/system/bin/sh \n;' "$file"



# Remove debug echo lines that start with: echo "ADM DEBUG ###
/system/bin/busybox sed -i -e 's/echo "ADM DEBUG ###.*/#barbaridade/g' "$file"

# Remove full-line comments only (lines that START with #, ignoring indentation)
/system/bin/busybox sed -i -e '/^[[:blank:]]*#/d' "$file"

# Remove leading whitespace (spaces and tabs at the beginning of each line)
/system/bin/busybox sed -i -e 's|^[[:blank:]]*||g' "$file"

# Remove trailing whitespace (spaces and tabs at the end of each line)
/system/bin/busybox sed -i -e 's/[[:blank:]]*$//' "$file"

# Remove empty or whitespace-only lines
/system/bin/busybox sed -i -e '/^[[:blank:]]*$/d' "$file"

# Ensure the script has the correct shebang as the first line
/system/bin/busybox sed -i '1s;^;#!/system/bin/sh\n;' "$file"






cp "$file" "$pathRoot/[r] (OpenCode Clean)      = $(date +"%d.%m.%Y %H.%M.%S" | sed 's;:;.;g') UpdateSystem-armeabi-v7a [Official Published].sh"


# shc File
#/data/data/com.termux/files/usr/bin/shc -v -f "$file" -e 20/10/2035
/data/data/com.termux/files/usr/bin/shc -vr -f ""$file""
rm "$file".x.c
mv "$file".x "$file"
du -hs "$file"


# permissão de execução
chmod 700 "$file"

# # restaurando os symlinks
# mkdir -p /data/data/com.termux > /dev/null 2>&1
# ln -sf /storage/DevMount/AndroidDEV/termux/files /data/data/com.termux/ > /dev/null 2>&1
# ln -sf /storage/DevMount/asusbox/.install /data/asusbox/ > /dev/null 2>&1

du -hs "$file"

# cp "$file" "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.buildwip/UpdateSystem-armeabi-v7a [Official Published] SHC Version.sh"

#cp "$file" "$pathRoot/[r] (SHC)                 = $(date +"%d.%m.%Y %H.%M.%S" | sed 's;:;.;g') UpdateSystem-armeabi-v7a [Official Published].sh"







#ln -sf "$file" "$DIR/UpdateSystem-$CPU.sh"

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

echo "New SHC Boot gerado com sucesso!
Não se esqueça de testar rodando o código abaixo por segurança antes de upar"


read bah