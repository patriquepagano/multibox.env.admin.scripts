
link=http://1.0.0.95/0/4Export-Videos/As_aventuras_do_capitao_cueca.mkv


link="http://1.0.0.95/0/4Export-Videos/Homem.Aranha.De.Volta.ao.Lar.2017.mp4"
# Kodi
app=org.xbmc.kodi
am force-stop $app && am start -a android.intent.category.LAUNCHER -n $app/.Splash -d $link -t "video/*"


# fix para o cat em algums devices
mkdir -p $EXTERNAL_STORAGE/tmp
TMPDIR=$EXTERNAL_STORAGE/tmp
export TMPDIR



apps=`pm list packages -f | grep -e '/system/app/' | sed -e 's,package:/system/app/,,g' | cut -d "=" -f 2 | sort`




# liberar permissões apps android 6

# não funciona tem que ser instalado pelo kodi para instalar dependencias
cd $EXTERNAL_STORAGE/Android/data/org.xbmc.kodi/files/.kodi/addons
unzip -o $EXTERNAL_STORAGE/FLIXPLAY.zip
unzip -o $EXTERNAL_STORAGE/plugin.video.BrazucaPlay.zip
unzip -o $EXTERNAL_STORAGE/plugin.video.InovaTV.zip




+ playlist apontam para endereços fixos
- adotable storage não funciona em todos android 6.x ate mesmo sansung devices precisam de patchs

definir se o site for 

um catalogo de venda e informações 
um launcher dos jogos que não faço ideia de como fazer?



/system/usr/mediaserver/sh/retroarch/configs/enableDefaultConfig.sh



RetroConfig="$EXTERNAL_STORAGE/Android/data/com.retroarch/files/retroarch.cfg"
cat $RetroConfig | sort > $EXTERNAL_STORAGE/Android/data/com.retroarch/files/retroarch2.cfg



RetroConfig="$EXTERNAL_STORAGE/Android/data/com.retroarch/files/retroarch.cfg"
cat $RetroConfig | grep dir





RetroConfig="$EXTERNAL_STORAGE/Android/data/com.retroarch/files/retroarch.cfg"
cat $RetroConfig | grep path












# sed alterar o path

OIFS="$IFS"
IFS=$'\n'
file="/storage/32A7-021D/PortalGamer/.www/GameBOX/_Playlist_Android/Nintendo - Nintendo 64.lpl"
cat $file



OIFS="$IFS"
IFS=$'\n'
for i in /storage/32A7-021D/PortalGamer/.www/GameBOX/_Playlist_Android/*.lpl ; do
echo "$i"
sed -i -e 's,/sdcard/MediaServer/PortalGamer,/storage/32A7-021D/PortalGamer/.www/GameBOX,g' $i
done




OIFS="$IFS"
IFS=$'\n'
for i in $EXTERNAL_STORAGE/GameBOX/_Playlist_Android/*.lpl ; do
echo "$i"
sed -i -e 's,/"${EXTERNAL_STORAGE}"/GameBOX,/sdcard/GameBOX,g' $i
done









ideia rodar uma varias instancias

rodaria na porta 80 o site main principal que teria o painel de assinatura e configs de restore...

na porta 81 ficaria os games do /sdcard

abrindo outra porta para filmes ou séries.. gibis etc..
no futuro crio um script que formataria em ext4 e montaria apenas no device.. configurando tudo certinho.
fecha com a minha ideia de encher o pendrive e vender com filmes/series pois videos tocariam apenas no tvbox, webstream e scripts teriam acesso via php.

lighttpd -f /storage/32A7-021D/lighttpd.conf























# atualizando os cores do pendrive
source="/storage/32A7-021D"
rsync -ah --progress /data/data/com.retroarch/cores/*.so $source/TopApps/Game_Emulators/Retroarch_arm_cores/





/data/data/com.retroarch/cores













# garantir permissoes para android 6 aqui
apps=`pm list packages -f | grep -e '/data/app/' | sed -e 's,package:/data/app/,,g' | cut -d "=" -f 2 | sort`
for i in $apps; do
echo "liberando permissão de " $i
pm grant $i android.permission.WRITE_EXTERNAL_STORAGE
pm grant $i android.permission.READ_EXTERNAL_STORAGE
pm grant $i android.permission.WRITE_MEDIA_STORAGE
pm grant $i android.permission.READ_MEDIA_STORAGE
done






































