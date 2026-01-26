####################### input serial > 002.0 Results >>> Wed Dec 16 18:14:27 BRST 2020
Senha7z="YdIoUZQoTM0JHUd2nqc6Z0P0MbeHuSDXY9IdWAGthhzu6CAzbgebUTR8rojJ9CJ8QcZvLT"
app="input serial"
FileName="002.0"
FileExtension="WebPack"
cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /data/asusbox/.sc/www/version`'
versionBinOnline="Wed Dec 16 18:14:15 BRST 2020"
pathToInstall="/data/asusbox/.sc/www"
SourcePack="/data/asusbox/.install/01.sc.base/002.0/002.0"
ExcludeItens='nada'
excludeListPack "/data/asusbox/.install/01.sc.base/002.0"
# verifica e instala 
7ZextractDir
# rsync folder
RsyncUpdateWWW

