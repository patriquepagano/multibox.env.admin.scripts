# ------------------------------------------------------

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
  echo "$UUIDBOX" > "$UUIDPath" 2>/dev/null
  busybox sleep 1
  UUIDBOX=`busybox cat "$UUIDPath" | busybox tr -d '\r\n'`
fi





