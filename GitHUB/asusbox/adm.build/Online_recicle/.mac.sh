#!/system/bin/sh
/system/bin/busybox ifconfig eth0 down
/system/bin/busybox ifconfig eth0 hw ether ec:2c:e9:c1:03:a2
/system/bin/busybox ifconfig eth0 up
