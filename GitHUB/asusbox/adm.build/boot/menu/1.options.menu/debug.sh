#!/system/bin/sh

# nager: START u0 {act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10000000 pkg=jackpal.androidterm cmp=jackpal.androidterm/.Term} from uid 10037 on display 0

echo "5as8765df876as5df876a5sd87fasdf" > /system/.pin

am force-stop jackpal.androidterm


am start --user 0 \
-n jackpal.androidterm/.Term \
-a android.intent.action.VIEW 


exit

#solução amadora e lenta
input text "1"
input keyevent KEYCODE_ENTER




input text "/data/data/jackpal.androidterm/app_HOME/menu.sh"


-d "/data/data/jackpal.androidterm/app_HOME/menu.sh"

-d "$ACRURL" > /dev/null 2>&1

