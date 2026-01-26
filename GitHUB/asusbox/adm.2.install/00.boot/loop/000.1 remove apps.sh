

# English comment: Packages to remove
PACKAGES="
org.xbmc.kodi
com.stremio.one
"

# English comment: Uninstall packages (ignore errors if not installed)
for PKG in $PACKAGES; do
  pm uninstall --user 0 "$PKG" >/dev/null 2>&1
done



