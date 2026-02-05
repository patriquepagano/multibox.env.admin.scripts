#!/system/bin/sh
# Menu switch DNS - BusyBox / root limitado
# Compatível com Android TV boxes com BusyBox
clear

path="$( cd "${0%/*}" && pwd -P )"


# UNIQ DEVICE IDENTIFICATION
Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`

BB=/system/bin/busybox



marcadorUUID () {

UUIDPath="/system/UUID.Uniq.key.txt"

# 1) Se o arquivo existe, tenta ler o UUID atual (sem sobrescrever).
echo "ADM DEBUG ########### Etapa 1: Verificando se o arquivo UUID existe."
if [ -f "$UUIDPath" ]; then
  UUIDBOX=`busybox cat "$UUIDPath" | busybox tr -d '\r\n'`
fi

# Verifica se o arquivo existe e se a primeira linha tem exatamente 64 caracteres.
if [ ! -f "$UUIDPath" ] || [ "$(busybox head -n 1 "$UUIDPath" | busybox tr -d '[:space:]' | busybox wc -c)" -ne 64 ]; then
  echo "ADM DEBUG ########### Conteúdo do arquivo: $(busybox head -n 1 "$UUIDPath")"
  echo "ADM DEBUG ########### The file $UUIDPath is not a valid UUID file."
  UUIDBOX=`/data/bin/openssl rand -hex 32`
  # apagando arquivo para forçar a recriação
  /system/bin/busybox mount -o remount,rw /system
  # 3.2) Grava o UUID gerado quando arquivo nao existe ou esta vazio.
  echo "$UUIDBOX" > "$UUIDPath"
  busybox sleep 1
  UUIDBOX=`busybox cat "$UUIDPath" | busybox tr -d '\r\n'`
fi

}


download_openssl () {
# Verifica se o binário já existe e está funcional — se sim, pula o download
skip_download=0
if [ -x /system/usr/bin/openssl ]; then
    version=$(/system/usr/bin/openssl version 2>/dev/null | cut -d " " -f 2)
    if [ -n "$version" ]; then
        echo "OpenSSL já instalado — versão $version. Pulando download."
        skip_download=1
    else
        echo "OpenSSL encontrado mas não respondeu corretamente — atualizando..."
    fi
fi

if [ "$skip_download" -eq 0 ]; then
    URL="https://painel.iaupdatecentral.com/android/armeabi-v7a/openssl"
    echo "Baixando OpenSSL com aria2c..."
    $BB mkdir -p /data/local/tmp
    aria2c --check-certificate=true --ca-certificate="/data/Curl_cacert.pem" --continue=true --max-connection-per-server=4 -x4 -s4 --dir="/data/local/tmp" -o "openssl" "$URL"
    $BB du -hs "/data/local/tmp/openssl"
    $BB chmod 755 /data/local/tmp/openssl
    $BB mount -o remount,rw /system
    $BB rm -f /system/usr/bin/openssl
    $BB cp "/data/local/tmp/openssl" /system/usr/bin/openssl
    /system/usr/bin/openssl version
fi

}


post_upload () {
PostURL="https://painel.iaupdatecentral.com/debug/index.php"

curl -sS --cacert "/data/Curl_cacert.pem" --connect-timeout 8 --max-time 25 --retry 4 --retry-delay 2 --retry-max-time 25 --retry-connrefused \
    -w "\nHTTP_STATUS=%{http_code}\n" -X POST "$PostURL" \
    -H "X-Auth-Token: mbx_9f3a7d1b2c4e6f8a0b1c3d5e7f9a1b2c3d4e6f8a" \
    -d "Placa=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" \
    -d "CpuSerial=$CpuSerial" \
    -d "MacLanReal=$MacLanReal" \
    -d "DebugCode=$DebugCode"

}




DebugCode="$(
  {
    echo "O arquivo openssl existe em $(busybox du -hs /system/usr/bin/openssl)"
    cat /system/UUID.Uniq.key.txt

    # Exemplo de “openssl bugado”
    if /system/usr/bin/openssl version >/dev/null 2>&1; then
      echo "OpenSSL ok"
    else
      echo "OpenSSL bugado — executando rotinas completas"
      OpenSSL_BUG=1
      # chame todas as funções aqui
      marcadorUUID
      download_openssl
    fi

    echo "vamos ver se funciona agora $(/system/usr/bin/openssl version)"

  } 2>&1
)"



if [ -x /system/usr/bin/openssl ]; then
  echo "OpenSSL final ok: $(/system/usr/bin/openssl version)"
else
  echo "OpenSSL final falhou."
  post_upload
fi





if [ ! "$1" = "skip" ]; then
    echo "Press any key to exit."
    read -r bah
fi






