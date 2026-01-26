#!/system/bin/sh

if [ ! -f /data/data/com.termux/files/home/Git-asusbox ]; then
    ln -sf /storage/DevMount/GitHUB/asusbox /data/data/com.termux/files/home/Git-asusbox
fi
if [ ! -f /data/data/com.termux/files/home/4Android ]; then
    ln -sf /storage/DevMount/4Android /data/data/com.termux/files/home/4Android
fi
if [ ! -f /data/data/com.termux/files/home/AndroidDEV ]; then
    ln -sf /storage/DevMount/AndroidDEV /data/data/com.termux/files/home/AndroidDEV
fi

cat <<'EOF' > /data/data/com.termux/files/home/.bashrc
export PS1='$(whoami):$(pwd)/ :) '
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin:/data/data/com.termux/files/usr/bin:$HOME/_Work/bin
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
alias asus='cd /storage/DevMount/GitHUB/asusbox'
alias 700='/storage/DevMount/GitHUB/asusbox/adm.0.git/700.perms.sh'
alias tempo='/storage/DevMount/GitHUB/asusbox/adm.0.git/set-date-proxy.sh'
alias push='/storage/DevMount/GitHUB/asusbox/adm.0.git/push.sh'
alias status='/storage/DevMount/GitHUB/asusbox/adm.0.git/status.sh'
alias dbg='cd /data/debugtvbox'
EOF

source /data/data/com.termux/files/home/.bashrc





alias g='cd /storage/DevMount/GitHUB/asusbox/adm.0.git && ls -p | egrep -v /$ | sed "s;^;./;"'


export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/data/data/com.termux/files/usr/bin

