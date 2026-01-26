#!/system/bin/sh

OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1`
am force-stop $OnScreenNow

AppList=`pm list packages -3 | busybox sed -e 's/.*://' | busybox sort \
 | busybox grep -v "com.anysoftkeyboard.languagepack.brazilian" \
 | busybox grep -v "com.menny.android.anysoftkeyboard" \
 | busybox grep -v "com.mixplorer" \
 | busybox grep -v "dxidev.toptvlauncher2" \
 | busybox grep -v "jackpal.androidterm" \
 | busybox grep -v "launcher.offline" \
 | busybox grep -v "org.asbl" \
 | busybox grep -v "org.asbpc"`

echo "$AppList" | while read app; do
echo $app

done

