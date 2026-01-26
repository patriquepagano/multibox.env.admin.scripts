#!/system/bin/sh

# if os arquivos não existem , ativa o webserver key
# aguarda pelos arquivos existirem
/data/asusbox/user.serial
/data/asusbox/user.senha

# envia o login para o server vps

# se o arquivo existir empty.new na url..
vai para url da box /$serial/empty.new
marca data de instalação
gera uma senhaUUID php que aponta > updatekey.sh
box baixa o nome da senhaUUID


# php vps
post na url /$serial/$senha
if existir
    gera novo senhaUUID
    atualiza o symlink
    entrega o output nova senhaUUID
else
    trava a box

