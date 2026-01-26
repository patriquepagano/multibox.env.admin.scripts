#!/system/bin/sh

path="/data/asusbox"

# compactando
Files="
/data/data/com.termux/files/home/.ssh
/data/data/com.termux/files/usr/etc/ssh
"
/system/bin/busybox tar -czvf /storage/0EED-98EA/4Android/.install_DEV/.ssh.tar.gz $Files


# compactando
Files="
/data/asusbox/.git/
/data/asusbox/adm.0.git/
/data/asusbox/adm.1.export/
/data/asusbox/adm.2.install/
/data/asusbox/adm.3.OnlineUpdate/
/data/asusbox/adm.build/
/data/asusbox/adm.debugs/
/data/asusbox/.gitconfig
/data/asusbox/.git-credentials
/data/asusbox/.gitignore
/data/asusbox/commit.log
/data/asusbox/README.md
"
/system/bin/busybox tar -czvf /storage/0EED-98EA/4Android/.install_DEV/asusboxGit.tar.gz $Files

