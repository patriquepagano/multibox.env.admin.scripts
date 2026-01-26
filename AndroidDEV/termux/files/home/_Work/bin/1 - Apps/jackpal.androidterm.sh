#!/system/bin/sh

echo "
1 ) desativar
2 ) ativar
"

read bah

if [ "$bah" == "1" ]; then
    pm disable jackpal.androidterm
fi

if [ "$bah" == "2" ]; then
    pm enable jackpal.androidterm
fi


