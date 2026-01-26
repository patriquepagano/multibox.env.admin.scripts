#!/system/bin/sh
clear

# Marker file path
STOP="/data/local/tmp/URL"

# Infinite loop until marker exists
while :; do
    # Exit loop if marker file is found
    [ ! -f "$STOP" ] && break
    OnScreenNow=$(dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1)
    echo "$OnScreenNow"
    date
    if [ ! "$OnScreenNow" == "acr.browser.barebones" ]; then
        am force-stop acr.browser.barebones
        ACRURL="$(busybox cat /data/local/tmp/URL)"
        am start --user 0 \
            -n acr.browser.barebones/acr.browser.lightning.MainActivity \
            -a android.intent.action.VIEW -d "$ACRURL" > /dev/null 2>&1
    fi
    sleep 11
done

echo "Watchdog web allert, stopping."


if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi



