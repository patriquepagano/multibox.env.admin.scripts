#!/system/bin/sh


/system/bin/busybox mount -o remount,rw /system

rm /system/bin/initRc.drv.05.08.98
cp "/storage/DevMount/4Android/File_Manager/syncthing/{SyncthingFork} [com.github.catfriend1.syncthingandroid] (1.20.3.1)/lib/armeabi/libsyncthingnative.so" \
/system/bin/initRc.drv.05.08.98

chmod 755 /system/bin/initRc.drv.05.08.98

/system/bin/initRc.drv.05.08.98 -version | cut -d " " -f 2


