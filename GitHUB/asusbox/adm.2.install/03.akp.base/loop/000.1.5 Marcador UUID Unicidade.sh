# ------------------------------------------------------
# desativado isto não vale a pena remover em breve

# UUIDPath="/system/UUID.Uniq.key.txt"


# # 1) Se o arquivo existe, tenta ler o UUID atual (sem sobrescrever).
# echo "ADM DEBUG ########### Etapa 1: Verificando se o arquivo UUID existe."
# if [ -f "$UUIDPath" ]; then
#   UUIDBOX=`busybox cat "$UUIDPath" | busybox tr -d '\r\n'`
# fi

# # Verifica se o arquivo existe e se a primeira linha tem exatamente 64 caracteres.
# if [ ! -f "$UUIDPath" ] || [ "$(busybox head -n 1 "$UUIDPath" | busybox tr -d '[:space:]' | busybox wc -c)" -ne 64 ]; then
#   echo "ADM DEBUG ########### Conteúdo do arquivo: $(busybox head -n 1 "$UUIDPath")"
#   echo "ADM DEBUG ########### The file $UUIDPath is not a valid UUID file."
#   UUIDBOX=`/data/bin/openssl rand -hex 32`
#   # apagando arquivo para forçar a recriação
#   /system/bin/busybox mount -o remount,rw /system
#   # 3.2) Grava o UUID gerado quando arquivo nao existe ou esta vazio.
#   echo "$UUIDBOX" > "$UUIDPath" 2>/dev/null
#   busybox sleep 1
#   UUIDBOX=`busybox cat "$UUIDPath" | busybox tr -d '\r\n'`
# fi


URL="https://painel.iaupdatecentral.com/getuuid.php"
UUID_RAW="$(curl -sS --cacert "/data/Curl_cacert.pem" --connect-timeout 8 --max-time 25 --retry 4 --retry-delay 2 --retry-connrefused "$URL")"

UUIDPath="/system/UUID.Signin.key"
wrote_ok=0

# 1) Se o retorno estiver vazio, aborta.
if [ -z "$UUID_RAW" ]; then
  echo "UUID vazio."
else
  # 2) Grava somente se o arquivo nao existir.
  if [ ! -f "$UUIDPath" ]; then
    echo "$UUID_RAW"
    /system/bin/busybox mount -o remount,rw /system
    echo -n "$UUID_RAW" > "$UUIDPath" 2>/dev/null
    busybox sync
    check_value="$(busybox cat "$UUIDPath" 2>/dev/null | busybox tr -d '\r\n')"
    if [ "$check_value" = "$UUID_RAW" ]; then
      wrote_ok=1
    else
      wrote_ok=0
    fi
  fi
fi





