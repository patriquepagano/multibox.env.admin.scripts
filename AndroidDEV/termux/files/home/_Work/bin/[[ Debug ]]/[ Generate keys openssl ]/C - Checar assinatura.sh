#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

MyKey="$path/Key/private_key.pem"
PublicKey="$path/Key/public_key.pem"

File="/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/[ Generate keys openssl ]/B - Assinar arquivo.sh"

# Verifica a assinatura
openssl dgst -sha256 -verify "$PublicKey" -signature "$File.sig" "$File"


if [ ! "$1" == "skip" ]; then
	echo "Press enter to continue."
	read bah
fi

