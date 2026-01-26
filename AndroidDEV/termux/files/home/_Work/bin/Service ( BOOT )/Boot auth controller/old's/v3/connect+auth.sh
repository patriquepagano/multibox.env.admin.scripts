#!/system/bin/sh

clear
# input vindo do secretAPI do firmware
IPTest="http://10.0.0.91:777"

# http://10.0.0.91:777/data/

# pin para proteger de bots online ficar postando
export secretAPI="65fads876f586a7sd5f867ads5f967a5sd876f5asd876f5as7d6f58a7sd65f7"

export MacLanReal=`busybox cat /data/macLan.hardware`

#( mostrou no asubox e xiaomi termux )
export MacWiFiReal=`busybox iplink show wlan0 | busybox grep "link/ether" | busybox awk '{ print $2 }'` #  | busybox sed -e 's/:/-/g'
export CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`

# informação variavel
export FirmwareVer=`busybox blkid | busybox sed -n '/system/s/.*UUID=\"\([^\"]*\)\".*/\1/p'`
export ID=`settings get secure android_id`
export IPLocalAtual=`/system/bin/busybox ifconfig \
| /system/bin/busybox grep -v 'P-t-P' \
| /system/bin/busybox grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
| /system/bin/busybox grep -Eo '([0-9]*\.){3}[0-9]*' \
| /system/bin/busybox grep -v '127.0.0.1' \
| /system/bin/busybox head -1`

#PeerPort="$RANDOM"
UsedData=$(busybox df -h | busybox grep "/data" | busybox awk '{ print $4 }' | busybox tr -d '\n')
UsedSystem=$(busybox df -h | busybox grep "/system" | busybox awk '{ print $4 }' | busybox tr -d '\n')

# # ler o serial
if [ -f "/system/Serial" ]; then
export LocalSerial=`/system/bin/busybox cat /system/Serial`
fi

function LoginAuth () {
CheckCurl=`curl -w "%{http_code}" -d  "secretAPI=$secretAPI&\
MacLanReal=$MacLanReal&\
MacWiFiReal=$MacWiFiReal&\
CpuSerial=$CpuSerial&\
FirmwareVer=$FirmwareVer&\
ID=$ID&\
IPLocalAtual=$IPLocalAtual&\
UsedData=$UsedData&\
UsedSystem=$UsedSystem&\
Serial=$LocalSerial&\
" "$IPTest/auth.php" | busybox sed 's/\r$//'`
# extract vars
export Serial=`echo -n $CheckCurl | busybox cut -d ";" -f 1 | busybox cut -d " " -f 1 | busybox sed 's/\r$//'`
export httpCode=`echo -n $CheckCurl | busybox cut -d " " -f 2 | busybox sed 's/\r$//'`

# echo "
# $CheckCurl
# "
# echo "ADM DEBUG ### Serial   : $Serial"
# echo "ADM DEBUG ### httpCode : $httpCode"
# exit

}

# entra em loop de espera para ver se o vps recebeu as vars
# o vps vai entregar o arquivo shell baseado em trial, fullacess ou banido
while [ 1 ]; do
	echo "post data vars"
	LoginAuth
	if [ "$httpCode" == "200" ]; then break; fi; # se for igual a 200 sai deste loop
	# tempo para a box tentar enviar as vars novamente
	busybox sleep 30  
done;

# primeiro install do serial na box
if [ ! -f "/system/Serial" ]; then
	echo "ADM DEBUG ### gravando Serial na system   : $Serial"
	/system/bin/busybox mount -o remount,rw /system
	echo -n $Serial > "/system/Serial"
	#/system/bin/busybox chmod 644 "/system/Serial"
fi
echo "ADM DEBUG ### Serial        : $Serial"
echo "ADM DEBUG ### LocalSerial   : $LocalSerial"
echo "ADM DEBUG ### httpCode      : $httpCode"

echo "baixando arquivo de boot online v11"

exit



# #####################################################################################################
# # Gerando licença online
# if [ ! -e /system/acesso.vip ] ; then
# 	while [ 1 ]; do
# 		senha=`$curl "http://54.232.19.212/keyaccess.php"`		
# 		if [ ! $senha = "" ]; then
# 			echo "<h1>Recebendo arquivo de licença</h1>" >> $bootLog 2>&1
# 			echo "<h2>Senha gerada com sucesso!</h2>" >> $bootLog 2>&1
# 			break
# 		fi # check return value, break if successful (0)
# 		$sleep 1;
# 	done;
# 	$mount -o remount,rw /system
# 	echo -n $senha > /system/acesso.vip
# fi

# # variaveis disponiveis no segundo boot após serem ativados
# if [ -e /system/acesso.vip ] ; then
# 	export senha=`$cat /system/acesso.vip`
# fi
# if [ -e $PHome/customer_name.php ] ; then
# 	export UserName=`$cat $PHome/customer_name.php`
# fi
# if [ -e $PHome/android_name.php ] ; then
# 	export AndroidName=`$cat $PHome/android_name.php`
# fi
# if [ -e $PHome/UserPass ] ; then
# 	export UserPass=`$cat $PHome/UserPass`
# fi

# # verificação caso tenha gravado mas esteja em branco
# if [ $senha = "" ] ; then
# 	echo "<h1>Atenção</h1>" >> $bootLog 2>&1
# 	echo "<h1>Sem senha de acesso, reiniciar e tentar novamente.</h1>" >> $bootLog 2>&1
# 	$mount -o remount,rw /system
# 	$rm /system/acesso.vip
# 	$sleep 7
# 	am start -a android.intent.action.REBOOT
# fi

# echo "<h1>Código de acesso</h1>" >> $bootLog 2>&1
# echo "" >> $bootLog 2>&1
# echo "" >> $bootLog 2>&1
# echo "<h2>$senha</h2>" >> $bootLog 2>&1

# # -------------------------------------------------------------------------------------------------------------------------------------------------------------------
# # user form
# # obrigatorio ter internet aqui loopa ate efetuar o cadastro caso não esteja instalado / cadastro, ativa e completa instalação/ boot normal
# if [ ! -e $PHome/.install.ok ]; then
# 	while [ 1 ]; do
# 		$wget --spider "ipv4.icanhazip.com" # entra em looping ate ter acesso a internet para abrir as paginas de formulário
# 		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
# 		$sleep 1;
# 	done;
# 	# ------------------------------------------------------------------
# 	# checando acesso para filtrar link do formulário
# 	Acesso=`$curl -d  "Fabricante=$Fabricante&Dispositivo=$Dispositivo&secretAPI=$secretAPI&rom_build=$RomBuild&cpu=$CPU&senha=$senha" -X POST "http://54.232.19.212/first_boot.php"`
# 	if [ "$Acesso" == "NEW" ] ; then
# 			export LinkForms="http://54.232.19.212/signup.php?Fabricante=$Fabricante&Dispositivo=$Dispositivo&secretAPI=$secretAPI&rom_build=$RomBuild&cpu=$CPU&senha=$senha"
# 		else
# 			export LinkForms="http://54.232.19.212/waiting_room.php?Fabricante=$Fabricante&Dispositivo=$Dispositivo&secretAPI=$secretAPI&rom_build=$RomBuild&cpu=$CPU&senha=$senha"
# 	fi
# 	# abre link do formulário para user preencher
# 	am start --user 0 \
# 	-n com.xyz.fullscreenbrowser/.BrowserActivity \
# 	-a android.intent.action.VIEW -d "$LinkForms" > /dev/null 2>&1
	
# 	# gerar arquivos para debug /desativar depois de testar
# 	echo -n "http://54.232.19.212/signup.php?Fabricante=$Fabricante&Dispositivo=$Dispositivo&secretAPI=$secretAPI&rom_build=$RomBuild&cpu=$CPU&senha=$senha" > $PHome/UrlSignup
# 	echo -n "http://54.232.19.212/apps.php?Fabricante=$Fabricante&Dispositivo=$Dispositivo&secretAPI=$secretAPI&rom_build=$RomBuild&cpu=$CPU&senha=$senha" > $PHome/Urlapps
# 	echo -n "http://54.232.19.212/waiting_room.php?Fabricante=$Fabricante&Dispositivo=$Dispositivo&secretAPI=$secretAPI&rom_build=$RomBuild&cpu=$CPU&senha=$senha" > $PHome/UrlWaiting_room
# #echo -n "http://personaltecnico.net/Android/$secretAPI/$RomBuild/$senha/customer_name.php" > $PHome/CustomerNameLink
# #echo -n "http://www.personaltecnico.net/Android/$secretAPI/$RomBuild/$senha/selected_profile.php" > $PHome/selectedProfileLink



# # atenção sobre o modo de manutenção do site.
# # http://www.personaltecnico.net/wp-admin/options-general.php?page=seed_csp4
# # tem que ativar o  "Ativar modo de manutenção" assim arquivos que não existem da o erro 503 e o script funciona!

# 	# ------------------------------------------------------------------	
# 	# customer_name / trava em loop ate user preencher o formulario e gerar os arquivos para conseguir baixar
# 	Link="http://personaltecnico.net/Android/$secretAPI/$RomBuild/$senha/customer_name.php"
# 	while [ 1 ]; do
# 		# -O sobreescreve o arquivo caso exista sempre puxa a versao nova.
# 		$wget -O $PHome/customer_name.php --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "$Link"
# 		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
# 		$sleep 7;
# 		echo "Aguardando cadastrar nome de usuário" >> $systemLog
# 	done;
# 	# ------------------------------------------------------------------		
# 	# android_name / trava em loop ate user preencher o formulario e gerar os arquivos para conseguir baixar
# 	Link="http://personaltecnico.net/Android/$secretAPI/$RomBuild/$senha/android_name.php"
# 	while [ 1 ]; do
# 		# -O sobreescreve o arquivo caso exista sempre puxa a versao nova.
# 		$wget -O $PHome/android_name.php --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "$Link"
# 		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
# 		$sleep 7;
# 			echo "Aguardando cadastrar um apelido para o TVBox" >> $systemLog
# 	done;

# 	export UserName=`$cat $PHome/customer_name.php`
# 	export AndroidName=`$cat $PHome/android_name.php`
	
# fi

# # Mudança profile hard reset!
# 	# se o arquivo não existir vai entrar em loop
# linkP="http://personaltecnico.net/Android/$secretAPI/$RomBuild/$senha/selected_profile.php"
# if [ ! -e $PHome/selected_profile.php ]; then
# 	while [ 1 ]; do
# 		# -O sobreescreve o arquivo caso exista sempre puxa a versao nova.
# 		$wget -O $PHome/selected_profile.php --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "$linkP"
# 		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
# 		$sleep 10;
# 	done;
# fi
# # verificação do curl comparando se o profile online confere com o instalando cuidado fazer caso tenha internet
# check=`$wget --max-redirect=0 --spider -S "$linkP" 2>&1 | $grep "HTTP/" | $awk '{print $2}'`
# if [ "$check" == "200" ]; then
# 	# echo "url existe! iniciar verificação."
# 	checkP=`$curl $linkP`
# 	export selected_profile=`cat $PHome/selected_profile.php`
# 	if [ ! "$checkP" == "$selected_profile" ]; then
# 		# user alterou o profile em seu painel reseta para iniciar
# 		am broadcast -a android.intent.action.MASTER_CLEAR
# 	fi
# fi

