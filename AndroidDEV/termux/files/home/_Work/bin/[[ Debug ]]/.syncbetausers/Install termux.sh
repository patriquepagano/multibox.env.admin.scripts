####################### AKP Results >>> Thu Dec 10 02:38:32 GMT 2020
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
apkName="termux0.103"
app="com.termux"
versionNameOnline="0.103"
AppGrantLoop=""
SourcePack="/data/trueDT/peer/Sync.BetaUsers/termux0.103/AKP/termux0.103.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/trueDT/peer/Sync.BetaUsers/termux0.103"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Thu Dec 10 02:38:32 GMT 2020
apkName="termux0.103"
app="com.termux"
versionNameOnline="Thu Dec 10 02:35:32 GMT 2020"
SourcePack="/data/trueDT/peer/Sync.BetaUsers/termux0.103/DTF/termux0.103.DTF"
excludeListPack "/data/trueDT/peer/Sync.BetaUsers/termux0.103"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.termux/Thu Dec 10 02:35:32 GMT 2020" ] ; then
    pm clear com.termux
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
# necessário permissao root na pasta home para acessar via ssh no winscp
chown root:root -R /data/data/com.termux/files/home

    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.termux-*/lib/arm /data/data/com.termux/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop=""
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.termux/Thu Dec 10 02:35:32 GMT 2020"
fi
###################################################################################
# config forçada para rodar sempre no boot

