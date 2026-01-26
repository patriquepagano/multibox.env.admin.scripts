#!/system/bin/sh
clear
path=$( cd "${0%/*}" && pwd -P )

# https://github.com/JonForShort/android-tools/tree/master/build/android-9.0.0_r33/aapt/armeabi-v7a

aapt="/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.bin's/aapt"

# {Dolphin Emulator} [org.dolphinemu.dolphinemu] (5.010945).apk

# {UniTV} [com.integration.unitviptv] (4.3.2)

app="com.integration.unitviptv"



# copia apk por apk comparando se tem novos, mas não exclui os antigos
/system/bin/busybox find "/data/app/" -type d -name "$app*" \
| while read fname; do
    echo $fname
    echo "ADM DEBUG ########################################################"    
    requestData=`$aapt dump badging "$fname/base.apk"`
    FakeName=`echo "$requestData" | grep "application-label:" | cut -d "'" -f 2 | cut -d "'" -f 1`
    PackageVersion=`echo "$requestData" | grep 'versionName=' | cut -d "'" -f 6 | cut -d "'" -f 1`
    echo "$FakeName ($PackageVersion)"
done


