#!/system/bin/sh

# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
API="zPcijoDqqWcHZhwK3qzWHVUphs9QrDDt"
folderID="5hctg-zr6yw"



curl -X GET -H "X-API-Key: $API" http://127.0.0.1:4442/rest/config/folders/$folderID > \
"$path/AAA temporary data.json"

cat "$path/AAA temporary data.json"

read bah
cd "$path"
x
exit
