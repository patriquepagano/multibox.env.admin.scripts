#!/system/bin/sh

# pkg files bash
clear
Dir=$(dirname $0)
source $Dir/_function.sh

export pack="bash"
export cmd="
SHELL=/system/usr/bin/bash
HOME=/data/asusbox
PWD=/data/asusbox
TERM=xterm-256color
PS1=\"$(whoami):$(pwd)/ :)\"
/system/usr/bin/bash --version
#env

"
cat << EOF > "$Dir/$pack.FileList"
/data/data/com.termux/files/usr/lib/bash
/data/data/com.termux/files/usr/lib/bash/head
/data/data/com.termux/files/usr/lib/bash/logname
/data/data/com.termux/files/usr/lib/bash/tee
/data/data/com.termux/files/usr/lib/bash/unlink
/data/data/com.termux/files/usr/lib/bash/Makefile.inc
/data/data/com.termux/files/usr/lib/bash/basename
/data/data/com.termux/files/usr/lib/bash/tty
/data/data/com.termux/files/usr/lib/bash/realpath
/data/data/com.termux/files/usr/lib/bash/pathchk
/data/data/com.termux/files/usr/lib/bash/truefalse
/data/data/com.termux/files/usr/lib/bash/strftime
/data/data/com.termux/files/usr/lib/bash/uname
/data/data/com.termux/files/usr/lib/bash/sync
/data/data/com.termux/files/usr/lib/bash/fdflags
/data/data/com.termux/files/usr/lib/bash/whoami
/data/data/com.termux/files/usr/lib/bash/mypid
/data/data/com.termux/files/usr/lib/bash/finfo
/data/data/com.termux/files/usr/lib/bash/rmdir
/data/data/com.termux/files/usr/lib/bash/ln
/data/data/com.termux/files/usr/lib/bash/setpgid
/data/data/com.termux/files/usr/lib/bash/seq
/data/data/com.termux/files/usr/lib/bash/push
/data/data/com.termux/files/usr/lib/bash/sleep
/data/data/com.termux/files/usr/lib/bash/printenv
/data/data/com.termux/files/usr/lib/bash/id
/data/data/com.termux/files/usr/lib/bash/mkdir
/data/data/com.termux/files/usr/lib/bash/print
/data/data/com.termux/files/usr/lib/bash/loadables.h
/data/data/com.termux/files/usr/lib/bash/dirname
/data/data/com.termux/files/usr/lib/pkgconfig
/data/data/com.termux/files/usr/lib/pkgconfig/bash.pc
/data/data/com.termux/files/usr/bin
/data/data/com.termux/files/usr/bin/bash
/data/data/com.termux/files/usr/etc
/data/data/com.termux/files/usr/etc/profile
/data/data/com.termux/files/usr/etc/bash.bashrc
EOF

SyncGenerateList

DebugBINs

bkpBins

# clean
rm "$Dir/$pack.FileList" > /dev/null 2>&1



