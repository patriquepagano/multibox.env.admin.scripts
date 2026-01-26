#!/system/bin/sh

LDFIX=`echo "$LD_LIBRARY_PATH" | cut -c1-1`
if [ "$LDFIX" == ":" ] ; then
	export LD_LIBRARY_PATH=`echo "$LD_LIBRARY_PATH" | cut -c 2-`
fi
export TMPDIR=/data/data/os.tools.scriptmanager
export APPFolder=/data/data/os.tools.scriptmanager

echo "Em construção"
