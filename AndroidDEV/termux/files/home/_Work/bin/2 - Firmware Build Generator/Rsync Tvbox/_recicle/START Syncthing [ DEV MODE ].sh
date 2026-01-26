#!/system/bin/sh
clear
export syncthing="/system/bin/initRc.drv.05.08.98"
# fechar o syncthing atual ( customers )
# /data/asusbox/.sc/boot/initRc.drv.05.08.98[STOP].sh


# "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.stop/2 Stop transmission-daemon.sh"
# "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.stop/3 Kill VIRUS STORM.sh"
# "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.stop/4 Stop cron services.sh"
# "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.stop/5 Stop (UpdateSystem.sh).sh"
# #"/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.stop/6 Stop webserver.sh"
# "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.stop/7 Stop cron [ update+check ].sh"




# abre o syncthing dev
Dir=$(dirname $0)
export ConfigPath="$Dir/config"
defaultConfig="$ConfigPath/config.xml"

if [ ! -d $ConfigPath ]; then
    mkdir -p $ConfigPath
fi

# preciso disto para no primeiro boot gerar a config e alterar o nome do localhost para o androidID
if [ ! -e "$ConfigPath/key.pem" ] ; then
    $syncthing  -generate="$ConfigPath"   
fi

SyncID=`$syncthing -device-id -home=$ConfigPath`
echo $SyncID
# permite acessar brownser APENAS EM LOOPBACK
/system/bin/busybox sed -i -e "s;<address>.*:8384</address>;<address>127.0.0.1:8384</address>;g" $defaultConfig

# # aplica o android ID para localizar o cliente caso ele modifique arquivos
#/system/bin/busybox sed -i -e "s/localhost/TVboxDEV/g" $defaultConfig


# fix nos diretorios de share
mkdir -p /storage/DevMount/4Android/.stfolder
mkdir -p /storage/DevMount/AndroidDEV/.stfolder
mkdir -p /storage/DevMount/asusbox/.stfolder
mkdir -p /storage/DevMount/GitHUB/.stfolder


HOME="$Dir"
$syncthing --unpaused -no-browser -no-restart -home=$ConfigPath &


# HOME="/data/trueDT/peer"
# # necessário criar a pasta para o screen funcionar
# mkdir -p $HOME
# screen -dmS Syncthing "/data/asusbox/.sc/boot/initRc.drv.05.08.98{START}.sh"
# screen -wipe





# exit

# #  Versão	v1.11.1, android (ARM)
# file="/storage/DevMount/4Android/File_Manager/syncthing/com.github.catfriend1.syncthingandroid_1.11.1.0/lib/armeabi/libsyncthingnative.so"
# du -hs $file

# # syncthing padrao >  pasta install 700 pastas 600 para arquivos
# # quando os arquivos são mudados as permissões a data interna do arquivo muda!
# # se apagar a pasta index o syncthing vai querer baixar tudo de novooooo
# # muda a data precisa upar ou baixar tudo de novo!
# # não serve para updates entre as box servidoras prioritarias

# Dir=$(dirname $0)
# syncthing="$Dir/libsyncthing.so"


# if [ ! -e "$syncthing" ] ; then
#     echo 'instalando binario'
#     cp $file $syncthing
#     chmod 755 $syncthing
# fi

# ConfigPath="$Dir/config"
# mkdir -p $ConfigPath
# defaultConfig="$ConfigPath/config.xml"

# # preciso disto para no primeiro boot gerar a config e alterar o nome do localhost para o androidID
# if [ ! -e "$ConfigPath/key.pem" ] ; then
#     $syncthing  -generate="$ConfigPath"   
# fi

# SyncID=`$syncthing -device-id -home=$ConfigPath`
# echo $SyncID
# # permite acessar brownser APENAS EM LOOPBACK
# /system/bin/busybox sed -i -e "s;<address>.*:8384</address>;<address>127.0.0.1:8384</address>;g" $defaultConfig



# # # aplica o android ID para localizar o cliente caso ele modifique arquivos
# /system/bin/busybox sed -i -e "s/localhost/TVboxDEV/g" $defaultConfig


# $syncthing -no-browser -no-restart -home=$ConfigPath &
