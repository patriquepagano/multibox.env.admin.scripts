#!/system/bin/sh
path=$(dirname $0)

folders="_functions
_tools
00.snib
01.sc.base
02.wpboot
03.akp.base
04.akp.oem
05.akp.clones
07.dev"

for loop in $folders; do
    if [ ! -d $path/$loop ];then
        mkdir $path/$loop
    fi
    echo "#!/system/bin/sh" > $path/$loop/code.sh
    chmod 755 $path/$loop/code.sh
done



