#!/system/bin/sh
source /data/.vars

# pastas roms padrão
#rm -rf $www/GameBOX
OIFS="$IFS"
IFS=$'\n'

list="Atari - 2600
Atari - 7800
Atari - Jaguar
Capcom - CP System I
Nintendo - Game Boy
Nintendo - Game Boy Advance
Nintendo - Game Boy Color
Nintendo - Nintendo 64
Nintendo - Nintendo Entertainment System
Nintendo - Super Nintendo Entertainment System
Sega - 32X
Sega - Dreamcast
Sega - Game Gear
Sega - Master System - Mark III
Sega - Mega Drive - Genesis
SNK - Neo Geo
Sony - PlayStation
Sony - PlayStation Portable"
for loop in $list; do
	if [ ! -d "$www/GameBOX/$loop" ];then
		mkdir -p "$www/GameBOX/$loop"
	fi
	if [ ! -d "$www/GameBOX/$loop/Named_Boxarts" ];then
		mkdir -p "$www/GameBOX/$loop/Named_Boxarts"
	fi
	if [ ! -d "$www/GameBOX/$loop/Named_Snaps" ];then
		mkdir -p "$www/GameBOX/$loop/Named_Snaps"
	fi
	if [ ! -d "$www/GameBOX/$loop/Named_Titles" ];then
		mkdir -p "$www/GameBOX/$loop/Named_Titles"
	fi
done



if [ "$CPU" == "arm64-v8a" ] ; then
	package=com.retroarch.aarch64
else
	package=com.retroarch
fi

if [ ! -e /data/data/$package/cores ] ; then
	pm grant $package android.permission.READ_EXTERNAL_STORAGE  > /dev/null 2>&1
	pm grant $package android.permission.WRITE_EXTERNAL_STORAGE  > /dev/null 2>&1
fi

# recursos devem estar instalados , apagar o padrao dentro do data

# D:\TMP\assets
# D:\TMP\autoconfig
# D:\TMP\shaders

# copiar para dentro do github o vps processa este conteudo em forma de pack torrent


# user registra o nome na box
gamer="GuGa"


# pastas uso geral 
# # symlinks que apontam para imagens que vao ao lado da rom que alimenta a interface web
# Fthumbnails="/data/data/$package/thumbnails" # arquivos symlinks das imagems


retroarchVersion="1.8.1"
am force-stop $package 




echo "Gerando arquivo defaults retroarch config"
 
# config Padrão	politicas e privilégios de um usuario "gratuito" que comprou a rom e ganha o pack base..
# config no path padrao do retroarch
# saves e configs todos compartilhados para os mesmos utilizadores
# se for um celular usa o menu rgui, or else > xmb
# virtual joystick some se for um tvbox

mkdir -p $EXTERNAL_STORAGE/Android/data/$package/files
#rm $EXTERNAL_STORAGE/RetroArch/playlists/* > /dev/null 2>&1
defaultConfig="$EXTERNAL_STORAGE/Android/data/$package/files/retroarch.cfg"
cat <<EOF > $defaultConfig
#config_save_on_exit = "false" # true, não salvar para sempre ficar o nosso perfil like batocera

# config interface 7 ptbr / 0 eng
user_language = "7"

# ativa o user para esconder o ip da box
netplay_nickname = "$gamer"
netplay_password = ""

# -------------------------------------------------------------------
# utilize apenas para debug! remove a demora extraindo resources do apk mas NECESSÁRIO expande toda a config para defaults
# mesmo ativando esta opções existem configs que o retroarch sobreescreve ex. save e state
#bundle_assets_extract_enable = "false" # true , expande os assets dentro do data retroarch 


# -------------------------------------------------------------------
# PASTAS PADRÃO PARA TODOS
# usar pasta de assets diferente para enviar custom images feita por nossa equipe
assets_directory = "$EXTERNAL_STORAGE/RetroArch/assets"
video_shader_dir = "$EXTERNAL_STORAGE/RetroArch/shaders/rk3229/"
quick_menu_show_shaders = "false" # true , / aparece no quick menu combo do game



# wallpaper principal da interface
menu_wallpaper = "$EXTERNAL_STORAGE/RetroArch/assets/gamebox.png"

# mais info em autoconfig.todo
joypad_autoconfig_dir = "$EXTERNAL_STORAGE/RetroArch/autoconfig"

# pasta download padrão do android onde as roms são baixadas / carregar roms externo esta desativado
rgui_browser_directory = "$EXTERNAL_STORAGE/Download" # Pasta Download padrão android caso user baixe algo externo

# Playlists ficam de acesso ao php para gerenciar no futuro
playlist_directory = "/data/GameBOX/Playlists"


# -------------------------------------------------------------------
# configs opçoes avançadas liberar ou não para users ?
menu_show_configurations = "false" # true , abre a guia para salvar ou gerar nova config do retroarch.cfg
content_show_settings = "false" # Opções avançadas
menu_show_core_updater = "false" # desativa pois os cores são automaticos o update
menu_show_online_updater = "false" # libera o download de todos os recursos online


