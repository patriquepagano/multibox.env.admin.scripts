#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )


Senha7z="o2u.J4%.~[K*&40njHd*TVp9u7]kEEm\p|c*&SMo:wwSrt9[9!4aQl&4[@P!FZYv%*[X"
# extrair
File="/data/trueDT/peer/Sync/Download/global/FullAccess.21027"
/system/bin/7z e -aoa -y -p$Senha7z "$File" -o"/data/trueDT/peer/Sync/Download/global/" >/dev/null 2>&1



F="/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/[[ Debug ]]/[ Generate keys openssl ]/Key/"
MyKey="$F/private_key.pem"
PublicKey="$F/public_key.pem"

File="/data/trueDT/peer/Sync/Download/global/tmp"

# Verifica a assinatura
openssl dgst -sha256 -verify "$PublicKey" -signature "$File.sig" "$File"






read bah


