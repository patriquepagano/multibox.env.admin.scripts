#!/system/bin/sh


# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
API="30610-11492-1385-4082"

# 4Android
folderID="5hctg-zr6yw"


curl -X POST -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/db/scan?folder=$folderID"

echo "start scanning folder $folderID
press any button to continue"

read bah
cd "$path"
x
exit

curl -X POST http://127.0.0.1:8384/rest/db/scan?folder=default&sub=foo/bar