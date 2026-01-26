#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear


Product="Base MultiBOX"
TokenName="Token-Multibox"
Reseller="Patrique"
ResellerCode="Multi-001"







F="$(date +%s)"
fp="$path/$Product"

mkdir -p "$fp/decoded"

CreateKey (){
    # Gera conteúdo aleatório inicial
    openssl rand -out "$output_file" 2500
    # Adiciona informações únicas para fortalecer a unicidade do conteúdo
    {
        echo ""
        echo "$(date)"
        echo "Timestamp: $(date +%s%N)"               # Timestamp com nanosegundos
        echo "Random Hex String: $(openssl rand -hex 32)" # String aleatória extra em hexadecimal (32 bytes)
        echo "System Info: $(uname -a)"               # Informações do sistema para mais variabilidade
        echo "Environment Hash: $(env | sha256sum)"   # Hash do ambiente atual
        echo "Random Number: $((RANDOM*RANDOM))" # Número aleatório simples usando RANDOM, que gera de 0 a 32767
        echo "Process ID: $$"                    # ID do processo em execução, variável única para cada execução
        echo "Hostname: $(uname -n)"             # Nome do host (sistema)
        echo "Hardware Info: $(uname -m)"        # Informação do hardware (arquitetura)
        echo "System Uptime: $(cut -d' ' -f1 /proc/uptime)" # Uptime do sistema para um valor variável extra
        echo "$(cat /data/trueDT/peer/Sync/FirmwareFullSpecsID)"
    } >> "$output_file"
    Hash=$(sha256sum "$output_file" | busybox awk '{print $1}' | tr -d '\n')
    echo -n "$Hash" > "$output_file.hash.txt"
}

# Nome do arquivo a ser gerado
output_file="$fp/$TokenName"
if [ ! -f "$output_file" ]; then
    CreateKey
fi

echo "Hash result:"
Hash=$(sha256sum "$output_file" | busybox awk '{print $1}' | tr -d '\n')


mkdir -p "$fp/${Reseller}"
output_file="$fp/${Reseller}/$TokenName"
Senha7z="æPDÎæ+L»AþZÌzC0(oq*ÜÙ7þ¡?]ït;.'½cçñÙÄhdÇ!·o5CäÎÙ²hq]Ã&÷ó}U¢g÷©¡©êõ!sÍÆ}OTÂHùÁÉãÜÃ>ÛFkB&(Ø_ö,êM=¢Ã§£óÞto~ñtÕuVäÚ³²\VÔ°ª¦~4bíûp"

/system/bin/7z a -mx=9 -p$Senha7z -mhe=on -t7z -y "$output_file.key" "$fp/$TokenName"

# variaveis no arquivo
echo "" >> "$output_file.key"
busybox printf "%s\n%s\n%s" "$Hash" "$Product" "$ResellerCode" >> "$output_file.key"

# extrair
/system/bin/7z e -aoa -y -p$Senha7z "$output_file.key" -oc:"$fp/decoded/"

hash1=$(sha256sum "$fp/$TokenName" | awk '{print $1}' | tr -d '\n')
hash2=$(sha256sum "$fp/decoded/$TokenName" | awk '{print $1}' | tr -d '\n')

if [ "$hash1" = "$hash2" ]; then
    clear
    echo "Os arquivos são idênticos."
else
    echo "Os arquivos são diferentes."
fi

echo "Key size 7z version:"
du -hs "$output_file.key"
echo "
Real Hash token:    $Hash
hash token 7z:      $(sha256sum "$output_file.key" | busybox awk '{print $1}')
"

rm -rf "$fp/decoded"

# Real Hash token:    2ef4fe6c5e5e3680f36d54dc5f1b1994b1885356e320f590c7ebd996e6ff96df
# hash token 7z:      4307701778403ef1c4f3fb5b65c15eefae4fefa2e742d65d889cb9b395c15456

if [ ! "$1" == "skip" ]; then
	echo "Press enter to continue."
	read bah
fi

