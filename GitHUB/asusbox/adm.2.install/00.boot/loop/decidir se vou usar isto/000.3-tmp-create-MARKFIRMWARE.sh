
# loop de arquivos que deveriam estar na firmware asusbox padrao


# firmwares rockchip é uma bagunça varias placas funcionam com o mesmo firmware e outras funciona algumas coisas.
# criar um marcador dentro do firmware ex. "AsusBOX.A1_v0001" que funcionaria com as placas que receberem esta mesma tag ( que seria facilmente localizada no site )
# o firmware recebe o marcador quando eu faço o firmware. e os scripts apenas processam de acordo


# posso definir um firmware por seu uuid da system? utilizando este uuid como tag das placas compativeis?
# preciso saber se todos os firmwares tem a mesma uuid



# da594c53-9beb-f85c-85c5-cedf76546f7a > firmware das box 5G

# apagar este arquivo fileMark das boxes
FileMark="AsusBOX.A1 - rockchip - rk3229 - sv605 - MultiBoard - enduser"
if [ ! -f "/system/$FileMark" ];then
    echo "ADM DEBUG ###########################################################################################"
    echo "ADM DEBUG ### marcando firmware para linha asusbox antiga, isto deve vir nativo dentro do firmware"
    echo "ADM DEBUG ### gravando arquivo na system"
    /system/bin/busybox mount -o remount,rw /system
    echo -n "Versão da build real original do firmware" > "/system/$FileMark"
fi




