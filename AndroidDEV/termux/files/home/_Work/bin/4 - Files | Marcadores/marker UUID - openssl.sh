#!/system/bin/sh
# Menu switch DNS - BusyBox / root limitado
# Compatível com Android TV boxes com BusyBox
clear
path="$( cd "${0%/*}" && pwd -P )"

UUIDPath="/system/UUID.Uniq.key.txt"
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

# Verifica se o arquivo existe e se a primeira linha tem exatamente 64 caracteres.
if [ ! -f "$UUIDPath" ] || [ "$(busybox head -n 1 "$UUIDPath" | busybox tr -d '[:space:]' | busybox wc -c)" -ne 64 ]; then
  echo "ADM DEBUG ########### Conteúdo do arquivo: $(busybox head -n 1 "$UUIDPath")"
  echo "ADM DEBUG ########### The file $UUIDPath is not a valid UUID file."
  UUIDBOX=`/system/usr/bin/openssl rand -hex 32`
    # apagando arquivo para forçar a recriação
    /system/bin/busybox mount -o remount,rw /system
    rm -f "$UUIDPath"
  attempt=1
  # 3) Tenta gravar e validar o UUID por ate 11 tentativas.
  echo "ADM DEBUG ########### Etapa 3: Iniciando tentativas de gravação do UUID."
  while [ "$attempt" -le 11 ]; do
    echo "ADM DEBUG ########### Tentativa $attempt de 11."
    # 3.1) Remonta /system como RW antes de tentar gravar.
    echo "ADM DEBUG ########### Etapa 3.1: Tentando remontar /system como RW."
    if [ ! -f "$UUIDPath" ] || [ ! -s "$UUIDPath" ]; then
      /system/bin/busybox mount -o remount,rw /system
      # 3.2) Grava o UUID gerado quando arquivo nao existe ou esta vazio.
      echo "ADM DEBUG ########### Etapa 3.2: Tentando gravar o UUID gerado."
      echo "$UUIDBOX" > "$UUIDPath" 2>/dev/null
      busybox sleep 1
    fi
    if [ -f "$UUIDPath" ]; then
      check_value=`busybox cat "$UUIDPath" 2>/dev/null | busybox tr -d '\r\n'`
      # 3.3) Se o arquivo tem o UUID gerado, confirma a gravacao.
      echo "ADM DEBUG ########### Etapa 3.3: Verificando se o UUID foi gravado corretamente."
      if [ "$check_value" = "$UUIDBOX" ]; then
        wrote_ok=1
        break
      fi
      # 3.4) Se o arquivo tem outro valor nao vazio, usa ele e sai.
      echo "ADM DEBUG ########### Etapa 3.4: Verificando se o arquivo tem outro valor não vazio."
      if [ -n "$check_value" ]; then
        UUIDBOX="$check_value"
        break
      fi
    fi
    # 3.5) Espera um pouco antes de tentar novamente.
    echo "ADM DEBUG ########### Etapa 3.5: Tentativa falhou, aguardando antes de tentar novamente."
    attempt=$((attempt + 1))
    busybox sleep 1
  done
  # 4) Se falhar, segue sem travar o fluxo.
  echo "ADM DEBUG ########### Etapa 4: Todas as tentativas falharam, seguindo sem travar o fluxo."
  if [ "$wrote_ok" != "1" ]; then
    echo "UUID write failed after 11 attempts."
    wrote_ok=0
  fi
fi



echo "
UUID: $UUIDBOX
"


if [ ! "$1" = "skip" ]; then
    echo "Press any key to exit."
    read -r bah
fi






