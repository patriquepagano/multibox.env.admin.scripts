function OutputLogUsb () {
    ListaUSBmounted=$(busybox mount | busybox grep public | busybox grep -v '/mnt/runtime/' | busybox awk '!seen[$1]++' | busybox awk '{print $3}')
    if [ ! "$ListaUSBmounted" == "" ]; then
        for DriverPathUSBmounted in $ListaUSBmounted; do
            if [ "$USBLOGCALLSet" == "clear" ]; then
                rm "$DriverPathUSBmounted/debug.log"
                USBLOGCALLSet=""
            fi
            if [ ! "$USBLOGCALLSet" == "remove" ]; then
                echo "$(date) Usb Log \"$USBLOGCALL\"" >> "$DriverPathUSBmounted/debug.log"
            else
                echo "$(date) Update no errors" >> "$DriverPathUSBmounted/debug.log"
            fi
        done
    fi
}





