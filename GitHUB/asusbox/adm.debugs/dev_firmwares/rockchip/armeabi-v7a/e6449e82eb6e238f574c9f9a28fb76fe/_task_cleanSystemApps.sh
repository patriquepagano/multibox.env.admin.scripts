#!/system/bin/sh

source /storage/DevMount/GitHUB/asusbox/adm.debugs/dev_firmwares/_Functions/generate.sh
source /storage/DevMount/GitHUB/asusbox/adm.debugs/dev_firmwares/_Functions/allFunctions.sh

if [ ! -f "${0%/*}/RemoveList/System-apps.sh" ]; then
    mkdir -p "${0%/*}/RemoveList"
    list_System_app > "${0%/*}/RemoveList/System-apps.sh"
fi

myList=`/system/bin/busybox cat "${0%/*}/RemoveList/System-apps.sh"`
delete_System_app


