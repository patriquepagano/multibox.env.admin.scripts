#!/system/bin/sh

file="$HOME/.ssh/known_hosts"
if [ ! -f "$file.bkp" ]; then
    cp $file $file.bkp
fi
cat $file
 
 

