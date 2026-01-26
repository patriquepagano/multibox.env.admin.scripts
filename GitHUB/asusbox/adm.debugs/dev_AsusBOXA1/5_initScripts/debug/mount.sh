

echo "Montar por label no android"
mkdir /storage/AsusUpdate
chmod 777 /storage/AsusUpdate
/system/bin/busybox mount -t ext4 LABEL="AAAAAAAAAAA" /storage/AsusUpdate


