#!/system/bin/sh
# precisa rodar via sshdroid
clear
Dir=$(dirname $0)
source $Dir/_function.sh

export pack="openssh-libs"
export list="
/data/data/com.termux/files/usr/lib/libldns.so
/data/data/com.termux/files/usr/lib/libgssapi_krb5.so.2
/data/data/com.termux/files/usr/lib/libgssapi_krb5.so.2.2
/data/data/com.termux/files/usr/lib/libkrb5.so.3
/data/data/com.termux/files/usr/lib/libkrb5.so.3.3
/data/data/com.termux/files/usr/lib/libk5crypto.so.3
/data/data/com.termux/files/usr/lib/libk5crypto.so.3.1
/data/data/com.termux/files/usr/lib/libcom_err.so.3
/data/data/com.termux/files/usr/lib/libcom_err.so.3.0
/data/data/com.termux/files/usr/lib/libkrb5support.so
/data/data/com.termux/files/usr/lib/libkrb5support.so.0
/data/data/com.termux/files/usr/lib/libkrb5support.so.0.1
/data/data/com.termux/files/usr/lib/libedit.so
"

SyncGenerateList

bkpBins





