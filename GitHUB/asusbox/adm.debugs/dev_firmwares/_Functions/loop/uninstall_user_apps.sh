function uninstall_user_apps () {
    
remove=`pm list packages -3 | sed -e 's/.*://' | sort \
| grep -v "com.termux" \
| grep -v "org.cosinus.launchertv" \
| grep -v "berserker.android.apps.sshdroid"`
for loop in $remove; do
echo $loop
pm uninstall $loop
done

}


