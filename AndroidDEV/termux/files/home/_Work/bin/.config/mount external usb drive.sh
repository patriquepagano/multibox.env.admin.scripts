#!/system/bin/sh
FolderPath="/storage/tmpDrive"
mkdir -p $FolderPath
/system/bin/busybox mount -t ext4 LABEL="retropie" $FolderPath






