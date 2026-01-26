#!/system/bin/sh

LDFIX=`echo "$LD_LIBRARY_PATH" | cut -c1-1`
if [ "$LDFIX" == ":" ] ; then
	export LD_LIBRARY_PATH=`echo "$LD_LIBRARY_PATH" | cut -c 2-`
fi

if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
		export TheAPP=os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
		export TheAPP=os.tools.scriptmanager
fi
export TMPDIR="$APPFolder"
export PATH=$APPFolder/bin/applets:$PATH
export sqlite="$APPFolder/bin/sqlite3"
# path removivel
$APPFolder/sc/0_support/Wpath.sh
export Wpath=`cat "$APPFolder/Wpath.TXT"`

$sqlite $APPFolder/databases/bookmarks.db  "DELETE FROM Scripts;"

# sistema de atualização diaria. desativar para meu dev build
$sqlite $APPFolder/databases/scheduler.db  "DELETE FROM sch;"
if [ ! -e $APPFolder/_dev_build ] ; then
db=$APPFolder/databases/scheduler.db
$sqlite $db <<EOF
INSERT INTO sch(id, frecuency, alias, scripts)
VALUES('1', '50665489365467856', 'update', '1;');
EOF
fi

# 584 = boot, background e wakelock
# 544 = background e wakelock

# Suporte Base
$sqlite $APPFolder/databases/bookmarks.db <<EOF
INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('folder:/Suporte Base', 'Suporte Base', '4', '', '/', '1', '1');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/0_support/0.install_support.sh', 'Reconfigurar Suporte Base', '544', '', '/Suporte Base', '2147483647', '0');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/0_support/resetSShdroid.sh', 'Reconfigurar SShdroid', '544', '', '/Suporte Base', '2147483647', '0');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/0_support/AcessoVPN.sh', 'Acesso VPN', '544', '', '/Suporte Base', '2147483647', '0');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/0_support/RemoverSuporteBase.sh', 'REMOVER DESISTALAR APAGAR', '544', '', '/Suporte Base', '2147483647', '0');
EOF


# Base System
if [ ! -e "$APPFolder/bin/lighttpd" ] ; then
$sqlite $APPFolder/databases/bookmarks.db <<EOF
INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/1_base_system/1.install_base.sh', 'Instalar Sistema Base', '544', '', '/', '2147483647', '0');
EOF
else
# webserver
$sqlite $APPFolder/databases/bookmarks.db <<EOF
INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/1_base_system/update.sh', 'Atualizar Sistema', '544', '', '/', '2147483647', '0');
INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/1_base_system/webserver_on.sh', 'Compartilhar', '544', '', '/', '2147483647', '0');
EOF
fi


# RetroArch Free User
if [ -e "$EXTERNAL_STORAGE/RetroArch" ] ; then
$sqlite $APPFolder/databases/bookmarks.db <<EOF
INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('folder:/RetroArch', 'RetroArch', '4', '', '/', '3', '1');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/4_GameBOX/retroarch/kioski_disable.sh', 'Ativa opções avançadas', '544', '', '/RetroArch', '2147483647', '0');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/4_GameBOX/retroarch/kioski_enable.sh', 'Oculta opções avançadas', '544', '', '/RetroArch', '2147483647', '0');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/4_GameBOX/retroarch/gamepad_virtual.sh', 'Ativa Gamepad Virtual', '544', '', '/RetroArch', '2147483647', '0');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/4_GameBOX/retroarch/gamepad_virtual_desativado.sh', 'Oculta Gamepad Virtual', '544', '', '/RetroArch', '2147483647', '0');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/4_GameBOX/retroarch/playlist_psx.sh', 'Playlist - Playstation', '544', '', '/RetroArch', '2147483647', '0');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/4_GameBOX/retroarch/playlist_n64.sh', 'Playlist - Nintendo 64', '544', '', '/RetroArch', '2147483647', '0');

EOF
fi


# GameBOX Free User
if [ -e "$EXTERNAL_STORAGE/RetroArch" ] ; then
$sqlite $APPFolder/databases/bookmarks.db <<EOF
INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('folder:/GameBOX', 'GameBOX', '4', '', '/', '3', '1');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/4_GameBOX/GBfree/user_retroarch.sh', 'Ativar usuário convidado', '544', '', '/GameBOX', '2147483647', '0');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/4_GameBOX/GBfree/free_download.sh', 'Baixa Games Offline', '544', '', '/GameBOX', '2147483647', '0');

EOF
fi



# GameBOX VIP User
if [ -e $APPFolder/_dev_build ] ; then
#export PathGameBOX=`echo $Wpath | sed 's/.\{4\}$//'`  # remove os 4 chars finais string  /www
export PathGameBOX="$EXTERNAL_STORAGE/_GameBOX"
if [ -e "$PathGameBOX" ] ; then
$sqlite $APPFolder/databases/bookmarks.db <<EOF
INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('folder:/GameBOX VIP', 'GameBOX VIP', '4', '', '/', '3', '1');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/4_GameBOX/GBpremium/premium_download.sh', 'Baixa Games Online', '544', '', '/GameBOX VIP', '2147483647', '0');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/4_GameBOX/GBpremium/manage_users.sh', 'Gerenciar usuários', '544', '', '/GameBOX VIP', '2147483647', '0');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/4_GameBOX/GBpremium/userVip_retroarch.sh', 'Ativar usuário VIP', '544', '', '/GameBOX VIP', '2147483647', '0');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/4_GameBOX/GBpremium/userVip_login.sh', 'Adicionar usuário VIP', '544', '', '/GameBOX VIP', '2147483647', '0');

INSERT INTO Scripts(script, alias, flags, args, parent, favoriteindex, isdirectory)
VALUES('$APPFolder/sc/4_GameBOX/GBpremium/retroarch_update.sh', 'Atualizar RetroArch', '544', '', '/GameBOX VIP', '2147483647', '0');

EOF
fi
fi

# reconfigura o Smanager
$APPFolder/sc/0_support/config_smanager.sh > /dev/null 2>&1
