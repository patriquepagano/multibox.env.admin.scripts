#!/system/bin/sh

DEVIDS="
7EVU6NI-6X2PZT5-NQVIOJS-DC7SQLW-YJC47UI-HGPJL64-5MUCLBF-AI7N6QA
77WKN25-FND3PG5-QV2C2JR-PJHANEX-FRQYNR3-UZNYORL-J5EQST4-QCRMOQE
3YUUAFU-5YCF36I-VY3GFJA-63CMCCO-RLJZHGN-3I6WFUN-TCUWFGX-R4RY6AJ
EAHJXOP-JNU3H5T-Y6ELKOC-HVRBFQI-QE6TAX4-6HIEAUM-XEMJ3UD-BXVZPAB
QKPRNK5-PXUXYNZ-6EK5G6F-ZHBWDX6-RI4ZDBW-YUN6ZUR-7IK57J4-4FTLFAF
XOIOPS4-L5D4QNW-WVAREQ3-6LHVRIG-HFVHONX-Y4I74VD-QQJCN6N-TBH5PA2
VOWUQVV-UJ2AYUU-B2AL3US-6VP6PRB-RFNJGRU-JHLZU26-S5G6OE2-WLCUTQZ
AUSUVLE-VETFTQ3-IULM4WU-VRBWYTX-7B7JFCH-FW2FYY3-VJ6XWOG-CXQERAR
KTE2YT6-WW6FQ3Y-QBH3BZX-OZVVNCU-4WB7UPT-GB2XLE7-RB6L4BH-4PLOHQK
MFAHXVI-PNOQRVD-N4YLJDU-RDTXIBU-IYOZDRJ-P2YYYH6-FG4NMJG-WGMW4A3
FWLG3TH-I6QNZVK-ZQ5TFQF-ZHT45B6-KVLHU2B-XIHDXNE-CN5E3IA-24ULFQV
YI3FCTF-BXJH42A-7TJN3KQ-K4FH5MQ-AMO6UTA-BNWVB5S-NPYEDOK-J27JKQU
BYNWY7F-IUIRGZO-HP2LQKR-477JZRS-7ODP7MT-VYYYL26-A5JQ2Z2-SG6S5A7
ZGNGSKV-KT7EX4S-HBCR2X3-3H7AUZP-ITCSHIO-UJUZD5O-ZPZ2QRJ-RJ7GYQN
IXA2FA4-TZXUGBD-GP6HSAO-IIATRAC-S3IR6OC-M22UL4D-KETX523-LCYI5QD
EXIESFG-EASODZB-JGCJTZ3-NKJARPO-DGFAMCO-KO3KLDS-OQHSFM5-JEXBTA6
GNYY4XQ-PEXVTKF-KEGXCC4-HIUZM6J-YNEUJBW-KREHXA5-WXWJFQL-RSF62QA
AXC6KVA-A5EZPUN-BJUPYB4-7DX4H7L-4OHMDHA-FRJKZKE-SWDDKMF-67FQPA5
3W2KKIX-CXHE7JE-45ZAIHW-RYLWCFU-7IO7KSV-7NVN5IZ-HUCA5LH-KN6WPQS
4Y6VKGS-XMKM4MC-IQKNVBY-NYQRBJV-KJUBHWM-ZKSA4TA-TFMAVFI-CECQ5AZ
5BZCMLU-LE7GVUQ-DM4RA5W-QUAX2MI-GQV7MDG-22K3F7G-6GTDSWD-BNDVFQX
3G2MAOX-VXRYOGV-QAJ7SAN-G2UCRW7-26BN6S3-S6HFVLE-PTEGDLN-MPE3GA6
2OTI3SP-7OGQEYP-2RDPM4H-HKSPITH-HWOFBJ2-M2KRXZI-SONO5NF-3F2QNAS
TMZCOIK-FKLILO2-NUAINIO-BSDJVXK-MHPALTI-257NK6N-7X4XU3Y-JHSPQAW
QRM4N6H-CWQANI2-UQUMBU7-23M6KXF-YRN26FS-MJ6HYAT-O66PXRO-LVDBBA5
R2HEZLW-VIMUKKJ-FW2MO77-XKL5P2M-GEV4KJF-F2AXGRL-FVQFO2D-B3WN4QQ
"

rm /data/asusbox/try.xml


# share folder
cat <<EOF >> /data/asusbox/try.xml
    <folder id="xdnvv-cpbdi" label="ASUSBOX" path="D:\Sync\ASUSBOX" type="sendreceive" rescanIntervalS="60" fsWatcherEnabled="false" fsWatcherDelayS="10" ignorePerms="true" autoNormalize="true">
        <filesystemType>basic</filesystemType>     
EOF
# ids
for loop in $DEVIDS; do
cat <<EOF >> /data/asusbox/try.xml
        <device id="$loop" introducedBy=""></device>
EOF
done
# end config
cat <<EOF >> /data/asusbox/try.xml
        <minDiskFree unit="%">1</minDiskFree>
        <versioning></versioning>
        <copiers>0</copiers>
        <pullerMaxPendingKiB>0</pullerMaxPendingKiB>
        <hashers>0</hashers>
        <order>smallestFirst</order>
        <ignoreDelete>false</ignoreDelete>
        <scanProgressIntervalS>0</scanProgressIntervalS>
        <pullerPauseS>0</pullerPauseS>
        <maxConflicts>10</maxConflicts>
        <disableSparseFiles>false</disableSparseFiles>
        <disableTempIndexes>false</disableTempIndexes>
        <paused>false</paused>
        <weakHashThresholdPct>25</weakHashThresholdPct>
        <markerName>.stfolder</markerName>
        <copyOwnershipFromParent>false</copyOwnershipFromParent>
        <modTimeWindowS>0</modTimeWindowS>
    </folder>
EOF



for loop in $DEVIDS; do
name=`echo $loop | cut -c 41-`
cat <<EOF >> /data/asusbox/try.xml
    <device id="$loop" name="$name" compression="metadata" introducer="false" skipIntroductionRemovals="false" introducedBy="">
        <address>dynamic</address>
        <paused>false</paused>
        <autoAcceptFolders>false</autoAcceptFolders>
        <maxSendKbps>0</maxSendKbps>
        <maxRecvKbps>0</maxRecvKbps>
        <maxRequestKiB>0</maxRequestKiB>
    </device>
EOF
#echo $loop
done







exit

/data/asusbox/debug.sh

