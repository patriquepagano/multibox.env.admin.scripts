#!/system/bin/sh

# fixar o mac oficial direto no rootsudaemon > offline scripts
# mac oficial em uso
/system/bin/busybox ifconfig eth0 down
/system/bin/busybox ifconfig eth0 hw ether ec:2c:e9:c1:03:a2
/system/bin/busybox ifconfig eth0 up
ifconfig



rm -rf /sdcard/Download/macx
mkdir /sdcard/Download/macx
echo "48:EC:30:E1:04:99" > /sdcard/Download/macx/dtv.txt
echo "" >> /sdcard/Download/macx/dtv.txt

exit


/system/bin/7z a /sdcard/Download/macx.zip /sdcard/Download/macx
rm -rf /sdcard/Download/macx








# não funcionou falta testar apenas o wifi emular pelo xposed
pm clear com.brtv.playback
pm clear com.brtv.vod


settings get secure android_id
# alterando para ID 
content insert --uri content://settings/secure --bind name:s:android_id --bind value:s:d3355ea09517eeb8


/system/bin/busybox ifconfig eth0 down
/system/bin/busybox ifconfig eth0 hw ether 00:1A:8F:70:01:33
/system/bin/busybox ifconfig eth0 up
ifconfig
settings get secure android_id

exit




# EC:2C:E9:C1:01:FE

pm clear com.mm.droid.livetv.express
pm grant com.mm.droid.livetv.express android.permission.READ_EXTERNAL_STORAGE
#pm grant com.mm.droid.livetv.express android.permission.WRITE_EXTERNAL_STORAGE


# fixar o mac oficial direto no rootsudaemon > offline scripts
# mac oficial em uso no asusbox
/system/bin/busybox ifconfig eth0 down
/system/bin/busybox ifconfig eth0 hw ether ec:2c:e9:c1:03:a2
/system/bin/busybox ifconfig eth0 up
ifconfig


# rm -rf $EXTERNAL_STORAGE/.cc
# rm -rf $EXTERNAL_STORAGE/.com.taobao.dp
# rm -rf $EXTERNAL_STORAGE/.Rxst/btve
# rm -rf $EXTERNAL_STORAGE/.Rxst/btvekids
# rm -rf $EXTERNAL_STORAGE/.um
# rm -rf $EXTERNAL_STORAGE/.uxx
# rm -rf $EXTERNAL_STORAGE/Android/data/.um
# rm -rf $EXTERNAL_STORAGE/Android/obj/.um
# rm -rf $EXTERNAL_STORAGE/tve

# rm -rf /storage/emulated/0/.Rxst
# rm -rf /storage/emulated/0/.a.dat


# exit


#####################################################################################################################################################################
#####################################################################################################################################################################
# criando pastas necessárias para arquivos de licença tokens
# tokens ligados ao btv express ec:2c:e9:c1:03:a2
# arquivos de licença
list="
$EXTERNAL_STORAGE/.cc
$EXTERNAL_STORAGE/.com.taobao.dp
$EXTERNAL_STORAGE/.Rxst/btve
$EXTERNAL_STORAGE/.Rxst/btvekids
$EXTERNAL_STORAGE/.um
$EXTERNAL_STORAGE/.uxx
$EXTERNAL_STORAGE/Android/data/.um
$EXTERNAL_STORAGE/Android/obj/.um
$EXTERNAL_STORAGE/tve
"
for loop in $list; do
    if [ ! -d "$loop" ]; then
        mkdir -p $loop
    fi
done
/system/bin/busybox cat <<'EOF' >$EXTERNAL_STORAGE/.cc/.adfwe.dat
02-a64957f8a2b9e904856a947151a97c-f106
EOF




# androidID do btv express original >>> 
# settings get secure android_id
# b6e0e083344b30a8

# settings get secure android_id > /data/asusbox/



# wlan0     Link encap:Ethernet  HWaddr a4:3e:a0:d8:bd:fe
# eth0      Link encap:Ethernet  HWaddr ec:2c:e9:c1:03:a2

# novo arquivo que apareceu ???

/system/bin/busybox cat <<'EOF' >$EXTERNAL_STORAGE/.com.taobao.dp/dd7893586a493dc3
dcf175f124b2e54d6544381c04b2b01063d3c9dfa9fc44790715e8b298288b5476a729f6a781414f01132187e642cec8a40cbca07049367c138b90a3d451aa6785684718ce589c5ef9133fab610e83fbc22d89c363397b26d177fe6c7e122e7b2253a6a714afc5b3a83629fc393a5d6ff2d362a7dd730ef445e6f958a1ec244e985486c99cdce38504620ca916b8c81f1062ac7a55e221fa258d327acc81db08d5692010aa49e4bdc1f957db5649b70981cacd51d723f84aa611e4e1b60ac3157d763008f4d66c00004690b9b018f726e9ee65e6aa4650e0fa53987450c29c3be2dee0f3f73bac1daa8abe6afb75d5ed279d1efa00efb69807837829b3f17019
EOF

