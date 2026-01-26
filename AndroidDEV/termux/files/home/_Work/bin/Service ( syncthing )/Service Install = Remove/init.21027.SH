#!/system/bin/sh

# shebang do service não funciona se botar bash. utilize o #!/system/bin/sh

export TZ=UTC−03:00
BB="/system/bin/busybox"
syncthing="/system/bin/initRc.drv.05.08.98"
PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
# conteudo gerado nos tvboxes
Log="/data/trueDT/peer/data/client/LOG/services/init.21027.LOG"
TMP_DIR="/data/trueDT/peer/TMP"

getHDateNow () {
$BB date +"%d/%m/%Y %H:%M:%S"
}

while :; do
  set -- $(</proc/uptime)
  uptime_sec=${1%%.*}
  if [ "$uptime_sec" -gt 300 ]; then
    break
  fi
  echo "ADM DEBUG @@@ $(getHDateNow) Waiting for complete boot loader: uptime ${uptime_sec}s" >> "$Log"
  $BB sleep 10
done


# # loop do bloqueio do serviço
# while [ -f /data/trueDT/peer/TMP/init.21027.DISABLED ]; do
#   if [ ! -f "$Log" ]; then
#     echo "ADM DEBUG @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" > "$Log"
#     echo "ADM DEBUG @@@ $(getHDateNow) Syncthing disabled" >> "$Log"
#   fi
# 	$BB sleep 7
# done


# limpando o log
[ "$($BB du -k "$Log" | $BB awk '{print $1}')" -gt 3024 ] && echo "ADM DEBUG @@@ Start Log Syncthing" > "$Log" || echo "ADM DEBUG @@@ Append log Syncthing" >> "$Log"
echo "ADM DEBUG @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
echo "ADM DEBUG @@@ $(getHDateNow)" >> "$Log"
echo "ADM DEBUG @@@ Starting service > init.21027" >> "$Log"

# # para debug teste limpeza
# : > "$Log"

ConfigPath="/data/trueDT/peer/config"
defaultConfig="$ConfigPath/config.xml"

if [ ! -d $ConfigPath ]; then
    mkdir -p $ConfigPath
fi


# tem que lidar com config corrompida se bugar o xml ou algo do tipo


if [ -f "/data/trueDT/peer/data/client/BKP/21027/key.pem" ]; then
  rsync -a --delete /data/trueDT/peer/data/client/BKP/21027/ "$ConfigPath/"
fi

if [ ! -f "$ConfigPath/key.pem" ]; then
    echo "ADM DEBUG @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
    echo "ADM DEBUG @@@ $(getHDateNow) First boot, creating keys.pem" >> "$Log"
    HOME="/data/trueDT/peer"
    $syncthing --no-default-folder -generate="$ConfigPath"
    until [ -f /data/trueDT/peer/config/config.xml ]; do
        echo "ADM DEBUG @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
        echo "ADM DEBUG @@@ $(getHDateNow) waiting for config.xml be write" >> "$Log"
        echo "Wait for file"
        $BB sleep 1
    done
    echo "ADM DEBUG @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
    echo "ADM DEBUG @@@ $(getHDateNow) sleep 7 seconds FN certificates" >> "$Log"
    $BB sleep 7
fi



if [ -f /system/vendor/pemCerts.7z ]; then
  $BB mount -o remount,rw /system
  $BB rm /system/vendor/pemCerts.7z
  $BB mount -o remount,ro /system
fi

if [ -d /data/trueDT/BKP ]; then
  $BB rm -rf /data/trueDT/BKP
  $BB rm -rf /data/trueDT/peer/default
fi




echo "ADM DEBUG @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
echo "ADM DEBUG @@@ $(getHDateNow) Extract syncID if required > init.21027.ID" >> "$Log"
SyncID=$($syncthing -device-id -home="$ConfigPath")
Marker="/data/trueDT/peer/TMP/init.21027.ID"
[ "$SyncID" != "$($BB cat "$Marker" 2>/dev/null)" ] && echo -n "$SyncID" > "$Marker"


echo "ADM DEBUG @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
echo "ADM DEBUG @@@ $(getHDateNow) start [syncthing] = load binary" >> "$Log"

# https://android.stackexchange.com/questions/217495/how-can-proc-sys-values-be-changed-at-boot-sysctl-conf-does-this-on-normal-lin
sysctl -w net.core.rmem_max=4500000

# # ajusta dono e permissão recursivamente
# busybox chown -R "root:root" "/data/trueDT/peer"


HOME="/data/trueDT/peer"

# if [ -f /data/trueDT/peer/data/server/global/enable.log.21027 ]; then
#   # com log e verbose imensa! o fullReport.log fica escrevendo continuo e pode atrasar o processo de sincronia
#   # se for necessario ler logs de client fazer um cp do log no inicio do fluxo do update como um arquivo novo paa pasta destino ?
#   # se jogar log na TMP vai servir para ler o log nas minhas boxes.
#   $syncthing --unpaused --no-browser --no-default-folder -home="$HOME/config" --log-max-old-files=0 --log-max-size=100000 --logfile="$TMP_DIR/init.21027.fullReport.log"
# else
#   $syncthing --unpaused --no-browser --no-default-folder -home="$HOME/config" --logfile=/dev/null --log-max-old-files=0 --log-max-size=0 </dev/null >/dev/null 2>&1
# fi

# desativar a ideia de um marcador para ativar log pois é muito necessario já no boot da box
# depois que o user atualizar tudo vai desligar mesmo entao não faz diferença
$syncthing --unpaused --no-browser --no-default-folder -home="$HOME/config" --log-max-old-files=0 --log-max-size=100000 --logfile="$TMP_DIR/init.21027.fullReport.log"




echo "ADM DEBUG @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
echo "ADM DEBUG @@@ $(getHDateNow) loop final service monitor syncthing" >> "$Log"
$BB sleep 3


