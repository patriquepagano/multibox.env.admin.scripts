
# monstra a contagem final de tempo 
duration=$SECONDS
#echo "<h3>$(($duration / 60)) minutos e $(($duration % 60)) segundos para concluir inicialização e atualização completa.</h3>" >> $bootLog 2>&1

echo "$(($duration / 60)) minutos e $(($duration % 60)) segundos para concluir." > $bootLog 2>&1
echo "Inicialização e atualização completa." >> $bootLog 2>&1



