#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )

sync

package="dxidev.toptvlauncher2"
pm disable $package
file=/data/data/$package/shared_prefs/PREFERENCE_DATA.xml

cp $file $path/wip.config.xml

### para quem ja tiver a launcher só força o setting
pm enable $package
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
am start -a android.intent.action.MAIN -c android.intent.category.HOME

