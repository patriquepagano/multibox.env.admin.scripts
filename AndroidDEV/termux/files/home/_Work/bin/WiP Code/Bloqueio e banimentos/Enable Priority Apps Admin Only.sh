#!/system/bin/sh
path="$( cd "${0%/*}" && pwd -P )"
clear

source "$path/.functions.sh"


EnablePriorityAppsAdminOnly

am start -a android.intent.action.MAIN -c android.intent.category.HOME




if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi

