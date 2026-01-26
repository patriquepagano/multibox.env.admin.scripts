#!/system/bin/sh
source /data/.vars 


path="/data/UPDATE"

$find $path -name "*.akp"|while read fname; do
    echo "$fname"
    /system/bin/busybox touch -a -m -t 201512180130.09 "$fname"
done

exit

quando a data dos arquivos se altera ele vai no index e confere se esta modificação é mais atual que a global e ai aplica nas box dos outros.. 


touch -a -m -t 201512180130.09 fileName.ext
Where:

-a = accessed
-m = modified
-t = timestamp - use [[CC]YY]MMDDhhmm[.ss] time format