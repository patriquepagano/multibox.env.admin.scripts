####################### boot img > 001.0 Results >>> Fri Dec 18 17:11:20 BRST 2020
Senha7z="jJocyF4Ydw2wxdQB84u2Kou0i4DfJ6kSzBGQo98WsZ6xJ4ce9AgX388JRQpDnCpgb6szWw"
app="boot img"
FileName="001.0"
FileExtension="WebPack"
cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/boot-files/version`'
versionBinOnline="Fri Dec 18 17:11:12 BRST 2020"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www/boot-files"
SourcePack="/data/asusbox/.install/02.files/001.0/001.0"
ExcludeItens='LICENSE.txt'
excludeListPack "/data/asusbox/.install/02.files/001.0"
# verifica e instala 
7ZextractDir
# rsync folder
RsyncUpdateWWW

