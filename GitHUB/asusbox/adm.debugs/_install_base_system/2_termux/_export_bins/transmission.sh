#!/system/bin/sh
# pkg files transmission > log
clear
Dir=$(dirname $0)
source $Dir/_function.sh

export pack="transmission"
export cmd="/system/usr/bin/transmission-remote -V"
cat << EOF > "$Dir/$pack.FileList"
/data/data/com.termux/files/usr/bin
/data/data/com.termux/files/usr/bin/transmission-create
/data/data/com.termux/files/usr/bin/transmission-remote
/data/data/com.termux/files/usr/bin/transmission-edit
/data/data/com.termux/files/usr/bin/transmission-show
/data/data/com.termux/files/usr/bin/transmission-daemon
/data/data/com.termux/files/usr/share/transmission
/data/data/com.termux/files/usr/share/transmission/web
/data/data/com.termux/files/usr/share/transmission/web/images
/data/data/com.termux/files/usr/share/transmission/web/images/favicon.png
/data/data/com.termux/files/usr/share/transmission/web/images/favicon.ico
/data/data/com.termux/files/usr/share/transmission/web/images/webclip-icon.png
/data/data/com.termux/files/usr/share/transmission/web/index.html
/data/data/com.termux/files/usr/share/transmission/web/javascript
/data/data/com.termux/files/usr/share/transmission/web/javascript/main.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/transmission.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/torrent-row.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/notifications.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/torrent.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/remote.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/polyfill.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/prefs-dialog.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/dialog.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/common.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/jquery
/data/data/com.termux/files/usr/share/transmission/web/javascript/jquery/jquery-migrate.min.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/jquery/jquery.min.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/jquery/jquery-ui.min.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/jquery/json2.min.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/jquery/jquery.ui-contextmenu.min.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/jquery/jquery.transmenu.min.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/formatter.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/file-row.js
/data/data/com.termux/files/usr/share/transmission/web/javascript/inspector.js
/data/data/com.termux/files/usr/share/transmission/web/style
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images/ui-bg_glass_55_fbf9ee_1x400.png
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images/ui-bg_glass_75_e6e6e6_1x400.png
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images/ui-icons_2e83ff_256x240.png
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images/ui-icons_222222_256x240.png
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images/ui-bg_flat_75_ffffff_40x100.png
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images/ui-bg_glass_95_fef1ec_1x400.png
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images/ui-icons_cd0a0a_256x240.png
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images/ui-bg_highlight-soft_75_cccccc_1x100.png
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images/ui-icons_454545_256x240.png
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images/ui-bg_flat_0_aaaaaa_40x100.png
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images/ui-bg_glass_65_ffffff_1x400.png
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images/ui-bg_glass_75_dadada_1x400.png
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/images/ui-icons_888888_256x240.png
/data/data/com.termux/files/usr/share/transmission/web/style/jqueryui/jquery-ui.min.css
/data/data/com.termux/files/usr/share/transmission/web/style/transmission
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/arrow-up.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/wrench.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/toolbar-info.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/lock_icon.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/toolbar-pause.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/turtle.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/progress.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/settings.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/filter_bar.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/compact.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/toolbar-start-all.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/toolbar-pause-all.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/toolbar-folder.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/inspector-files.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/inspector-peers.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/inspector-info.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/buttons
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/buttons/torrent_buttons.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/toolbar-start.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/file-priority-normal.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/toolbar-close.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/blue-turtle.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/filter_icon.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/inspector-trackers.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/arrow-down.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/file-priority-high.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/logo.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/images/file-priority-low.png
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/mobile.css
/data/data/com.termux/files/usr/share/transmission/web/style/transmission/common.css
/data/data/com.termux/files/usr/lib/libminiupnpc.so
/data/data/com.termux/files/usr/lib/libevent-2.1.so
/data/data/com.termux/files/usr/lib/libcurl.so
/data/data/com.termux/files/usr/lib/libssl.so.1.1
/data/data/com.termux/files/usr/lib/libcrypto.so.1.1
/data/data/com.termux/files/usr/lib/libz.so.1
/data/data/com.termux/files/usr/lib/libz.so.1.2.11
/data/data/com.termux/files/usr/lib/libnghttp2.so
/data/data/com.termux/files/usr/lib/libssh2.so
EOF

SyncGenerateList

DebugBINs

bkpBins

# clean
rm "$Dir/$pack.FileList" > /dev/null 2>&1



