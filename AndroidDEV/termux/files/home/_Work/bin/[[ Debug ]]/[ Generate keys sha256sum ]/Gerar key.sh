#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

# Pergunta o nome do grupo
echo "Digite o nome do grupo para gerar as chaves: "

read group_name

F="$(date +%s)"
fp="$path/.$F = ${group_name}"

mkdir -p "$fp/decoded"

# Nome do arquivo a ser gerado
output_file="$fp/${group_name}"

# Gera conteúdo aleatório inicial de 500 bytes
openssl rand -out "$output_file" 500

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
    echo "$(cat /data/trueDT/peer/Sync/Log.FileSystem.SDCARD.list.live)"
    echo "$(cat /data/trueDT/peer/Sync/Log.ExternalDrivers.live)"
} >> "$output_file"

Senha7z="æPDÎæ+L»AþZÌzC0(oq*ÜÙ7þ¡?]ït;.'½cçñÙÄhdÇ!·o5CäÎÙ²hq]Ã&÷ó}U¢g÷©¡©êõ!sÍÆ}OTÂHùÁÉãÜÃ>ÛFkB&(Ø_ö,êM=¢Ã§£óÞto~ñtÕuVäÚ³²\VÔ°ª¦~4bíûp"

/system/bin/7z a -mx=9 -p$Senha7z -mhe=on -t7z -y "$output_file.key" "$output_file"
rm "$output_file"

echo -e "\nAdd-On A7" >> "$output_file.key"


# extrair
/system/bin/7z e -aoa -y -p$Senha7z "$output_file.key" -oc:"$fp/decoded/"

echo "Key size 7z version:"
du -hs "$output_file.key"

echo "Hash result:"
sha256sum "$output_file.key" | busybox awk '{print $1}'

if [ ! "$1" == "skip" ]; then
	echo "Press enter to continue."
	read bah
fi

