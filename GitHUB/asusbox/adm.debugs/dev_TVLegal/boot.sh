#!/system/bin/sh

start=`date +%s`

# boot.sh 

# Responsavel pelo chaveamento
# Requirements: scripts, webserver e chaveamento

Titulo="Iniciando chaveamento"
Mensagem=""
am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV \
-e int_id 1 -e b_noicon "1" -e b_notime "1" \
-e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" \
-e float_csize 16 -e str_content "$Mensagem"
cmd statusbar expand-notifications		

###########################################################################################################################
# extraindo os scripts com oque tiver disponível no firmware
if [ ! -e /data/tvlegal/sc ]; then
	mkdir -p /data/tvlegal/sc
	cd /data/tvlegal/sc
	/system/bin/busybox tar -xvf /system/tvlegal/sc.tar.gz
	/system/bin/busybox chown 1000:1000 -R /data/tvlegal/sc
/system/bin/busybox find /data/tvlegal/sc -type f -name "*.sh" | while read fname; do
/system/bin/busybox chmod 755 $fname
done
fi
# carrega as variaveis
source /data/tvlegal/sc/vars.sh

# debug Code para box expecificas
for i in $(seq 1 3); do
	link="http://personaltecnico.net/Android/TVLegal/debug.$AndroidID.sh"
	check=`$wget --max-redirect=0 --spider -S "$link" 2>&1 | $grep "HTTP/" | $awk '{print $2}'`
	if [ $check = 200 ]; then
	$wget -O /data/tvlegal/debug.sh --no-check-certificate $link
	$dos2unix /data/tvlegal/debug.sh
	$chmod 755 /data/tvlegal/debug.sh
	/data/tvlegal/debug.sh
	rm /data/tvlegal/debug.sh
	break
	fi # check return value, break if successful (0)
	$sleep 1
	echo "verificando link"
done


###########################################################################################################################
# Funções
function HashFolder () {
$find $1 -type f -name "*" | $sort | while read fname; do
    # echo "/system/bin/busybox fname"
    $md5sum "/system/bin/busybox fname" | $cut -d ' ' -f1 >> $PHome/.updates/tmp.hash 2>&1
done
}

function uuidGen () {
export uuidNew=`$curl "http://personaltecnico.net/Android/TVLegal/keyaccess.php"`
}

function netcheck () {
link="ipv4.icanhazip.com"
while [ 1 ]; do
	check=`$wget --max-redirect=0 --spider -S "$link" 2>&1 | $grep "HTTP/" | $awk '{print $2}'`
	if [ $check = 200 ]; then
	echo barbaridade
	break
	fi # check return value, break if successful (0)
	$sleep 1
	clear
	echo "code $check Tentando novamente"
done

}

###########################################################################################################################
# webserver
if [ ! -e $www ]; then
	mkdir -p $www
fi
if [ ! -e $PHome/.updates ]; then
	mkdir -p $PHome/.updates
fi
# expandir arquivos os arquivos do que tiver dentro do firmware
if [ ! -e $www/code.hash ]; then
	echo "extraindo o arquivo"
	cd $PHome/.updates
	$Zip x -y /system/tvlegal/80/code.7z > /dev/null 2>&1
	echo "rsync files"
	$rsync -ah --progress -rptv --delete --recursive --force $PHome/.updates/.code/ $www/.code/ > /dev/null 2>&1
	$rm -rf $PHome/.updates/.code
	$cp /system/tvlegal/80/code.hash $www/
fi
if [ ! -e $www/fontawesome.hash ]; then
	cd $PHome/.updates
	$Zip x -y /system/tvlegal/80/fontawesome.7z > /dev/null 2>&1
	echo "rsync files"
	$rsync -ah --progress -rptv --delete --recursive --force $PHome/.updates/.fontawesome/ $www/.fontawesome/ > /dev/null 2>&1
	$rm -rf $PHome/.updates/.fontawesome
	$cp /system/tvlegal/80/fontawesome.hash $www/
fi
if [ ! -e $www/index.static.hash ]; then
	cd $PHome/.updates
	$Zip x -y /system/tvlegal/80/index.static.7z > /dev/null 2>&1
	echo "rsync files"
	$rsync -ah --progress -rptv --delete --recursive --force $PHome/.updates/.index.static/ $www/.index.static/ > /dev/null 2>&1
	$rm -rf $PHome/.updates/.index.static
	$cp /system/tvlegal/80/index.static.hash $www/
fi
# start webserver
# inicio dos arquivos de log para o usuario
date > $userLog
echo "" >> $userLog
echo "" >> $userLog
echo "Inicio do boot sistema" > $bootLog
echo "" >> $bootLog
# clean log do webserver
rm $www/fcgiserver.log
rm $www/lighttpd.log

/data/tvlegal/sc/80.sh



# verdadeira procedimento inicial do chaveamento
# uuid local generator / fica na partiçao data para mudar a cada hardreset
# -------------------------------------------------------------------------------------------------------------------------------------------------------------------
# uuid install.sh
if [ ! -e /data/tvlegal/install.uuid ]; then
while [ 1 ]; do
	uuidGen
	if [ ! $uuidNew = "" ]; then break; fi; # check return value, break if successful (0)
	$sleep 1;
	echo "code $uuidNew Tentando novamente"
