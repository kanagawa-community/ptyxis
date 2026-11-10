# Window hook for .github/scripts/capture-windows.sh: Ptyxis runs the shared session
# from docs/PREVIEWS.md with each theme.
# Ptyxis draws its own header bar, so the frame has no title bar.
# Requires: ptyxis, fastfetch, eza.
# shellcheck shell=bash
name=Ptyxis
frame=plain

launch() {
  # Ptyxis reads its profile from GSettings: a key file in a throwaway folder
  # selects the palette, so your own settings are untouched.
  local home="$work/ptyxis-$1"
  mkdir -p "$home/config/glib-2.0/settings" "$home/data/org.gnome.Ptyxis/palettes"
  cp "$root/themes/kanagawa-$1.palette" "$home/data/org.gnome.Ptyxis/palettes/"
  printf "[org/gnome/Ptyxis]\ndefault-profile-uuid='kanagawa'\nprofile-uuids=['kanagawa']\nuse-system-font=false\nfont-name='%s 11'\nrestore-session=false\n[org/gnome/Ptyxis/Profiles/kanagawa]\npalette='kanagawa-%s'\n" \
    "$font" "$1" >"$home/config/glib-2.0/settings/keyfile"
  printf 'env GSETTINGS_BACKEND=keyfile XDG_CONFIG_HOME=%s XDG_DATA_HOME=%s ptyxis -s -T kanagawa -x "%s %s"' \
    "$home/config" "$home/data" "$session" "$1"
}
