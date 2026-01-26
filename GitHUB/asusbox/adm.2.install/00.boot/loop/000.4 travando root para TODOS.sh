


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### BLOQUEANDO O ACESSO ROOT"
checkPin=`/system/bin/busybox cat /system/.pin`
if [ ! "$checkPin" = "FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd" ];then
    /system/bin/busybox mount -o remount,rw /system
    echo -n 'FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd' > /system/.pin
    chmod 644 /system/.pin
fi




