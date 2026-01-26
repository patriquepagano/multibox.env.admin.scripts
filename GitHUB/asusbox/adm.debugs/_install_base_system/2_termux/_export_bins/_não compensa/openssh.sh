#!/system/bin/sh
# pkg files openssh
clear
Dir=$(dirname $0)
source $Dir/_function.sh

export pack="openssh"
export cmd="/data/data/com.termux/files/usr/bin/sftp --version"
export list="
/data/data/com.termux/files/usr/etc/ssh
/data/data/com.termux/files/usr/etc/ssh/moduli
/data/data/com.termux/files/usr/etc/ssh/sshd_config
/data/data/com.termux/files/usr/etc/ssh/ssh_config
/data/data/com.termux/files/usr/bin
/data/data/com.termux/files/usr/bin/sftpa
/data/data/com.termux/files/usr/bin/ssh
/data/data/com.termux/files/usr/bin/scp
/data/data/com.termux/files/usr/bin/sftp
/data/data/com.termux/files/usr/bin/ssh-add
/data/data/com.termux/files/usr/bin/sshd
/data/data/com.termux/files/usr/bin/ssh-keyscan
/data/data/com.termux/files/usr/bin/ssh-keygen
/data/data/com.termux/files/usr/bin/ssh-copy-id
/data/data/com.termux/files/usr/bin/source-ssh-agent
/data/data/com.termux/files/usr/bin/ssh-agent
/data/data/com.termux/files/usr/bin/ssha
/data/data/com.termux/files/usr/var
/data/data/com.termux/files/usr/var/run
/data/data/com.termux/files/usr/var/run/README.openssh
/data/data/com.termux/files/usr/var/service
/data/data/com.termux/files/usr/var/service/sshd
/data/data/com.termux/files/usr/var/service/sshd/run
/data/data/com.termux/files/usr/var/service/sshd/down
/data/data/com.termux/files/usr/var/service/sshd/log
/data/data/com.termux/files/usr/libexec
/data/data/com.termux/files/usr/libexec/ssh-sk-helper
/data/data/com.termux/files/usr/libexec/ssh-pkcs11-helper
/data/data/com.termux/files/usr/libexec/sftp-server
/data/data/com.termux/files/usr/libexec/ssh-keysign
/data/data/com.termux/files/usr/share
/data/data/com.termux/files/usr/share/doc
/data/data/com.termux/files/usr/share/doc/openssh
/data/data/com.termux/files/usr/share/doc/openssh/LICENSE
/data/data/com.termux/files/usr/share/man
/data/data/com.termux/files/usr/share/man/man1
/data/data/com.termux/files/usr/share/man/man1/sftp.1.gz
/data/data/com.termux/files/usr/share/man/man1/ssh-keygen.1.gz
/data/data/com.termux/files/usr/share/man/man1/ssh-keyscan.1.gz
/data/data/com.termux/files/usr/share/man/man1/ssh-add.1.gz
/data/data/com.termux/files/usr/share/man/man1/scp.1.gz
/data/data/com.termux/files/usr/share/man/man1/ssh-agent.1.gz
/data/data/com.termux/files/usr/share/man/man1/ssh.1.gz
/data/data/com.termux/files/usr/share/man/man5
/data/data/com.termux/files/usr/share/man/man5/ssh_config.5.gz
/data/data/com.termux/files/usr/share/man/man5/sshd_config.5.gz
/data/data/com.termux/files/usr/share/man/man5/moduli.5.gz
/data/data/com.termux/files/usr/share/man/man8
/data/data/com.termux/files/usr/share/man/man8/sshd.8.gz
/data/data/com.termux/files/usr/share/man/man8/ssh-sk-helper.8.gz
/data/data/com.termux/files/usr/share/man/man8/ssh-keysign.8.gz
/data/data/com.termux/files/usr/share/man/man8/ssh-pkcs11-helper.8.gz
/data/data/com.termux/files/usr/share/man/man8/sftp-server.8.gz
/data/data/com.termux/files/usr/var/service/sshd/log/run
"

# SyncGenerateList
# bkpBins

DebugBINs