/system/bin/busybox cat <<'EOF' >$EXTERNAL_STORAGE/.com.taobao.dp/hid.dat
7259e2fb4ecc2376906441652c556f3e6ec31c7c6ab35382928657890fc51275b7b391770a428fcbfa216d85bda0b22f
EOF

/system/bin/busybox cat <<'EOF' >$EXTERNAL_STORAGE/.Rxst/btve/btve
HyGn669+zpUPqyM26ndMgDDzbGgspCAg4euXEDFt3oJIjQ834Z17rm1Vk8bxrdUglHHJmEmKUuy5pq9G4U6mDtqRkqQ8lYkgEAXIR0bHbgi7fNbEzSydHdOWk5WRkqQrsySf5OjdsMm4IDTr2Frvsyc53TT1NPRznyVJE8FlZiDar88meFHcl/75a37Cam9e
EOF
/system/bin/busybox cat <<'EOF' >$EXTERNAL_STORAGE/.Rxst/btvekids/btvekids
HyGn669+zpUPqyM26ndMgDDzbGgspCAg4euXEDFt3oJIjQ834Z17rm1Vk8bxrdUglHHJmEmKUuy5pq9G4U6mDtqRkqQ8lYkgEAXIR0bHbgi7fNbEzSydHdOWk5WRkqQrqUYjKmLqppukJjH/G4DvUlDDKkTruqeyX+6YTn1O5FVu8XddeTnmH+TEZUTeSif5
EOF
/system/bin/busybox cat <<'EOF' >$EXTERNAL_STORAGE/.um/.umm.dat
02-a64957f8a2b9e904856a947151a97c-f106
EOF
/system/bin/busybox cat <<'EOF' >$EXTERNAL_STORAGE/.uxx/.cca.dat
02-a64957f8a2b9e904856a947151a97c-f106
EOF
/system/bin/busybox cat <<'EOF' >$EXTERNAL_STORAGE/Android/data/.um/sysid.dat
86f99505bc321dd44786c640d3a4880c6f2b085d
EOF
/system/bin/busybox cat <<'EOF' >$EXTERNAL_STORAGE/Android/obj/.um/sysid.dat
86f99505bc321dd44786c640d3a4880c6f2b085d
EOF
/system/bin/busybox cat <<'EOF' >$EXTERNAL_STORAGE/tve/wm
a4:3e:a0:d8:bd:fe
EOF
/system/bin/busybox cat <<'EOF' >$EXTERNAL_STORAGE/.a.dat
02-a64957f8a2b9e904856a947151a97c-f106
EOF


#exit

mkdir -p /data/data/com.mm.droid.livetv.express/shared_prefs

/system/bin/busybox cat <<'EOF' > /data/data/com.mm.droid.livetv.express/shared_prefs/livetv.xml
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="device_metric_post" value="true" />
    <string name="activation_flag">iDP5qqCU56Fm1VaUqWjEow==</string>
    <string name="group">hWydtrr+R8S37+3lqkcsVA==</string>
    <string name="activation_st">a7pNosJm8K3NFuPbhl1kdBKhP5x8HeE26e8LndWY98NJl6rjgHxpr7iDN1ktcDRwvEZCqKWznkRZtOGwpF/deZPnFepvARJuVnczQ6ybtXyS7aLi1PKfmn92mHPeheLC</string>
    <string name="wifi_mac">a4:3e:a0:d8:bd:fe</string>
    <long name="all_data_checksum" value="1589568483733" />
    <string name="account_info">YXM87ZkIXzGQvJ5eLQSQeytAg22Y4mg5eptaCoAbWvh8OPR5ubrbxD7lryDy9ueMtqwdyRZjDB8zPc9ocxUTF0Hm8z7WnP5WdP54sRsBdFv2bEci8Im5Ug3or3n0vg6vrYncoK25Az69GCqpIj9qSieT+OiwtOBVyeKoGt2uLFve3MyovQ056bBdDOCYQd1UVscJkQHXgf/pQ5LmYcGbSG+a6yJpnXSW+jvl+EFdChD/0n5Dh46kdGqjF8gKAqxNoDmQi9EA27QQzV/6IGkw3FcRp+IsZPTyb0fgdAvwG+nwyKP5V1bCPoVWaiAuH2lgJlXnrMvOqwwYf557jIkLCXx2wUqn7ZjTcP9v3FsoctQ9dA9jKTzIkGQGwv5Io46QrZPY8z/0D2ALEU5gNuWeX0kycILcmLnmZv/IvNKuSVpk+1r5ILVGqL/9rl5LnwBo</string>
    <string name="special_val_file">DIFcVQSIkV0G4DYre5+yOjCsbx82dhE/+jb7xb2wmN43yAoxBfOW9+ardh5bkDfH</string>
    <long name="faq_update_time" value="1589568367423" />
    <long name="rc_update_time" value="1589568367433" />
    <string name="device_hardware_checksum">0a6ba58db4a27a9f2cb1b93b83a6984b</string>
    <string name="seed">BQrOVc2WkS0+3KKdtEAFxw==</string>
    <string name="best_server_id">0G3wJI++5Ya5ARC6SySt0nipm8NmNECGreE/7Q/iqFBwP4FdAaVBBY1SGhfTHtt3</string>
    <string name="device_build_checksum">ed670ef3cd4b2c34c0494851d1bc7cd6</string>
    <boolean name="post_device_info_complete" value="true" />
