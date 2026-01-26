#!/system/bin/sh

busybox cat << EOF > "/storage/DevMount/.gitignore"
/TWRP

# files modificam sem importancia
/AndroidDEV/termux/files/home/.bash_history
/AndroidDEV/termux/files/home/.local/share/mc/history
/AndroidDEV/termux/files/home/_Work/bin/.apps/aapt apps lists.txt

# arquivos de configuração que precisa tirar do github
/data/data/com.termux/files/home/.ssh/known_hosts
/storage/DevMount/AndroidDEV/termux/files/home/.bashrc


# pastas para ignorar total
/4Android
/Android
/AndroidDEV/.stfolder
/AndroidDEV/bins
/AndroidDEV/termux/files/usr
/asusbox
/lost+found

# nem sei no que eu uso isto.. 
/RsyncFolder/personaltecnico.net
/RsyncFolder/piratebox/www/distros
/RsyncFolder/piratebox/www/hostFiles


EOF
cat "/storage/DevMount/.gitignore"









busybox cat << 'EOF' > "/storage/DevMount/AndroidDEV/termux/files/home/.bashrc"
#export PS1='$(whoami):$(pwd)/ :) '

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

export IP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -1`
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\h=\u@'"$IP"'\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]:) '

# envia o nome do terminal para o kde konsole
echo -ne "\033]30;tvbox-dev01=$(whoami)@$IP\007"

export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin:/data/data/com.termux/files/usr/bin:$HOME/_Work/bin

#export LD_LIBRARY_PATH=/system/lib64:/system/lib:/system/usr/lib

alias asus='cd /storage/DevMount/GitHUB/asusbox'
alias 700='sh "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.fileOperations/set permissions 700 env bins.sh"'
alias gd='cd /storage/DevMount'
alias gs='sh "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.gitdev/Git Status [ MultiBOX ].sh"'
alias gdown='sh "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.gitdev/DOWNLOAD = OverWrite [ MultiBOX ].sh"'
alias gup='sh "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.gitdev/UPDATE { push } [ MultiBOX ].sh"'

alias asd="echo aaaaaaaaaaaaaaaaaa"

EOF

cat "/storage/DevMount/AndroidDEV/termux/files/home/.bashrc"


read bah