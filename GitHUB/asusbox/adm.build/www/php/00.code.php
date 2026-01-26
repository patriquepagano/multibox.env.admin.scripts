<?php

if (isset($_GET["oper"])) {
    $oper = $_GET["oper"];
    if ($oper == "androidhome") {
        exec("am start --user 0 -a android.intent.action.MAIN -c android.intent.category.HOME");
    }
    if ($oper == "rebootBox") {
        exec("am start -a android.intent.action.REBOOT");
    }
    if ($oper == "configWiFi") {
        exec("am start --user 0 -a com.android.settings -n com.android.settings/com.android.settings.wifi.WifiSettings");
    }
    if ($oper == "volumeMais") {
        exec("input keyevent KEYCODE_VOLUME_UP");
    }
    if ($oper == "volumeMenos") {
        exec("input keyevent KEYCODE_VOLUME_DOWN");
    }
    if ($oper == "volumeMute") {
        exec("input keyevent KEYCODE_VOLUME_MUTE");
    }
    if ($oper == "KEYCODE_POWER") {
        exec("input keyevent KEYCODE_POWER");
    }
    if ($oper == "KEYCODE_HOME") {
        exec("input keyevent KEYCODE_HOME");
    }
    if ($oper == "KEYCODE_MENU") {
        exec("input keyevent KEYCODE_MENU");
    }
    if ($oper == "KEYCODE_BACK") {
        exec("input keyevent KEYCODE_BACK");
    }  
    exit;
}

// $myfile = fopen("/data/trueDT/peer/Sync/LocationIPlocal.atual", "r") or die("Unable to open file!");
// $LocationIPlocal = fgets($myfile);
// fclose($myfile);

$LocationIPlocal = exec("/system/bin/busybox ifconfig | /system/bin/busybox grep -v 'P-t-P' | /system/bin/busybox grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | /system/bin/busybox grep -Eo '([0-9]*\.){3}[0-9]*' | /system/bin/busybox grep -v '127.0.0.1'");

?>

