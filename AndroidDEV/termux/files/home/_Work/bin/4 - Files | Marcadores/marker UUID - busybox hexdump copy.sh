#!/system/bin/sh
# Menu switch DNS - BusyBox / root limitado
# Compatível com Android TV boxes com BusyBox
clear
path="$( cd "${0%/*}" && pwd -P )"

UUIDPath="/data/UUID.Uniq.key.txt"
wrote_ok=0

# /system/bin/busybox mount -o remount,rw /system
# # uuid oficial da minha box ip 120 e eu mudar isto vai ferrar lá no db da unicidade
# echo "190faa3f2c62917da9f4d9964f0d26fa886e9193672d30e067115849a96be5f2" > "$UUIDPath"


# # simular que não existe o arquivo marcador
# /system/bin/busybox mount -o remount,rw /system
# rm -f "$UUIDPath"

# simular que não existe o openssl

# 1) Se o arquivo existe, tenta ler o UUID atual (sem sobrescrever).
echo "ADM DEBUG ########### Etapa 1: Verificando se o arquivo UUID existe."
if [ -f "$UUIDPath" ]; then
  UUIDBOX=`busybox cat "$UUIDPath" | busybox tr -d '\r\n'`
fi

# Verifica se o arquivo existe e se a primeira linha tem exatamente 32 caracteres.
if [ ! -f "$UUIDPath" ] || [ "$(busybox head -n 1 "$UUIDPath" | busybox tr -d '[:space:]' | busybox wc -c)" -ne 33 ]; then
  echo "ADM DEBUG ########### Conteúdo do arquivo: $(busybox head -n 1 "$UUIDPath")"
  echo "ADM DEBUG ########### The file $UUIDPath is not a valid UUID file."
  UUIDBOX=`busybox hexdump -n 33 -e '4/4 "%08X"' /dev/urandom`
  echo -n "$UUIDBOX" > "$UUIDPath" 2>/dev/null
fi



echo "
UUID: $UUIDBOX
"


if [ ! "$1" = "skip" ]; then
    echo "Press any key to exit."
    read -r bah
fi






