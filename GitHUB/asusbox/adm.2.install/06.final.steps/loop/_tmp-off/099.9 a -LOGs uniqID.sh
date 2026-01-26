

/system/bin/busybox find "/data/trueDT/peer/Sync" -type f -name "UniqIDentifier.*" | sort | while read file; do
    rm "$file"
done

/system/bin/busybox find "/data/trueDT/peer/Sync" -type f -name "Firmware_Info*" | sort | while read file; do
    rm "$file"
done

echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ### Firmware Full spec"
if [ ! -f "/data/trueDT/peer/Sync/FirmwareFullSpecs.sh" ]; then
busybox cat << EOF > /data/trueDT/peer/Sync/FirmwareFullSpecs.sh
BuildBootimage="$(getprop ro.bootimage.build.date.utc)"
BuildFirmwareSystem="$(getprop ro.build.display.id)"
LibModules="$(busybox ls -1 /system/lib/modules)"
librtkbt="$(busybox ls -1 /system/lib/rtkbt)"
SystemAPP="$(busybox ls -1 /system/app)"
PriveAPP="$(busybox ls -1 /system/priv-app)"
EOF
fi

if [ ! -f "/data/trueDT/peer/Sync/FirmwareFullSpecsID" ]; then
    data=`busybox cat /data/trueDT/peer/Sync/FirmwareFullSpecs.sh`
    MD5Var=`echo -n "$data" | busybox md5sum | busybox awk '{ print $1 }'`
    echo -n "$MD5Var" > "/data/trueDT/peer/Sync/FirmwareFullSpecsID"
fi


check=`busybox blkid | busybox grep "sd"`
if [ ! "$check" == "" ]; then
	# desta maneira nunca apaga o arquivo de registro. mesmo se o drive tenha sido removido
	echo "External File detected in: $(date +"%d/%m/%Y %H:%M:%S")" > "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "---" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "block info" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$check" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "---" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "mounted" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$(busybox mount | busybox grep 'sd')" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$(busybox mount | busybox grep 'vold')" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "---" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "space" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$(busybox df -P -h | busybox grep 'vold')" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$(busybox df -P -h | busybox grep 'sd')" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
fi






