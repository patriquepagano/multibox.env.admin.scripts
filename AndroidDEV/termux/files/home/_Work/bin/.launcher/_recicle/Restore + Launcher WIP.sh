#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )

package="dxidev.toptvlauncher2"
file=/data/data/$package/shared_prefs/PREFERENCE_DATA.xml

pm disable $package

#pm disable dxidev.toptvlauncher2
#cp $path/wip.config.xml $file 
wrFile=`cat $path/wip.config.xml`

cat <<EOF > $file
$wrFile
EOF

### para quem ja tiver a launcher só força o setting
pm enable $package
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
am start -a android.intent.action.MAIN -c android.intent.category.HOME
