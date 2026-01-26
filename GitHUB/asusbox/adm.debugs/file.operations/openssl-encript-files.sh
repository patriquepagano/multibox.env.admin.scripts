#!/system/bin/sh


# encript file
cat $file | openssl aes-128-cbc -pbkdf2 -salt -k "asd5f876a5dsf8765adf8765ads7f865asd78f65ad78s6f5s87a" > $file.enc


# decript arquivo
openssl aes-128-cbc -pbkdf2 -d -salt -in \
/data/asusbox/adm.2.install/boot.sh.enc \
-k "asd5f876a5dsf8765adf8765ads7f865asd78f65ad78s6f5s87a" > \
/data/asusbox/adm.2.install/boot.sh.enc.dec



