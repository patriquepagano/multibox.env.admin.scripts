#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )
package="dxidev.toptvlauncher2"
profile="launcher-03-full"

pm disable $package

ln -sf /data/data/$package/$profile.xml /data/data/$package/shared_prefs/PREFERENCE_DATA.xml


### para quem ja tiver a launcher só força o setting
pm enable $package
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
am start -a android.intent.action.MAIN -c android.intent.category.HOME

