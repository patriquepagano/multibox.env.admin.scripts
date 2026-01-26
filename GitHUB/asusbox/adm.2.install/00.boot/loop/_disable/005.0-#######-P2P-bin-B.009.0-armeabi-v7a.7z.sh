####################### transmission > B.009.0-armeabi-v7a Results >>> Sun Jan 17 21:26:36 BRT 2021
app="transmission"
FileName="B.009.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/transmission-remote -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="transmission-remote 3.00 (bb6b5a062e)"
Senha7z="S1IiSP6YHAcIYPgXz8urgne2xvKpcGFkVqYQdw3RO6nWa0JKMxTBAm158h2lxv2RXcO9cb"
DataBankTMP="
/data/local/tmp/B.009.0-armeabi-v7a/;B.009.0-armeabi-v7a.001;e59ffcf3ef14e6a2a336f77c77daa4bd;1-AosXb01iqdhBXbFIh2HIwRvPKlqamKS;1X8DcVMoJHEb1SFTqUXOVCWCoUgBZJkL-;1WJG63LO7R-7TrWWSfqN1n1ywaDbr9gt0;1pM5QUo7rvGijhCMxW6zViuG95KjOtpdT;1r39rJDIOnbe5TDp8Psn5rx_on3GYn_hC;1q2Px1tzQq0AEJk3jAbmWMxiNfUUrbUMh;1fjvlE4F2-xAK2DObU2RznO0CxvYV1zKp
"
### Imagem alerta comunicação


### Script install one time Only
scriptOneTimeOnly="
# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/transmission-create /system/bin/
ln -sf /system/usr/bin/transmission-remote /system/bin/
ln -sf /system/usr/bin/transmission-edit /system/bin/
ln -sf /system/usr/bin/transmission-show /system/bin/
ln -sf /system/usr/bin/transmission-daemon /system/bin/
"

# verifica e instala o binário ou lista de arquivos
CheckFileListInstall

### Script start all on boot
scriptAtBoot=""
scriptAtBootFN
