#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )
package="dxidev.toptvlauncher2"
profile="launcher-03-full"

sync

cp /data/data/$package/shared_prefs/PREFERENCE_DATA.xml \
$path/$profile.xml

echo "bkp feito!
precisa rodar o:

launcher-03-full [B] WIP export + restore

"


# exit

# 1 - add os arquivos icones para o sdcard
# 2 - customize a launcher apontando as imagems para o sdcard mesmo

