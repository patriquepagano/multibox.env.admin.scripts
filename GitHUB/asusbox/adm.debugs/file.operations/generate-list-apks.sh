#!/system/bin/sh
clear



versionLocal="2178096789"
versionNameOnline="45"


if [ "$versionLocal" -lt "$versionNameOnline" ];then
  echo "# versionLocal é menor que da versionNameOnline
  iniciando sistema de instalação do apk";
fi


exit

-eq # equal
-ne # not equal
-lt # less than
-le # less than or equal
-gt # greater than
-ge # greater than or equal
exit


# copia apk por apk comparando se tem novos, mas não exclui os antigos
/system/bin/busybox find "/data/app/" -type f -name "base.apk" \
| while read fname; do
#echo "$fname"
app=`echo "$fname" | /system/bin/busybox cut -d "/" -f 4 | /system/bin/busybox cut -d "-" -f 1`
version=`dumpsys package $app | /system/bin/busybox grep versionName | \
/system/bin/busybox cut -d "=" -f 2 | \
/system/bin/busybox head -n 1 | \
/system/bin/busybox cut -d " " -f 1 | \
/system/bin/busybox sed -e 's/[^0-9]*//g'`
echo "$app $version"
done

