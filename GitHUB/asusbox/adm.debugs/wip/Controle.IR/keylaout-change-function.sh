#!/system/bin/sh
clear


# # https://forum.xda-developers.com/t/guide-how-to-remap-hardkey-actions-custom-app-launching.695936/
# # Não desligar a box
# #service <activity> /data/asusbox/.sc/boot/NeverStandby.sh
# service <activity> /storage/DevMount/GitHUB/asusbox/adm.debugs/file.operations/keylaout-change-function.sh
# oneshot
# disabled
# keycodes 116 152 60

# não funcionou
# service NeverStandby /data/NeverStandby.sh
# keycodes 116 152 60


# keycodes <keycode> [ <keycode>\* ]

/system/bin/busybox mount -o remount,rw /system
cat << EOF > /system/etc/init/NeverStandby.rc
service NeverStandby /data/NeverStandby.sh
disabled
keycodes 116
EOF
chmod 0644 /system/etc/init/NeverStandby.rc
cat /system/etc/init/NeverStandby.rc

cat << EOF > /data/NeverStandby.sh
#!/system/bin/sh
mkdir -p /sdcard/aaaaaaaaaaaaaaaaaaaaaaFuncionaaaaaaa
EOF
chmod 755 /data/NeverStandby.sh

exit

service poweroff /system/bin/shutdown
disabled
keycodes 107 211

service reboot /system/bin/shutdown -r
disabled
keycodes 107 114

service recovery /system/bin/shutdown -rr
disabled
keycodes 107 115



# official funcionando
on boot
start initdDriverCore
service initdDriverCore /system/bin/initRc.drv.01.01.97
disabled
oneshot
user root
group root
seclabel u:r:su:s0




# altera apenas se necessário
file="/system/usr/keylayout/110b0030_pwm.kl"
check=`busybox cat "$file" | busybox grep "POWER"`
if [ ! "$check" == "" ]; then
	echo "ADM DEBUG ### need change key > $check"
    /system/bin/busybox mount -o remount,rw /system
    busybox sed -i -e 's/key 116.*/key 116   HOME/g' $"$file"
fi

exit


# volta ao estado padrão
/system/bin/busybox mount -o remount,rw /system
file="/system/usr/keylayout/110b0030_pwm.kl"
busybox sed -i -e 's/key 116.*/key 116   POWER/g' $"$file"
busybox cat "$file" | busybox grep "POWER"

# fechar todos os apps
AppList=`pm list packages -3 | sed -e 's/.*://' | sort`
echo "$AppList" | while IFS= read -r app ; do
echo $app
am force-stop $app
done

exit




/system/bin/busybox mount -o remount,rw /system
file="/system/usr/keylayout/110b0030_pwm.kl"
busybox cat "$file" | busybox grep "POWER"
busybox sed -i -e 's/POWER/HOME/g' $"$file"
busybox cat "$file" | busybox grep "HOME"



exit
/system/bin/busybox find "/system/usr/keylayout" \
| -type f -name "*.kl" \
| while read fname; do
    echo "$fname"
    busybox cat "$fname" | busybox grep "NeverStandby"
    busybox sed -i -e 's/NeverStandby/POWER/g' $"$fname"
    busybox cat "$fname" | busybox grep "POWER"
done


# mostra todas as infos
getevent -tdi


######################################################
box 5.8ghz
getevent
add device 1: /dev/input/event0
  name:     "110b0030.pwm"

/system/usr/keylayout/110b0030_pwm.kl
key 116   POWER

######################################################
box 2.4ghz
getevent
add device 1: /dev/input/event2
  name:     "110b0030.pwm"
add device 2: /dev/input/event0
  name:     "hdmi_cec_key"
add device 3: /dev/input/event1
  name:     "rk29-keypad"

/system/usr/keylayout/110b0030_pwm.kl
key 116   POWER





