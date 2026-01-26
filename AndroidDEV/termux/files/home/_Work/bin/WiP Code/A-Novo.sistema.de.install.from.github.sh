#!/system/bin/sh


repo_url="https://api.github.com/repos/yuliskov/SmartTube/releases/latest"
latest_release=$(curl -s "$repo_url" | grep "browser_download_url" | cut -d '"' -f 4 | grep "armeabi-v7a.apk")
echo "$latest_release"

app_name=$(basename "$latest_release")
echo "$app_name"

# como baixar o arquivo com o nome base.apk
/system/bin/wget -N --no-check-certificate --timeout=1 --tries=7 -O /sdcard/base.apk "$latest_release"


