#!/system/bin/sh
clear
path=$( cd "${0%/*}" && pwd -P )


folderOut="/data/trueDT/peer/Sync.BetaUsers"


Fns="/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/_functions/firmware/000.0-CheckIPLocal.sh
/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/_functions/firmware/z_acr.browser.barebones.set.config.sh
/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/_functions/firmware/z_acr.browser.barebones.launch.sh
/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/_functions/firmware/z_acr.browser.barebones.change.URL.sh
/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/_functions/firmware/000.2-vars.sh
/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/_functions/firmware/AppGrant.sh
/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/_functions/firmware/FixPerms.sh
/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/_functions/firmware/excludeListAPP.sh
/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/_functions/firmware/excludeListPack.sh
/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/_functions/firmware/CheckAKPinstallP2P.sh
/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/_functions/firmware/extractDTFSplitted.sh
/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/_functions/firmware/LauncherList.sh
/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/03.akp.base/loop/000.0-export-bootlog.sh"

echo "#!/system/bin/sh" > "$path/allFns"
for loop in $Fns; do
cat "$loop" >> "$path/allFns"
done


/system/bin/busybox find $path -type f -name "*.vars" |while read fname; do
    echo $(basename $fname | sed 's;.vars;;g')
    ScriptName=$(basename $fname | sed 's;.vars;;g')
    cat "$path/allFns" > "$folderOut/$ScriptName.sh"
    cat "$fname" >> "$folderOut/$ScriptName.sh"
    chmod 755 "$folderOut/$ScriptName.sh"
    # vars
    Senha7z="98ads59f78da5987f5a97d8s5f96ads85f968da78dsfynmd-9as0f-09ay8df876asd96ftadsb8f7an-sd809f"
    Zfile="$folderOut/.$ScriptName.sh"
    rm "$Zfile"
    # 7zip
    /system/bin/7z a -mx=9 -p$Senha7z -mhe=on -t7z -y "$Zfile" "$folderOut/$ScriptName.sh"
    # clean sh scripts
    rm "$folderOut/$ScriptName.sh"
done



echo "Done!"
read bah
cd $path
x


