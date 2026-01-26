#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

sm unmount public:8,1
sm unmount emulated:8,3

publicM="8,0"
#sm unmount public:$publicM
sm partition disk:$publicM mixed 90
#sm partition disk:$publicM mixed 60

sm format emulated:8,3
sm mount emulated:8,3



echo "---"
echo "block info"
echo "$(busybox blkid | busybox grep "sd")"
echo "---"
echo "mounted"
echo "$(busybox mount | busybox grep 'sd')"
echo "$(busybox mount | busybox grep 'vold')"
echo "---"
echo "space"
echo "$(busybox df -P -h | busybox grep 'vold')"
echo "$(busybox df -P -h | busybox grep 'sd')"


echo "---
sm list-disks
"
sm list-disks

echo "---
sm list-volumes all
"
sm list-volumes all




exit



publicM="8,0"
#sm unmount public:$publicM
sm partition disk:$publicM mixed 90
#sm partition disk:$publicM mixed 60



> adb shell sm format private:179,3
$> adb shell sm mount private:179,3






##################################################################################################
# memoria adotada não funcionou direito e deixa a box refem do pendrive
sm list-disks
sm list-volumes all #(we will see disk-ID which will use at no.6 steps – eg: 179,64)
sm set-force-adoptable true
# demoraaaa da um erro Error: 
# java.lang.IllegalStateException: java.util.concurrent.TimeoutException: 
# Thread Binder:519_A gave up waiting for partitionPrivate after 180000ms
#(wait several minutes depend on smartphone and sd card)
sm partition disk:8,0 private
sm set-force-adoptable false
sm list-volumes all
##################################################################################################














# usage: sm list-disks [adoptable]
#        sm list-volumes [public|private|emulated|all]
#        sm has-adoptable
#        sm get-primary-storage-uuid
#        sm set-force-adoptable [true|false]

#        sm partition DISK [public|private|mixed] [ratio]
#        sm mount VOLUME
#        sm unmount VOLUME
#        sm format VOLUME
#        sm benchmark VOLUME

#        sm forget [UUID|all]

#        sm set-emulate-fbe [true|false]



# Continue type : adb shell sm list-disks
# Continue type : adb shell sm list-volumes all (we will see disk-ID which will use at no.6 steps – eg: 179,64)
# Continue type : adb shell sm set-force-adoptable true
# Continue type : adb shell sm partition disk:179,64 private (wait several minutes depend on smartphone and sd card)
# Continue type : adb shell sm set-force-adoptable false
# Continue type : adb shell sm list-volumes all
# After no.8 finish, then Reboot / Restart our Android phone
# After finish reboot, then continue choose Setting > Storage > sd card > (find menu) Migrate data



