#!/system/bin/sh

# unica maneira em uma box nexbox A905 para não dar erro de credenciais do ssh foi botando estes segundos de espera no termux ssh
# neste sshd nativo nem consegui botar login por key
sleep 60

# não carregou nenhuma destas variaveis
# SHELL=/data/data/com.termux/files/usr/bin/bash
# PWD=/storage/DevMount/AndroidDEV/termux/files/home
# EXTERNAL_STORAGE=/sdcard
# HOME=/data/data/com.termux/files/home
# ANDROID_DATA=/data
# TERM=xterm-256color
# ANDROID_ROOT=/system
# BOOTCLASSPATH=/system/framework/core-oj.jar:/system/framework/core-libart.jar:/system/framework/conscrypt.jar:/system/framework/okhttp.jar:/system/framework/core-junit.jar:/system/framework/bouncycastle.jar:/system/framework/ext.jar:/system/framework/framework.jar:/system/framework/telephony-common.jar:/system/framework/voip-common.jar:/system/framework/ims-common.jar:/system/framework/apache-xml.jar:/system/framework/org.apache.http.legacy.boot.jar:/system/framework/droidlogic.jar:/system/framework/droidlogic.frameworks.pppoe.jar
# LD_LIBRARY_PATH=/system/lib:/system/usr/lib
# PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/home/_Work/bin


#HOME=/data/ssh
# não fixou a Home de jeito nenhum! as env parecem q vão dentro do binario
"/system/bin/sshd"







