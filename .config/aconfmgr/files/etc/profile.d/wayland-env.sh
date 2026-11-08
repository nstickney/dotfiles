#!/bin/sh

# https://unix.stackexchange.com/a/669974
# https://github.com/systemd/systemd/issues/2356
if [ "$(loginctl show-session "$XDG_SESSION_ID" -p Type --value)" = wayland ]; then
	# https://github.com/swaywm/sway/wiki/Running-programs-natively-under-Wayland
	export MOZ_ENABLE_WAYLAND=1
	export XDG_SESSION_TYPE=wayland
	export QT_QPA_PLATFORM=wayland-egl
	export QT_WAYLAND_FORCE_DPI=physical
	export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
	export SDL_VIDEODRIVER=wayland
	export _JAVA_AWT_WM_NONREPARENTING=1

	# https://wiki.archlinux.org/title/PipeWire#xdg-desktop-portal-wlr
	# Only as a fallback (e.g. sway from a TTY): GDM already sets this from
	# the session's DesktopNames, and forcing "sway" under GNOME breaks
	# gnome-control-center and makes xdg-desktop-portal load the wlr backends.
	export XDG_CURRENT_DESKTOP="${XDG_CURRENT_DESKTOP:-sway}"
fi
