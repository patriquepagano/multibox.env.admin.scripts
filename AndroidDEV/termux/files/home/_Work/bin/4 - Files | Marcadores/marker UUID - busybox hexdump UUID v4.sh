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


geradorUUUID () {
  # Gera 16 bytes randômicos, ajusta bits de versão (0100) e variant (10)
  raw=$(busybox dd if=/dev/urandom bs=16 count=1 2>/dev/null | busybox od -An -t u1)
  set -- $raw
  # b6 (posição 7) -> versão (4): top 4 bits = 0100
  b7=$(( (${7} & 0x0F) | 0x40 ))
  # b8 (posição 9) -> variant: top two bits = 10
  b9=$(( (${9} & 0x3F) | 0x80 ))
  UUIDBOX=$(busybox printf '%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x' \
    "$1" "$2" "$3" "$4" "$5" "$6" "$b7" "$8" "$b9" "${10}" "${11}" "${12}" "${13}" "${14}" "${15}" "${16}")
}

# Escreve UUID de forma simples e direta:
# - grava diretamente em $UUIDPath
# - chama sync e verifica leitura de volta
WriteUUID() {
  uuid="$1"
  dir=$(busybox dirname "$UUIDPath")
  busybox mkdir -p "$dir" 2>/dev/null || true
  if ! busybox printf '%s' "$uuid" > "$UUIDPath"; then
    return 1
  fi
  busybox sync
  readback=$(busybox head -n 1 "$UUIDPath" 2>/dev/null | busybox tr -d '\r\n')
  if [ "$readback" = "$uuid" ]; then
    return 0
  fi
  return 1
}






# 1) Se o arquivo existe, tenta ler o UUID atual (sem sobrescrever).
echo "ADM DEBUG ########### Etapa 1: Verificando se o arquivo UUID existe."
if [ -f "$UUIDPath" ]; then
  UUIDBOX=`busybox cat "$UUIDPath" | busybox tr -d '\r\n'`
fi


verificaUUID () {
# Verifica se o arquivo existe e se a primeira linha tem o formato UUID esperado (36 chars)
if [ ! -f "$UUIDPath" ] || [ "$(busybox head -n 1 "$UUIDPath" | busybox tr -d '[:space:]' | busybox wc -c)" -ne 36 ]; then
  echo "ADM DEBUG ########### Conteúdo do arquivo: $(busybox head -n 1 "$UUIDPath" 2>/dev/null)"
  echo "ADM DEBUG ########### The file $UUIDPath is not a valid UUID file. Gerando UUIDv4 RFC4122."
  geradorUUUID
  if WriteUUID "$UUIDBOX"; then
    echo "ADM DEBUG ########### UUID gravado com sucesso em $UUIDPath"
  else
    echo "ADM DEBUG ########### ERRO: falha ao gravar UUID em $UUIDPath"
  fi
fi

}



verificaUUID






echo "
UUID: $UUIDBOX
"


if [ ! "$1" = "skip" ]; then
    echo "Press any key to exit."
    read -r bah
fi






