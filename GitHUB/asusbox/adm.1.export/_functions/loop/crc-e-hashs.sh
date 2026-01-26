

function HashFolderSC () {
$rm /data/tmp.hash > /dev/null 2>&1
$find $1 -type f \( -iname \*.sh -o -iname \*.ini -o -iname \.vars -o -iname \*.conf -o -iname fcgiserver \) | $sort | while read fname; do
    #echo "$fname"
    $md5sum "$fname" | $cut -d ' ' -f1 >> /data/tmp.hash 2>&1
done
export HashResult=`$cat /data/tmp.hash`
$rm /data/tmp.hash > /dev/null 2>&1
}


