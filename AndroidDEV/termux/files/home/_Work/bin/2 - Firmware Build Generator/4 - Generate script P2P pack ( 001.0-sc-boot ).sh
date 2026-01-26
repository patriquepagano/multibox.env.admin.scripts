#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )

echo "Atualizando scripts = [b] Generate update.04.akp.oem"
sh "$path/[b] Generate update.04.akp.oem.SH"

echo "Atualizando scripts = [b] Generate update.05.akp.cl"
sh "$path/[b] Generate update.05.akp.cl.SH"

/storage/DevMount/GitHUB/asusbox/adm.1.export/01.sc.base/001.0-sc-boot.sh

echo "Pacote de scripts convertidos para SHC com sucesso!"
read bah