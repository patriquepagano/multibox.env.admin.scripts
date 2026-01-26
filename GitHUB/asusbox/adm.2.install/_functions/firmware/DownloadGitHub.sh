GitHUBcheckVersion () {
latest_release=$(curl -s "$repo_url" | grep "browser_download_url" | cut -d '"' -f 4 | grep "armeabi-v7a.apk")
VersionOnline=$(basename "$latest_release")
# echo "$latest_release"
# echo "$VersionOnline"
}

DownloadFromGitHUB () {
if [ ! "$VersionOnline" == "$VersionLocal" ]; then
    echo "<h2>Baixando o aplicativo > $VersionOnline < Por favor aguarde.</h2>" >> "$bootLog" 2>&1
    /system/bin/wget --no-check-certificate --timeout=1 --tries=7 -O /data/local/tmp/base.apk "$latest_release" 2>&1
    echo "<h2>Instalando o aplicativo > $VersionOnline</h2>" >> $bootLog 2>&1
    echo "<h3>Por favor aguarde...</h3>" >> $bootLog 2>&1
    pm install -r /data/local/tmp/base.apk
    rm /data/local/tmp/base.apk
    echo -n "$VersionOnline" > /data/data/$realname/VersionInstall.log
else
    echo "Apk [$VersionLocal] esta atualizado" >> "$bootLog" 2>&1
fi
}


