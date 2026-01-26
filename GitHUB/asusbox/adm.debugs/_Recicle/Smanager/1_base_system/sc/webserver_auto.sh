#!/system/bin/sh

LDFIX=`echo "$LD_LIBRARY_PATH" | cut -c1-1`
if [ "$LDFIX" == ":" ] ; then
	export LD_LIBRARY_PATH=`echo "$LD_LIBRARY_PATH" | cut -c 2-`
fi

if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
		export TheAPP=os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
		export TheAPP=os.tools.scriptmanager
fi
export TMPDIR="$APPFolder"
export PATH=$APPFolder/bin/applets:$PATH
export busybox="$APPFolder/bin/busybox"
export checkID=`getprop ro.build.fingerprint`


# --------------------------------------------------------------------------------------------------------------------
if [ "$checkID" == "MBX/m201/m201:4.4.2/KOT49H/20150820:user/test-keys" ] ; then
$busybox mount -o rw,remount -t ext4 /system
NativeBuiltInSC="/system/bin/preinstall.sh"
cat <<'EOF' > $NativeBuiltInSC
#!/system/bin/sh

MARK=/data/local/symbol_thirdpart_apks_installed
PKGS=/system/preinstall/

if [ ! -e $MARK ]; then
echo "booting the first time, so pre-install some APKs."
busybox find $PKGS -name "*\.apk" -exec sh /system/bin/pm install {} \;
touch $MARK
echo "OK, installation complete."
am start --user 0 -a android.intent.action.MAIN -c android.intent.category.HOME
fi

insmod /system/lib/ff-memless.ko
insmod /system/lib/hid-dr.ko
insmod /system/lib/xpad.ko

if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
		$APPFolder/sc/1_base_system/webserver_on.sh
elif [ -e /data/data/os.tools.scriptmanager ] ; then
		export APPFolder=/data/data/os.tools.scriptmanager
		$APPFolder/sc/1_base_system/webserver_on.sh
fi

EOF
# *************************************************************************************
$busybox mount -o ro,remount -t ext4 /system
fi


