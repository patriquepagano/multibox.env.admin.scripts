#!/system/bin/sh

LDFIX=`echo "$LD_LIBRARY_PATH" | cut -c1-1`
if [ "$LDFIX" == ":" ] ; then
	export LD_LIBRARY_PATH=`echo "$LD_LIBRARY_PATH" | cut -c 2-`
fi

if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
fi
export TMPDIR="$APPFolder"
# path debug para colar no sshdroid
export PATH=$APPFolder/bin/applets:$APPFolder/bin:$PATH


export busybox="$APPFolder/bin/busybox"
export aria2c="$APPFolder/bin/aria2c"
export Szip="$APPFolder/bin/7z"





busybox printf "\nFree space:\n"
DATA_FREE=$(busybox df -Ph /data | busybox grep -v ^Filesystem | busybox awk '{print $4}')
busybox printf "* /data: $DATA_FREE\n"
SYSTEM_FREE=$(busybox df -Ph /system | busybox grep -v ^Filesystem | busybox awk '{print $4}')
busybox printf "* /system: $SYSTEM_FREE\n"

BB_VERSION=$(busybox | busybox head -1 | busybox awk '{print $2}')
busybox printf "* version: $BB_VERSION\n"




# listar todos os drivers possiveis

# listar o tamanho de cada um


# DATA_FREE=$(busybox df -Ph /data | busybox grep -v ^Filesystem | busybox awk '{print $4}')
# busybox printf "* /data: $DATA_FREE\n"

# SYSTEM_FREE=$(busybox df -Ph /system | busybox grep -v ^Filesystem | busybox awk '{print $4}')
# busybox printf "* /system: $SYSTEM_FREE\n"


# SYSTEM_FREE=$($busybox df -Ph /storage/emulated | $busybox grep -v ^Filesystem | $busybox awk '{print $4}')
# $busybox printf "* /sdcard: $SYSTEM_FREE\n"

