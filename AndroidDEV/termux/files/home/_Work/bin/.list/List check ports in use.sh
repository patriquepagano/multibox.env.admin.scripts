#!/system/bin/sh

netstat -ntlup

echo "comando fuser bom para descobrir qual processo, app esta rodando na porta citada"

# apps bloatware na box tomate
fuser -v -n tcp 39718
fuser -v -n tcp 38388
fuser -v -n tcp 38389

# generico servidor dns na box
fuser -v -n udp 5353


