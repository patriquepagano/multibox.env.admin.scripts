#!/system/bin/sh
source /data/.vars
clear

# am start --user 0 \
# -n com.xyz.fullscreenbrowser/.BrowserActivity \
# -a android.intent.action.VIEW -d "http://localhost"

if [ "$CPU" == "arm64-v8a" ] ; then
	app=com.retroarch.aarch64
else
	app=com.retroarch
fi
am force-stop $app


# baixar os assets online
path="$EXTERNAL_STORAGE/Download"

/system/bin/busybox find -L "$path" -name "*.gbx" |while read fullpath; do
#echo "$fullpath"
export profilePlataform=`sed -n 1p "$fullpath" | tr -d '\r\n'` # FB Alpha - Arcade Games
export core=`sed -n 2p "$fullpath" | tr -d '\r\n'`
export crc=`sed -n 3p "$fullpath" | tr -d '\r\n'`
export rom_file=`sed -n 5p "$fullpath" | tr -d '\r\n'`
export rom_name=`sed -n 6p "$fullpath" | tr -d '\r\n'`
export data_game_name=`sed -n 7p "$fullpath" | tr -d '\r\n'`
export game_name=`sed -n 8p "$fullpath" | tr -d '\r\n'`
export year=`sed -n 9p "$fullpath" | tr -d '\r\n'`
echo $game_name
  # # game logo
  link="www.meugamebox.com/GameBOX/$profilePlataform/db/$game_name.png"
  while [ 1 ]; do
      /system/bin/wget -N --no-check-certificate -P "$www/GameBOX/$profilePlataform/db/" --no-check-certificate "$link"
      if [ $? = 0 ]; then break; fi
      sleep 1
  done
  # # game txt
  link="www.meugamebox.com/GameBOX/$profilePlataform/db/$game_name.txt"
  while [ 1 ]; do
      /system/bin/wget -N --no-check-certificate -P "$www/GameBOX/$profilePlataform/db/" --no-check-certificate "$link"
      if [ $? = 0 ]; then break; fi
      sleep 1
  done
  # Named_Boxarts
  link="www.meugamebox.com/GameBOX/$profilePlataform/Named_Boxarts/$data_game_name.png"
  while [ 1 ]; do
      /system/bin/wget -N --no-check-certificate -P "$www/GameBOX/$profilePlataform/Named_Boxarts/" --no-check-certificate "$link"
      if [ $? = 0 ]; then break; fi
      sleep 1
  done
  # Named_Snaps
  link="www.meugamebox.com/GameBOX/$profilePlataform/Named_Snaps/$data_game_name.png"
  while [ 1 ]; do
      /system/bin/wget -N --no-check-certificate -P "$www/GameBOX/$profilePlataform/Named_Snaps/" --no-check-certificate "$link"
      if [ $? = 0 ]; then break; fi
      sleep 1
  done
  # Named_Titles
  link="www.meugamebox.com/GameBOX/$profilePlataform/Named_Titles/$data_game_name.png"
  while [ 1 ]; do
      /system/bin/wget -N --no-check-certificate -P "$www/GameBOX/$profilePlataform/Named_Titles/" --no-check-certificate "$link"
      if [ $? = 0 ]; then break; fi
      sleep 1
  done
  # move o gbx
  while [ 1 ]; do
      mv $fullpath "$www/GameBOX/$profilePlataform/db/"
      if [ $? = 0 ]; then break; fi
      sleep 1
  done
done


exit











# diretório para ter os symlinks de playlists
# todas as playlists possiveis vão ir junto no pacote Gamebox (.gbx,.xml,.lpl)
# por enquanto vou gerar playlists na box para debugs apenas
mkdir -p /data/GameBOX/Playlists



# gerar symlinks por aquivos não compensa!
rm /data/GameBOX/storage
ln -sf $www/GameBOX /data/GameBOX/storage



# permissao do user da pasta

# #dumpsys package $app > /sdcard/$app-Dump.Log
# uid=`cat /sdcard/$app-Dump.Log | grep "userId" | cut -d "=" -f 2`
# echo $uid

########################################################################################################################################
########################################################################################################################################
# sistema de playlist ok

path="/data/GameBOX/storage"
#path=/storage/emulated/0/Android/data/asusbox/.www/GameBOX
rm /data/GameBOX/Playlists/*.lpl > /dev/null 2>&1
rm -rf $EXTERNAL_STORAGE/RetroArch/playlists
rm -rf $EXTERNAL_STORAGE/RetroArch/thumbnails
rm -rf /data/data/com.retroarch/shaders


/system/bin/busybox find -L "$path" -name "*.gbx" |while read fullpath; do
#echo "$fullpath"
export profilePlataform=`sed -n 1p "$fullpath" | tr -d '\r\n'` # FB Alpha - Arcade Games
export core=`sed -n 2p "$fullpath" | tr -d '\r\n'`
export crc=`sed -n 3p "$fullpath" | tr -d '\r\n'`
export rom_file=`sed -n 5p "$fullpath" | tr -d '\r\n'`
export rom_name=`sed -n 6p "$fullpath" | tr -d '\r\n'`
export game_name=`sed -n 7p "$fullpath" | tr -d '\r\n'`
export year=`sed -n 9p "$fullpath" | tr -d '\r\n'`

echo "$profilePlataform => $game_name"

cat <<EOF >> "/data/GameBOX/Playlists/${profilePlataform}.lpl"
$path/$profilePlataform/$rom_file
$game_name
/data/data/$app/cores/${core}_libretro_android.so
${core}_libretro_android.so
$crc|crc
${profilePlataform}.lpl
EOF

done


exit


{
  "version": "1.2",
  "default_core_path": "",
  "default_core_name": "",
  "label_display_mode": 0,
  "right_thumbnail_mode": 0,
  "left_thumbnail_mode": 0,
  "items": [
    {
      "path": "/storage/149F-0ADC/GameBOX/Games/fba/fbalpha2012/1941.zip",
      "label": "1941 - Counter Attack",
      "core_path": "/data/data/$app/cores/fbalpha2012_libretro_android.so",
      "core_name": "FB Alpha - Arcade Games",
      "crc32": "c4fff5a2d094d663ecca7d307067b63d|crc",
      "db_name": "FB Alpha - Arcade Games.lpl"
    },
  ]
}




# $find $www/GameBOX -name "*.txt"|while read fname; do
#   rm "$fname"
# done



# exit





exit

# $find $www/GameBOX -name "*.png"|while read fname; do
#   rm "$fname"
# done