# https://forums.launchbox-package.com/topic/44618-retroarch-latency-settings/
# 	Frame Delay set to as high as you can without hearing any audio crackling, 
# if you set it too high and get audio crackles dial it back til the sound gets good again. 
# This will be a per core and maybe per game setting if you really wanna be that specific with it.
# 	Audio Latency set to as low as you can set it without hearing audio crackle.
# 	Run ahead is the new "hackish" way of reducing input lag and you will need to experiment with it. 
# 	You will need to play around with it to get the exact number you want on a per core basis.
# 	All of these will impact performance some so you will have to tinker to find the best settings for your PC, 
# the defaults are a good safe middle ground so that even lower end hardware is fine out of the box.
video_hard_sync = "true" # false , mudei para true tive aleatoriamente parte da tela fica preta barra vertical, tb deu em false
video_hard_sync_frames = "0"


# overlays por plataformas overlays.zip porrada de arquivos pode ser util para jogar no touch
# -------------------------------------------------------------------
# bezels tem que ser por core override mas ainda tem muito oque maturar nisto
# "$EXTERNAL_STORAGE/RetroArch/config/FB Alpha 2012/FB Alpha 2012.cfg" path do config bota dentro as linhas abaixo
# input_overlay = "/data/user/0/$package/overlays/originals borderless/genesisplain.cfg"
# input_overlay_enable = "true"
# config abaixo para desligar esta bosta
menu_show_overlays = "false" # true , ate onde vi é os bezels laterais



# -------------------------------------------------------------------
# XMB
menu_driver = "xmb"
xmb_menu_color_theme = "10" # é a imagem plana que vai usar o wallpaper
xmb_shadows_enable = "false"
xmb_theme = "5" # systematic icons
menu_xmb_thumbnail_scale_factor = "100" # padrao é 100
# -------------------------------------------------------------------
# thumbnails
menu_thumbnails = "1"
menu_left_thumbnails = "3"
thumbnails_directory = "/data/GameBOX/storage"
network_on_demand_thumbnails = "false" # padrao é true
quick_menu_show_download_thumbnails = "false" # padrao é true

# -------------------------------------------------------------------
# Playlists

playlist_entry_rename = "false" # padrao true
playlist_entry_remove = "false" # padrao true
playlist_entry_remove_enable = "0" # padrao 1
# -------------------------------------------------------------------
# Guias de conteudo no xmb
content_show_add = "false" # scanear conteudo (não funciona direito)
content_show_history = "false"
content_show_images = "false"
content_show_music = "false"
# -------------------------------------------------------------------
# favoritos
content_show_favorites = "true" # bloqueado pq não funciona direito , em testes, se usar pendrives pode dar links quebrados
quick_menu_show_add_to_favorites = "true"
# -------------------------------------------------------------------
# savestates
menu_savestate_resume = "true" # padrao é true
savestates_in_content_dir = "false" # padrao false, Nem a box com root o retroarch salva external
savestate_thumbnail_enable = "false" # padrao false,salva snap do state NÃO VALE A PENA GASTO DE ESPAÇO INUTIL E DEIXA LENTO O SAVE STATE
# -------------------------------------------------------------------
# screenshots
screenshots_in_content_dir = "false" # padrao true / não grava em external storage (android)
# -------------------------------------------------------------------
# netplay deixar isto para atualizaçaoes futuras já q não precisa do campo crc da rom na playlist
content_show_netplay = "true"
netplay_nat_traversal = "false" # true, padrao da problema de port mpackageing failed no neogeo

# -------------------------------------------------------------------
# menu do usuario no combokey controle
menu_show_rewind = "false"
menu_show_latency = "false"
menu_show_help = "false"
menu_show_information = "false"
menu_show_load_core = "false"
menu_show_load_content = "false" # Não adianta liberar isto em vista que os cores vão rodar de outro path
# -------------------------------------------------------------------
# outros menus configs
menu_timedate_enable = "false"
menu_dynamic_wallpaper_enable = "false"
menu_navigation_wraparound_enable = "true"
#menu_shader_pipeline = "0" # padrao é 1 caso xmb nao funcione tentar esta outra opção 0
show_hidden_files = "true"
menu_battery_level_enable = "false"

# -------------------------------------------------------------------
# Quick menu
quick_menu_show_information = "false"
quick_menu_show_take_screenshot = "false"
quick_menu_show_cheats = "false" # true


# liberar para os fuçadores via webinterface config / aparece no quick menu combo do game
menu_show_video_layout = "false" # true , não sei pra q serve?
quick_menu_show_options = "false" # true , opçoes do core
quick_menu_show_save_content_dir_overrides = "false" # true 
quick_menu_show_save_core_overrides = "false" # true 
quick_menu_show_save_game_overrides = "false" # true 
quick_menu_show_set_core_association = "false" # true, remove a função de alterar o core direto na playlist
quick_menu_show_reset_core_association = "false" # true


