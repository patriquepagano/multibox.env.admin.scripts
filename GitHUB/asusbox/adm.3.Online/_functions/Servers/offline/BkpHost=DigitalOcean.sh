#!/system/bin/sh

source /storage/DevMount/GitHUB/asusbox/adm.debugs/dev_AsusBOXA1/0_vps-scripts/upload_function.sh

auth=key

user="root"
vpsIP="45.79.133.216"
key="/storage/DevMount/GitHUB/asusbox/adm.debugs/_keys/digitalOcean/id_rsa"
chmod 400 $key

UploadVPS


