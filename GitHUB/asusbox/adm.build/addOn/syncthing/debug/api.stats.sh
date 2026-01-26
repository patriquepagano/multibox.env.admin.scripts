#!/system/bin/sh
source /data/.vars
export HOME=/data/debugtvbox/features/syncthing/config

apikey=`cat "$HOME/config.xml" | grep apikey | cut -d ">" -f 2 | cut -d "<" -f 1`

# tvbox asusbox share
check=`/system/bin/curl -H "X-API-Key: $apikey" http://127.0.0.1:8384/rest/db/status?folder=ihdz2-5gkda | grep "stateChanged" | cut -d '"' -f 4`
clear
echo $check

exit

a ideia seria o server gerar esta id de data de modificação e deixar online
o cron rodando a cada minuto verifica se syncou e as datas batem










https://www.mankier.com/7/syncthing-rest-api




# tvbox da sala
clear
/system/bin/curl -H "X-API-Key: JGCykVYycNTVLVi4ri3twTLGgw23nUND" http://127.0.0.1:8384/rest/db/status?folder=w7stm-nnddd #| grep "stateChanged"










http://127.0.0.1:8384/rest/system/config
mostra todas as configs do user


/rest/db/completion
{
  "completion": 0,
  "globalBytes": 0,
  "needBytes": 0,
  "needDeletes": 0,
  "needItems": 0
}



/system/bin/curl -H "X-API-Key: TiadMvj7aQmJeWU7bxhTukpeD7keSpgM" http://127.0.0.1:8384/rest/system/status
{
  "alloc": 20959112,
  "connectionServiceStatus": {
    "dynamic+https://relays.syncthing.net/endpoint": {
      "error": null,
      "lanAddresses": [
        "relay://213.108.105.162:22067/?id=V4UDWLI-DQGBDON-KVCF5WL-67YV3IJ-LWKCYKK-VL7232E-63Z2IES-RENVOAJ\u0026pingInterval=1m0s\u0026networkTimeout=2m0s\u0026sessionLimitBps=0\u0026globalLimitBps=0\u0026statusAddr=:22070\u0026providedBy="
      ],
      "wanAddresses": [
        "relay://213.108.105.162:22067/?id=V4UDWLI-DQGBDON-KVCF5WL-67YV3IJ-LWKCYKK-VL7232E-63Z2IES-RENVOAJ\u0026pingInterval=1m0s\u0026networkTimeout=2m0s\u0026sessionLimitBps=0\u0026globalLimitBps=0\u0026statusAddr=:22070\u0026providedBy="
      ]
    },
    "quic://0.0.0.0:22000": {
      "error": null,
      "lanAddresses": [
        "quic://0.0.0.0:22000"
      ],
      "wanAddresses": [
        "quic://0.0.0.0:22000",
        "quic://186.208.147.64:22000"
      ]
    },
    "tcp://0.0.0.0:22000": {
      "error": null,
      "lanAddresses": [
        "tcp://0.0.0.0:22000"
      ],
      "wanAddresses": [
        "tcp://0.0.0.0:22000"
      ]
    }
  },
  "cpuPercent": 0.00006129758331651885,
  "discoveryEnabled": true,
  "discoveryErrors": {
    "global@https://discovery-v6.syncthing.net/v2/": "Post https://discovery-v6.syncthing.net/v2/: dial tcp [2a03:b0c0:0:1010::bb:4001]:443: connect: network is unreachable"
  },
  "discoveryMethods": 5,
  "goroutines": 88,
  "guiAddressOverridden": false,
  "guiAddressUsed": "[::]:8384",
  "lastDialStatus": {},
  "myID": "WRKR77N-J2ZBJD2-Z7ARALX-3EL33Z4-YBGNNIN-TTUBY2N-UNVTV2F-YWIM2AP",
  "pathSeparator": "/",
  "startTime": "2020-03-13T15:37:18.646343Z",
  "sys": 34643068,
  "tilde": "/data/asusbox/sync",
  "uptime": 10014,
  "urVersionMax": 3
}



#   To use an API key, set the request header X-API-Key to the API key value. 
# For example, curl -X POST -H "X-API-Key: abc123" http://localhost:8384/rest/... can be used to invoke with curl.


REST API
Syncthing exposes a REST interface over HTTP on the GUI port. 
This is used by the GUI (from Javascript) and can be used by other processes wishing to control Syncthing. 
In most cases both the input and output data is in JSON format. The interface is subject to change.

API Key
To use the REST API an API key must be set and used. 
The API key can be generated in the GUI, or set in the configuration/gui/apikey element in the configuration file. 
To use an API key, set the request header X-API-Key to the API key value. For example, 
curl -X POST -H "X-API-Key: abc123" http://localhost:8384/rest/... 
can be used to invoke with curl (add -k flag when using HTTPS with a Syncthing generated or self signed certificate).




/system/bin/curl -X POST -H "X-API-Key: TiadMvj7aQmJeWU7bxhTukpeD7keSpgM" http://127.0.0.1:8384/rest/stats/folder
404 page not found



/system/bin/curl -s http://localhost:8384/rest/stats/folder | json


/system/bin/curl -s http://localhost:8384/rest/stats/folder
CSRF Error



https://docs.syncthing.net/dev/rest.html


https://docs.syncthing.net/rest/stats-folder-get.html


curl -s http://localhost:8384/rest/stats/folder