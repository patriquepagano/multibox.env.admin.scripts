#!/system/bin/sh

echo "não esta funcionando alterar os segundos, se tirar [:12] ele altera ok"

# busybox date -r $bootFile +%s
busybox touch -c -t '1977-05-10 03:23[:12]' $bootFile
exit


My busybox touch accepts dates in ISO format:
/ # touch -d '2011-1-1 23:1' x

Recognized TIME formats:
        @seconds_since_1970
        hh:mm[:ss]
        [YYYY.]MM.DD-hh:mm[:ss]
        YYYY-MM-DD hh:mm[:ss]
        [[[[[YY]YY]MM]DD]hh]mm[.ss]
        'date TIME' form accepts MMDDhhmm[[YY]YY][.ss] instead



CURRENT=$(date -r $bootFile +%Y%m%d%H%M%S)
CURRENT=$(date -r $bootFile +%s)
echo $CURRENT
# run your command here
echo "bah" > $bootFile
# Usage: touch [-c] [-d DATE] [-t DATE] [-r FILE] FILE..
busybox touch -c -d $CURRENT $bootFile

exit

busybox touch -c -t YYYYMMDDHHMM[.ss] yourfile
