####################### DTF Results >>> Sat Apr 10 19:30:32 BRT 2021
Senha7z="TlVoWbhybXuTUfRe3yBc8xEEG390CDLtbEFZ4CVTuMnMPxY2S3WIuse0CUFMwVUicAuucB"
apkName="006.0"
app="jackpal.androidterm"
versionNameOnline="Wed Dec 31 22:06:27 BRT 1969"
SourcePack="/data/asusbox/.install/00.boot/006.0/DTF/006.0.DTF"
excludeListPack "/data/asusbox/.install/00.boot/006.0"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/jackpal.androidterm/Wed Dec 31 22:06:27 BRT 1969" ] ; then
    pm clear jackpal.androidterm
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/jackpal.androidterm-*/lib/arm /data/data/jackpal.androidterm/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop=""
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/jackpal.androidterm/Wed Dec 31 22:06:27 BRT 1969"
fi
###################################################################################
# config forçada para rodar sempre no boot

USBLOGCALL="if install androidterm safe box"
OutputLogUsb

