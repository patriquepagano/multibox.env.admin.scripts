#!/system/bin/sh
clear
path=$( cd "${0%/*}" && pwd -P )

/system/bin/busybox mount -o remount,rw /system
# echo "limpando sistema antigo"

# file="/system/bin/rootsudaemon.sh"
# echo -n "#!/system/bin/sh
# /system/xbin/daemonsu --auto-daemon &
# " > $file

cat "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.install/.termuxOpensshGit/sshdnativo.rc" > /system/etc/init/sshdnativo.rc
chmod 0644 /system/etc/init/sshdnativo.rc
cat "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.install/.termuxOpensshGit/sshdnativo.sh" > /system/bin/sshdnativo.sh
chmod 0755 /system/bin/sshdnativo.sh


