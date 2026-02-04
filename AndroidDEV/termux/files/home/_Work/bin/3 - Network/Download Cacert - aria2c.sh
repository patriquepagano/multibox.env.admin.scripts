#!/system/bin/sh
# Menu switch DNS - BusyBox / root limitado
# Compatível com Android TV boxes com BusyBox
clear


CACERT="/data/Curl_cacert.pem"
CACERT_URL="https://curl.se/ca/cacert.pem"
CACERT_MAX_AGE_DAYS=30


# exemplo como o aria2c foi usado em outro script 
#     aria2c --check-certificate=true --ca-certificate="/data/Curl_cacert.pem" --continue=true --max-connection-per-server=4 -x4 -s4 --dir="/data/local/tmp" -o "openssl" "$URL"
 
#leia apenas este script. isto vai rodar em um tvbox android limitado mas tem aria2c instalado entao no topo do 
#script leia o comentario como o aria2c baixa com sucesso um arquivo como seria a função curl_bootstrap_cacert para baixar usando 


# Bootstrap CA bundle usando aria2c (sem verificação de certificado)
# Baixa diretamente para /data/Curl_cacert.pem; se o remoto for mais
# novo, o arquivo será substituído. Não faz verificação TLS (--check-certificate=false).
aria2c_bootstrap_cacert() {
  CACERT="/data/Curl_cacert.pem"
  CACERT_URL="https://curl.se/ca/cacert.pem"
  BB=/system/bin/busybox

  $BB mkdir -p /data

  # timestamp atual (0 se não existe)
  old_ts=$($BB stat -c %Y "$CACERT" 2>/dev/null || echo 0)

  # Faz conditional GET (se servidor suportar) e desabilita verificação de certificado
  aria2c --conditional-get=true --check-certificate=false --continue=true --dir="/data" -o "Curl_cacert.pem" "$CACERT_URL"
  rc=$?

  new_ts=$($BB stat -c %Y "$CACERT" 2>/dev/null || echo 0)

  if [ "$rc" -ne 0 ]; then
    echo "aria2c retornou erro ($rc)." >&2
    return $rc
  fi

  if [ "$new_ts" -gt "$old_ts" ]; then
    echo "CACERT atualizado: $CACERT"
  else
    echo "CACERT já estava atualizado."
  fi
}

aria2c_bootstrap_cacert







if [ ! "$1" = "skip" ]; then
    echo "Press any key to exit."
    read -r bah
fi






