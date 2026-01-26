echo "Removendo aplicativos desatualizados" > $bootLog 2>&1

# | /system/bin/busybox grep -v "org.cosinus.launchertv" \


# permitir apps globais temporariamente
echo "jackpal.androidterm" >> /data/local/tmp/APPList
echo "com.retroarch" >> /data/local/tmp/APPList
echo "org.xbmc.kodi" >> /data/local/tmp/APPList
echo "com.stremio.one" >> /data/local/tmp/APPList


# remove aplicativos instalados pelos usuarios
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial"`
if [ "$checkUserAcess" == "" ]; then
remove=`pm list packages -3 \
  | /system/bin/busybox sed -e 's/^package://' \
  | /system/bin/busybox sort -u \
  | /system/bin/busybox grep -xv -f /data/local/tmp/APPList`
# echo "$remove"
for loop in $remove; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Desistalando app > $loop"
    pm uninstall $loop
done
fi




# remove arquivos orfãos de apps antigos ou instalados pelo usuario
# ficar atento sempre a aps como btv etc. que instalam pastas residuais diferentes do nome

# /system/bin/busybox find "/storage/emulated/0/Android/data/" -maxdepth 1 -type d -name "*" \
# | /system/bin/busybox sort \
# | /system/bin/busybox grep -v -f /data/local/tmp/APPList \
# | /system/bin/busybox grep -v ".um" \
# | /system/bin/busybox grep -v "asusbox" \
# | while read fname; do
#     if [ ! "$fname" == "/storage/emulated/0/Android/data/" ]; then
#         echo "ADM DEBUG ########################################################"
#         echo "ADM DEBUG ### Limpando a pasta .install"
#         #Fileloop=`basename $fname`
#         echo "eu vou apagar este arquivo > $fname"
#         #rm -rf "$fname"
#     fi
# done

USBLOGCALL="remove old apps"
OutputLogUsb


