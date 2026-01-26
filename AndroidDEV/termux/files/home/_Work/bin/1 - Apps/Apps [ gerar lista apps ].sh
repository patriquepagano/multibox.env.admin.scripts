#!/system/bin/sh
clear
path=$( cd "${0%/*}" && pwd -P )

# https://github.com/JonForShort/android-tools/tree/master/build/android-9.0.0_r33/aapt/armeabi-v7a

aapt="/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.bin's/aapt"

# {Dolphin Emulator} [org.dolphinemu.dolphinemu] (5.010945).apk

rm "$path/aapt apps lists.txt"

# copia apk por apk comparando se tem novos, mas não exclui os antigos
/system/bin/busybox find "/data/app/" -type f -name "base.apk" \
| while read fname; do
    echo "ADM DEBUG ########################################################"    
    requestData=`$aapt dump badging "$fname"`
    FakeName=`echo "$requestData" | grep "application-label:" | cut -d "'" -f 2 | cut -d "'" -f 1`
    PackageName=`echo "$requestData" | grep 'package: name=' | cut -d "'" -f 2 | cut -d "'" -f 1`
    PackageVersion=`echo "$requestData" | grep 'versionName=' | cut -d "'" -f 6 | cut -d "'" -f 1`
    echo "{$FakeName} [$PackageName] ($PackageVersion)" >> "$path/aapt apps lists.txt"
    echo "gerando ficha tecnica para > $FakeName"
done




exit

ADM DEBUG ########################################################
/data/app/com.newtourosat.app-1/base.apk
Touro box2
package: name='com.newtourosat.app' versionCode='15' versionName='1.1.0' compileSdkVersion='30' compileSdkVersionCodename='11'

APPList=`pm list packages -3 | sed -e 's/.*://' | sort`
echo "$APPList"




application-label:'Prime Video'





# Remove whitespace
function remWS {
    if [ -z "${1}" ]; then
        cat | tr -d '[:space:]'
    else
        echo "${1}" | tr -d '[:space:]'
    fi
}

for pkg in $( pm list packages -3 | cut -d':' -f2); do
    apk_loc="$( pm path $(remWS $pkg) | cut -d':' -f2 | remWS)"
    apk_name="$( aapt dump badging $apk_loc | pcregrep -o1 $'application-label:\'(.+)\'' | remWS)"
    apk_info="$( aapt dump badging $apk_loc | pcregrep -o1 '\b(package: .+)')"

    echo "$apk_name v$(echo $apk_info | pcregrep -io1 -e $'\\bversionName=\'(.+?)\'')"
done

