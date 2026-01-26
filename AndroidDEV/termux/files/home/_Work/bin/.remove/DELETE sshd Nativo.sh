#!/system/bin/sh
clear

/system/bin/busybox mount -o remount,rw /system

Files="/system/bin/scp
/system/bin/sftp
/system/bin/sftp-server
/system/bin/ssh
/system/bin/ssh-add
/system/bin/ssh-agent
/system/bin/sshd
/system/bin/ssh-keygen
/system/bin/ssh-keyscan
/system/bin/ssh-keysign
/system/bin/ssh-pkcs11-helper
/system/bin/bash
/system/bin/passwd
/system/etc/passwd
/data/ssh
/system/etc/init/sshdnativo.rc
/system/bin/sshdnativo.sh"

for loop in $Files; do
	echo $loop
	rm -rf $loop
done




