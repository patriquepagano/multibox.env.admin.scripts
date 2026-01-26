#!/system/bin/sh


clear

am force-stop com.eaith
am force-stop com.planet.ultra_4k
am force-stop com.android.maxvod
am force-stop asbx.box












exit

installAPK=/storage/emulated/0/Download/ru.elron.gamepadtester_19.03.13.apk
installAPK=/storage/emulated/0/Download/ru.elron.gamepadtester_18.08.15.apk

        echo "ADM DEBUG ### Atualizando $app por favor aguarde"
        pm install -r "$installAPK"
        if [ ! $? = 0 ]; then
            echo "ADM DEBUG ### Uninstall old app version"
            pm uninstall ru.elron.gamepadtester
            echo "ADM DEBUG ### instalando $app por favor aguarde"
            pm install "$installAPK"
        fi
























