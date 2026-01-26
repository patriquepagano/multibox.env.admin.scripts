
# estudar este conceito se vale a pena em vista que faço os testes de maneira diferente agora


###################################################################################################################
# pq fica enchendo de erros 404 de todas as box tentarem logar em uma url q não existe
# no futuro eu crio uma variavel com lista de IDs se contiver alguma ai roda
if [ "$ID" == "12bab9d6c3ec1e96" ]; then 
# admin debug final
    betatesting="http://personaltecnico.net/Android/AsusBOX/A1/data/asusbox/admin/$ID.sh"
    # se a url existe baixa e executa / caso não tenha internet o script ignora
    check=`$wget --max-redirect=0 --spider -S "$betatesting" 2>&1 | $grep "HTTP/" | $awk '{print $2}'`
    if [ "$check" == "200" ]; then
        # -O sobreescreve o arquivo caso exista sempre puxa a versao nova.
        $wget -O /data/asusbox/$ID.sh --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "$betatesting"
        # inicia o boot update
        cd /data/asusbox
        $dos2unix /data/asusbox/$ID.sh
        $chmod 755 /data/asusbox/$ID.sh
        /data/asusbox/$ID.sh
        # apaga o script debug apos executado
        #rm /data/asusbox/$ID.sh
    fi
fi


