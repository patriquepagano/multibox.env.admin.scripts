#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

SearchFolder="Client"
source "$path/21027-data-check-sync"

echo "done"
read bah