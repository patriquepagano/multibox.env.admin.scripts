#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

mount | grep 'vold' | grep '/mnt/media_rw' | cut -d " " -f 3 | while read -r device; do
    echo "##################################################################"
	echo "path detectado > $device"
    echo "copiando token"

find "$path" -maxdepth 2 -type f -name "*.key" | while read fname; do
	basename "$fname"
	hash=$(sha256sum "$fname" | busybox awk '{print $1}')
	echo "resultado do hash sha256sum = $hash"
	echo -n "$hash" > "$(dirname "$fname")/hash.txt"
	cp "$fname" "$device/"
done

	
	#sha256sum "$device/${group_name}.key" | busybox awk '{print $1}'
	echo "# ----------------------------------------------------------------"
done



if [ ! "$1" == "skip" ]; then
	echo "Press enter to continue."
	read bah
fi

