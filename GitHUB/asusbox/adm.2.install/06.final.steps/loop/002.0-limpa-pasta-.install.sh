
echo "Limpando pastas cache" > $bootLog 2>&1

# echo "ADM DEBUG ### Lembre-se este é o metodo de limpeza antigo!
# cada ficha tecnica posta seu arquivo na lista excludePack
# /data/local/tmp/PackList no final ele roda este script para limpar
# mas ATUALMENTE O BOOT DO SEEDBOX JÁ FAZ ISTO"


# echo "apagar diretorios em branco"
# for i in $(seq 1 7); do
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### Limpando a pastas vazias em .install"
#     /system/bin/busybox find "/data/asusbox/.install/" -type d -exec /system/bin/busybox rmdir {} + 2>/dev/null
# done




# echo "# arguments called with ---->  ${@}     "
# echo "# \$1 ---------------------->  $1       "
# echo "# \$2 ---------------------->  $2       "
# echo "# path to me --------------->  ${0}     "
# echo "# parent path -------------->  ${0%/*}  "
# echo "# my name ------------------>  ${0##*/} "

