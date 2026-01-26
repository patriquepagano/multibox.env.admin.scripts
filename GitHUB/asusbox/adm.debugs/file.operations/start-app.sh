#!/system/bin/sh

# botar isto como controle remoto
app=com.asx4k
am force-stop $app
monkey -p $app -c android.intent.category.LAUNCHER 1

