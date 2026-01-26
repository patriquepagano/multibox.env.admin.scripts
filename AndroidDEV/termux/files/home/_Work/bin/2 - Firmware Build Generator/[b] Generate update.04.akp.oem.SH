#!/system/bin/sh
folder="/data/asusbox/.sc/boot/apps"
mkdir -p "$folder"
file="$folder/update.04.akp.oem.sh"

FileList="
/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/000.0.0-phpSignin-CheckIPLocal.sh
/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/z_acr.browser.barebones.set.config.sh
/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/z_acr.browser.barebones.launch.sh
/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/z_acr.browser.barebones.change.URL.sh
/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/000.1.6-phpSignin-VARs.sh
/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/AppGrant.sh
/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/FixPerms.sh
/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/excludeListAPP.sh
/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/excludeListPack.sh
/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/CheckAKPinstallP2P.sh
/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/extractDTFSplitted.sh
/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/LauncherList.sh
"

#/storage/DevMount/GitHUB/asusbox/adm.2.install/03.akp.base/loop/000.0-export-bootlog.sh


rm $file
for loop in $FileList; do
    echo "$loop"
    cat "$loop" >> $file
done


path="/storage/DevMount/GitHUB/asusbox/adm.2.install/04.akp.oem/loop"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "oem-ao*.sh"| sort | while read fname; do
    echo "$fname"
    cat "$fname" >> $file
done

chmod 755 $file
cp $file "/storage/DevMount/GitHUB/asusbox/adm.build/boot/apps/update.04.akp.oem.sh"