done;
	echo -n $uuidNew > /data/tvlegal/install.uuid
fi

# uuid update.sh que é o update anual
if [ ! -e /data/tvlegal/update.uuid ]; then # if update.uuid
while [ 1 ]; do
	uuidGen
	if [ ! $uuidNew = "" ]; then break; fi; # check return value, break if successful (0)
	$sleep 1;
	echo "code $uuidNew Tentando novamente"
done;
	echo -n $uuidNew > /data/tvlegal/update.uuid
fi # end 1update.uuid


# recarrega todas variaveis
source /data/tvlegal/sc/vars.sh




# primeiro boot sem existir a key na memoria
if [ ! -e /system/tvlegal/CDKey ]; then
# executa o sistema de chaveamento:
# tvbox, ask cdkey:


# abre o brownser local ask pela CDKey
# ??? testar no controle remoto IR se da de digitar os numeros direito
am start --user 0 \
-n com.xyz.fullscreenbrowser/.BrowserActivity \
-a android.intent.action.VIEW -d "http://localhost/CDKey.php" > /dev/null 2>&1

# write geolocalization ai é com filhão



# CDKey.php
# ask pela cdkey
# verifica se a url existe no vps
# 1) BANIDA > if existir no server .../banida/cdkey.. mostra uma pagina com os logos de instalaçao e geolocalizaçao..
# 2) não existe, pergunta novamente
# 3) existe > escreve no arquivo > /system/tvlegal/CDKey

# script ---------------------------------------
# loop esperar pelo arquivo de resposta

# carregar resposta do user
#CDKey=`$cat /system/tvlegal/CDKey`
source /data/tvlegal/sc/vars.sh
CDKey="3459-8673-2091"
echo $CDKey
echo $installUuid
echo $updateUuid
# post CDKey no vps 
$curl -d  "CDKey=$CDKey&installUuid=$installUuid&updateUuid=$updateUuid" -X POST "http://personaltecnico.net/Android/TVLegal/first_boot.php"

# LOOP esperar pelo install.$uuid / trava para verificar o link update, caso meu site esteja for do ar no momento
link="http://personaltecnico.net/Android/TVLegal/$CDKey/install.$installUuid"
while [ 1 ]; do
	check=`$wget --max-redirect=0 --spider -S "$link" 2>&1 | $grep "HTTP/" | $awk '{print $2}'`
	if [ $check = 200 ]; then
	echo "Link verificado com sucesso"
	break
	fi # check return value, break if successful (0)
	$sleep 1
	echo "Link install indisponivel, tentando novamente"
done;






fi # end do cdkey install


# # chaveamento contra pulo do gato:
# se o "esperto" instalar em varias boxes a cada fresh install os uuid serão diferentes
# no processo de post upload para criar os symlinks apaga o anterior automaticamente..
# assim as boxes anteriores não terao acesso ao install e não vai iniciar!

# FIRST BOOT DOS ESPERTINHOS:
# BOX01 Espertinho instala a rom do zero e todos uuids são gerados e instala TUDO
# Box02 Ela instala em outra box do zero, novos uuids são gerados e symlks do server modificados..
# A BOX01 vai encontrar seu id na pasta dos desativados e vai se hard resetar

# loop 7 vezes se a box foi desativada da um hardreset na tvbox

for i in $(seq 1 7); do
	link="http://personaltecnico.net/Android/TVLegal/$CDKey/Desativado/install.$installUuid"
	link="ipv4.icanhazip.com"
	check=`$wget --max-redirect=0 --spider -S "$link" 2>&1 | $grep "HTTP/" | $awk '{print $2}'`
	if [ $check = 200 ]; then
	echo "Negão tu quer me enrolar né? o serial é para o uso de um aparelho por vez!"
	# dale um hard reset no querido aqui
	break
	fi # check return value, break if successful (0)
	$sleep 1
done






# FIRST BOOT INSTALL CENÁRIO:
# internet obrigatória, baixa e roda o script e instala tudo.
# sem internet fica travado aqui, mas os apps estarão na tela para uso.
LinkUpdate="http://personaltecnico.net/Android/TVLegal/$CDKey/install.$installUuid"
# loop trava para verificar o link update, caso meu site esteja for do ar no momento
while [ 1 ]; do
	check=`$wget --max-redirect=0 --spider -S "$LinkUpdate" 2>&1 | $grep "HTTP/" | $awk '{print $2}'`
	if [ $check = 200 ]; then
	echo "Link verificado com sucesso"
	break
	fi # check return value, break if successful (0)
	$sleep 1
	echo "Link install indisponivel, tentando novamente"
done;

# Download do script
while [ 1 ]; do
	/system/bin/wget -O /data/tvlegal/.updates/install.sh --no-check-certificate $LinkUpdate
    if [ $? = 0 ]; then break; fi;
    sleep 1;
done;

$dos2unix /data/tvlegal/.updates/install.sh
$chmod 755 /data/tvlegal/.updates/install.sh
/data/tvlegal/.updates/install.sh