# -------------------------------------------------------------------
# controle config
# Enable touch controls inside the menu.
menu_pointer_enable = "false"
# ativa o overlay dos controles na tela geral
input_overlay_enable = "false"	# true, config para jogar touch, considera-se que possa ser um celular sem gamepad externo
input_overlay_hide_in_menu = "true" # config para jogar touch, Desativa o virtual controle na tela da Rgui

# ativa o analogico para o digital
input_player1_analog_dpad_mode = "1" # 0, padrao
input_player2_analog_dpad_mode = "1"
input_player3_analog_dpad_mode = "1"
input_player4_analog_dpad_mode = "1"


# ativa combo menu / 0 desliga / 1 down L1 R1 Y / 4 start + select 
input_menu_toggle_gamepad_combo = "4"
auto_remaps_enable = "true"


# # # https://batocera.org/wiki/doku.php?id=en:basic_commands
# # # Botões:
### o botão escolhido fica indisponivel para algums jogos
input_enable_hotkey_btn = "106" # hotkey, btn analogico esquerdo 
input_load_state_btn = "100"	# superior = load state (100)
input_save_state_btn = "99"		# esquerda = save state (99)
input_menu_toggle_btn = "96"	# inferior = Menu Emulador (96)
input_exit_emulator_btn = "97"	# direita  = sai do emulador (97)
input_netplay_host_toggle_btn = "107"	# btn analogico direito Ativa o netplay server
input_shader_prev_btn = "102"	# L1 Shader anterior
input_shader_next_btn = "103"	# R1 proximo shader
input_reset_btn = "104"			# L2 Reseta game
input_fps_toggle_btn = "105"	# R2 Alterna fps


# custom buttons tb salvam neste arquivo! ex. tenho um controle ps4 em um android sem root o select esta no 109 e o padrao é o botao ( 4 voltar )
# input_player1_select_btn = "109"



EOF

# neo geo Modo Console
cat <<EOF > $EXTERNAL_STORAGE/Android/data/$package/files/retroarch-core-options.cfg
fba-neogeo-mode = "AES" # não esta funcionando em versões dos ultimos cores
fbalpha2012_neogeo_mode = "AES"
EOF


# se for tvbox não existe touch então altera as linhas..
# if [ -e /sys/class/display ]; then
# 	# Desativa o virtual controle na tela da xml
# 	sed -i -e 's/input_overlay_enable = ".*"/input_overlay_enable = "false"/g' $defaultConfig
# 	sed -i -e 's/input_overlay_hide_in_menu = ".*"/input_overlay_hide_in_menu = "true"/g' $defaultConfig
# fi



# recursos apenas para admin
sed -i -e 's/menu_show_configurations = ".*"/menu_show_configurations = "true"/g' $defaultConfig # true , abre a guia para salvar ou gerar nova config do retroarch.cfg
sed -i -e 's/content_show_settings = ".*"/content_show_settings = "true"/g' $defaultConfig # Opções avançadas
sed -i -e 's/menu_show_core_updater = ".*"/menu_show_core_updater = "true"/g' $defaultConfig # desativa pois os cores são automaticos o update
sed -i -e 's/menu_show_online_updater = ".*"/menu_show_online_updater = "true"/g' $defaultConfig # libera o download de todos os recursos online
sed -i -e 's/quick_menu_show_set_core_association = ".*"/quick_menu_show_set_core_association = "true"/g' $defaultConfig # true, remove a função de alterar o core direto na playlist
sed -i -e 's/quick_menu_show_reset_core_association = ".*"/quick_menu_show_reset_core_association = "true"/g' $defaultConfig  # true


exit




# apenas abrir o frontend para gerar a config
am start --user 0 -a android.intent.action.MAIN -c android.intent.category.LAUNCHER -n $package/.browser.mainmenu.MainMenuActivity

sleep 60
am force-stop $package

# limpando as pastas que não vou usar
rm -rf /data/data/$package/assets
rm -rf /data/data/$package/autoconfig


# exportar config padrão para todos tvbox (acelera o boot da primeira instalaçao)

sort $defaultConfig > "$EXTERNAL_STORAGE/Android/data/$package/files/retroarch-$retroarchVersion.cfg"
sort $defaultConfig > "/sdcard/Retroarch/$retroarchVersion.cfg"


	cmd statusbar collapse
	service call notification 1
	Titulo="GameBOX"
	Mensagem="Pode utilizar o sistema"
	am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV \
	-e int_id 1 -e b_noicon "1" -e b_notime "1" \
	-e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" \
	-e float_csize 16 -e str_content "$Mensagem"
	cmd statusbar expand-notifications


am start --user 0 -a android.intent.action.MAIN -c android.intent.category.LAUNCHER -n $package/.browser.mainmenu.MainMenuActivity

