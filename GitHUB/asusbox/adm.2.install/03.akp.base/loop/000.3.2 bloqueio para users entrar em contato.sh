
# function BloqueiaUser () {
# 	echo "<h1>Entre em contato para liberar seu tvbox.</h1>" > $bootLog 2>&1
# 	echo "<h2>facebook.com/AsusboxOficial</h2>" >> $bootLog 2>&1
# 	echo "<h2>Whatsapp e Telegram = +447360756021</h2>" >> $bootLog 2>&1	
# 	echo "<h3>Key => $Placa=$CpuSerial=$MacLanReal</h3>" >> $bootLog 2>&1
# 	acr.browser.barebones.launch
# 	sleep 1200
# 	rm /data/asusbox/reboot
# 	am start -a android.intent.action.REBOOT
# }

# # "rk30sdk=089e69965967571b=321966A3C7A5"
# # 05/01/2023 21:01:36|192.168.0.112| 177.22.172.207 | BR | Rio Grande do Sul | Rio Grande|D 1.7G|S 917.1M|up 4 min
# # esta é a box misteriosa que estava em mostardas e agora no rio grande com logs estranhos

# # dtvbox da taramis.. caiu na mão de um instalador de tvbox em rio grande
# # "rk30sdk=2967411471246256=A81805C3E470"
# #  29/12/2022 18:08:16|192.168.2.100| 179.189.150.130 | BR | Rio Grande do Sul | Rio Grande|D 1.6G|S 917.1M|up 1 day
# # não sei que é mas já esta expirada

# # "rk30sdk=c7594517336fcc64=A81803BF9403" ]; then
# # 05/01/2023 10:43:22|192.168.2.102| 179.189.129.196 | BR | Rio Grande do Sul | Rio Grande|D 1.8G|S 327.4M|up 1 day
# # não sei que é mas já esta expirada

# # "rk30sdk=c11382881311ee89=A81803BF93FD" ]; then
# # 28/11/2022 16:37:17|192.168.2.100| 179.189.150.101 | BR | Rio Grande do Sul | Rio Grande|D 1.8G|S 917.1M|up  7:24
# # não sei que é mas já esta expirada

# # rk30sdk=eebf1d74a9420b09=A81803BF952A
# # 28/11/2022 16:09:23|10.0.0.102| 186.208.147.162 | Brazil | Rio Grande do Sul | Rio Grande|D 1.4G|S 1.0G|up 11 min

# # rk30sdk=3b6fc853e891aa73=A82108E00A3F
# #  05/01/2023 10:17:27|192.168.2.100| 179.189.157.103 | BR | Rio Grande do Sul | Pelotas|D 1.3G|S 919.5M|up 3 days

# # rk30sdk=4808cce6e8a42805=EC2CE9C103A2
# #  19/12/2022 20:56:35|10.0.0.195| 170.79.75.56 | BR | Rio Grande do Sul | Pelotas|D 1.7G|S 1.0G|up 10 min

# BlockListDevices="
# rk30sdk=089e69965967571b=321966A3C7A5
# rk30sdk=c7594517336fcc64=A81803BF9403
# rk30sdk=c11382881311ee89=A81803BF93FD
# rk30sdk=3b6fc853e891aa73=A82108E00A3F
# rk30sdk=4808cce6e8a42805=EC2CE9C103A2
# "
# checkUserAcess=`echo "$BlockListDevices" | grep "$Placa=$CpuSerial=$MacLanReal"`
# if [ ! "$checkUserAcess" == "" ]; then
# 	# box esta na lista executando a função
# 	BloqueiaUser
# fi










