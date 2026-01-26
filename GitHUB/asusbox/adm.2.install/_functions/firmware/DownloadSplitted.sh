function DownloadSplitted () {
echo "Iniciando download $apkName "> $bootLog 2>&1
FechaAria
/system/bin/aria2c \
--check-certificate=false \
--show-console-readout=false \
--always-resume=true \
--allow-overwrite=true \
--summary-interval=10 \
--console-log-level=error \
--file-allocation=none \
--input-file=/data/local/tmp/url.list \
-d $InstallDir | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
echo "Download Concluido!" > $bootLog 2>&1
}

