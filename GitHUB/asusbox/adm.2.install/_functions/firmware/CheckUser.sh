function CheckUser {
UserPass=`/system/bin/busybox cat /data/data/com.asusbox.asusboxiptvbox/shared_prefs/loginPrefs.xml | /system/bin/busybox grep password | /system/bin/busybox cut -d '>' -f 2 | /system/bin/busybox cut -d '<' -f 1`
}


