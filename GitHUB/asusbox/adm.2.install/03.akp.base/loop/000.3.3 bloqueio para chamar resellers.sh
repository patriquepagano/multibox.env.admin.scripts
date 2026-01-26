
# isto se provou um FRACASSO um ex. uma box bloqueada AE | Abu Dhabi | Al Ain City o cpu e mac não logou novamente
# em vez disto apareceu outro cpu e mac na mesma localização
# ou o cara descobriu como alterar seu cpu e mac usando um twrp da vida
# ou fez uma copia do firmware e instalou em box diferente
# este tipo de bloqueio é totalmente ineficas!

# function BloqueiaNewReseller () {
# 	echo "<h1>Oportunidade de negócio! Trabalhe conosco!</h1>" > $bootLog 2>&1
# 	echo "<h3>Nosso servidor detectou que seu TVBOX esta fora do Brasil." >> $bootLog 2>&1
# 	echo "Temos interesse em desenvolver nossos produtos em sua localização atual." >> $bootLog 2>&1
# 	echo "Entre em contato, temos uma ótima proposta para você ser nosso sócio/gerente." >> $bootLog 2>&1
# 	echo "https://wa.me/447360756021" >> $bootLog 2>&1
# 	echo "Whatsapp e Telegram = +447360756021</h3>" >> $bootLog 2>&1
# 	echo "<h3>Key => $Placa=$CpuSerial=$MacLanReal</h3>" >> $bootLog 2>&1
# 	acr.browser.barebones.launch
# 	sleep 1200
# 	rm /data/asusbox/reboot
# 	am start -a android.intent.action.REBOOT
# }

# # rk30sdk=dd7965d5cf6faa85=9E9FFF72762A
# # 01/03/2023 12:53:16|192.168.1.102| 16.98.19.132 | US | Florida | Winter Garden|D 1.9G|S 919.5M|up 3 min

# # rk30sdk=d9e4c0161a42e1bc=A2884CEF8A70
# #  18/02/2023 15:55:34|192.168.1.102| 107.145.123.196 | US | Florida | Melbourne|D 1.6G|S 919.5M|up 16 days

# # rk30sdk=804ce64487aa9bfe=D2FC63BA405C
# # #  06/01/2023 10:07:35|192.168.1.106| 31.218.11.27 | AE | Abu Dhabi | Al Ain City|D 1.4G|S 919.5M|up 3 min

# # rk30sdk=0c21973ba9ee3b16=A81803BFD45A
# # #  05/01/2023 09:52:55|192.168.100.80| 132.251.253.137 | BO | Cochabamba | Cochabamba|D 1.3G|S 917.1M|up 3 days



# # rk30sdk=289b9db7c3408ff3=129F74ADA957
# #  12/01/2023 20:49:22|192.168.1.3| 152.237.251.24 | UY | Montevideo | Montevideo|D 1.8G|S 917.1M|up  1:26

# # não quis parceria e esta expirado
# # rk30sdk=68da431a4cb079a4=A81702CE6D4F
# # #  29/12/2022 18:10:37|192.168.1.88| 144.64.41.93 | PT | Leiria | Marinha Grande|D 1.2G|S 917.1M|up 1 day


# BlockListDevices="
# rk30sdk=dd7965d5cf6faa85=9E9FFF72762A
# rk30sdk=d9e4c0161a42e1bc=A2884CEF8A70
# rk30sdk=804ce64487aa9bfe=D2FC63BA405C
# rk30sdk=0c21973ba9ee3b16=A81803BFD45A
# rk30sdk=289b9db7c3408ff3=129F74ADA957
# "
# checkUserAcess=`echo "$BlockListDevices" | grep "$Placa=$CpuSerial=$MacLanReal"`
# if [ ! "$checkUserAcess" == "" ]; then
# 	# box esta na lista executando a função
# 	BloqueiaNewReseller
# fi






