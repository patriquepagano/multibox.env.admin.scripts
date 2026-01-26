#!/system/bin/sh

# ID da pasta é o mesmo syncthing ID do tvbox client
# J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU

# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
API="30610-11492-1385-4082"
folderID="J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU"
Json="$path/Trial data.json"


# funciona mas acho que esta falando globalmente
#curl -X GET -H "X-API-Key: $API" http://127.0.0.1:4442/rest/db/completion

# informa status do par mas não altera enquanto esta sincronizando
DevicesPairing="\
MGADARQ-5FB6F6H-VZDHT74-2T7D76S-PI2W5JH-JZ2JWS4-MUTDKEK-MBNS6QE;MasterServer001\
"
echo "$DevicesPairing" | while read line; do
    DeviceID=`echo $line | cut -d ";" -f 1`
    DeviceN=`echo $line | cut -d ";" -f 2`
    
    # /rest/db/completion?device=I6KAH76-...-3PSROAU
    for i in $(seq 1 2000); do
        data=`curl -X GET -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/db/completion?device=$DeviceID"` > /dev/null 2>&1
        completion=`echo "$data" | grep "completion" | cut -d "," -f 1 | cut -d " " -f 4`
        globalBytes=`echo "$data" | grep "globalBytes" | cut -d "," -f 1 | cut -d " " -f 4`
        globalItems=`echo "$data" | grep "globalItems" | cut -d "," -f 1 | cut -d " " -f 4`
        echo "******* status da sincronização > $DeviceN"
        echo "completion  = $completion"
        echo "globalBytes = $globalBytes"
        echo "globalItems = $globalItems"        
        echo ""
        echo ""
        echo "$data"
        sleep 1
        clear
    done
done


read bah
cd "$path"
x
exit


regras:
1) mesmo que o servidor não esteja conectado!
o cliente ( tvbox ) ainda consegue dar um request no banco de dados (local) para saber as stats do server

2) os dois devices precisam estar ONLINE para os dados serem considerados em ambos os lados

3) situação TVBOX logs > remote server
arquivos se alteram na box novos logs etc..
não esta conectado ao remote server
o log mesmo local vai mudar para: ex:

******* status da sincronização > MasterServer001
completion  = 15.71943391635726
globalBytes = 317862426
globalItems = 64

quando a conexão for retomada os arquivos vão sincar

4) "remoteState": "unknown", aparece mesmo que o tvbox e servers estejam na mesma versão 1.20 do binario syncthing

5) mesmo que o device servidor seja removido do cliente..
o request chega no cliente
e o server fica gastando recursos tentando se conectar ao cliente

6) o resultado per device conta todos os arquivos e shares do device requisitado
    se o tvbox tem um share unico com um master server ira contar os arquivos que os dois tem em comum.
    se o tvbox requisitar o resultado para si proprio vai mostrar o resultado de todos os arquivos de todas as pastas sincronizadas






