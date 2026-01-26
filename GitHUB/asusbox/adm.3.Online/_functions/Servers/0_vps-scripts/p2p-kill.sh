#!/bin/bash

transmission-remote --exit
killall transmission-daemon

sleep 3

sudo netstat -ntlup


# remove a crontab task job
crontab -u $(whoami) -l | grep -v '/SeedBOX/p2p-kill.sh'  | crontab -u $(whoami) -


# exit

# To add a job to crontab:

# (crontab -u mobman -l ; echo "*/5 * * * * perl /home/mobman/test.pl") | crontab -u mobman -
# To remove a job from crontab:

# crontab -u mobman -l | grep -v 'perl /home/mobman/test.pl'  | crontab -u mobman -
# Remove everything from crontab:

# crontab -r


# # tarefas do crontab   https://crontab.guru/every-5-minutes
# crontab -u $(whoami) -l # lista crontabs do user
# cd /SeedBOX
# crontab -l > mycron
# # echo new cron into cron file
# echo "*/30 * * * * /SeedBOX/p2p-kill.sh" > mycron # roda a cada 30 minuto
# echo "*/30 * * * * /SeedBOX/sdasdf.sh" >> mycron # roda a cada 30 minuto
# echo "*/30 * * * * /SeedBOX/234534253.sh" >> mycron # roda a cada 30 minuto
# crontab mycron # install new cron file
# crontab -u $(whoami) -l # lista crontabs do user