</map>

EOF

/system/bin/busybox cat <<'EOF' > /data/data/com.mm.droid.livetv.express/shared_prefs/rdns_rdm.xml
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <long name="rdm_refresh_time" value="1594476975354" />
</map>

EOF

/system/bin/busybox cat <<'EOF' > /data/data/com.mm.droid.livetv.express/shared_prefs/ns_address.xml
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name="cache_ns_info">{&quot;a&quot;:0,&quot;b&quot;:1594476974814,&quot;c&quot;:86400000,&quot;d&quot;:&quot;d41d8cd98f00b204e9800998ecf8427e&quot;,&quot;e&quot;:{}}</string>
    <string name="cache_checksum">d41d8cd98f00b204e9800998ecf8427e</string>
    <string name="cache_duration">24</string>
    <string name="last_ns_info_cache_time">1594476974814</string>
</map>

EOF


# 660 permissao

function FixPerms () {
# permissao do user da pasta
DUser=`dumpsys package $app | grep userId | cut -d "=" -f 2`
echo $DUser
chown -R $DUser:$DUser /data/data/$app
restorecon -FR /data/data/$app
}


app=com.mm.droid.livetv.express
FixPerms



exit





pm clear com.mm.droid.livetv.express
pm grant com.mm.droid.livetv.express android.permission.READ_EXTERNAL_STORAGE
pm grant com.mm.droid.livetv.express android.permission.WRITE_EXTERNAL_STORAGE

pm unhide com.mm.droid.livetv.express

###################################################################################################################
###################################################################################################################
###################################################################################################################
app=com.mm.droid.livetv.kids
if [ ! -e /data/data/com.mm.droid.livetv.kids ] ;then
echo "<h1>$(date)</h1>" >> $bootLog 2>&1
echo "<h2>ASUSbox Informa</h2>" >> $bootLog 2>&1
echo "<h3>Grande atualização, por favor aguarde.</h3>" >> $bootLog 2>&1
echo "<h3>Arquivo grande pode demorar.</h3>" >> $bootLog 2>&1
LinkUpdate="http://45.79.48.215/asusbox/com.mm.droid.livetv.kids_2.0.1.apk"
# update apk url vps anibal
echo "Iniciando download" > $bootLog 2>&1
    while [ 1 ]; do
        FechaAria
        $aria2c \
		--show-console-readout=false \
		--always-resume=true \
		--summary-interval=10 \
		--console-log-level=error \
		--file-allocation=none \
		$LinkUpdate \
		-d /data/asusbox | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
        if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
        $sleep 1;
    done;
    echo "Download concluido $apkName" > $bootLog 2>&1
    # instalando o app
	pm install -r /data/asusbox/com.mm.droid.livetv.kids_2.0.1.apk
    rm /data/asusbox/com.mm.droid.livetv.kids*.apk
	pm grant $app android.permission.READ_EXTERNAL_STORAGE
	pm grant $app android.permission.WRITE_EXTERNAL_STORAGE
fi

pm unhide com.mm.droid.livetv.kids







# não estou usando pois sempre no reboot algo altera estes arquivos
# # verificando crc em lista de arquivos para gravar apenas se alterado
# HashResult=`list="
# $EXTERNAL_STORAGE/.cc/.adfwe.dat
# $EXTERNAL_STORAGE/.Rxst/btve/btve
# $EXTERNAL_STORAGE/.Rxst/btvekids/btvekids
# $EXTERNAL_STORAGE/.um/.umm.dat
# $EXTERNAL_STORAGE/.uxx/.cca.dat
# $EXTERNAL_STORAGE/Android/data/.um/sysid.dat
# $EXTERNAL_STORAGE/Android/obj/.um/sysid.dat
# $EXTERNAL_STORAGE/tve/wm
# $EXTERNAL_STORAGE/.a.dat
# "
# for loop in $list; do
#     if [ ! -d "$loop" ] ; then
#         /system/bin/busybox md5sum "$loop" | /system/bin/busybox cut -d ' ' -f1
#     fi
# done
# `