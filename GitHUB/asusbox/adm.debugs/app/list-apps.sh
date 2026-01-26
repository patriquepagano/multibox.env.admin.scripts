#!/system/bin/sh

pm list packages -3 | sed -e 's/.*://' | sort




