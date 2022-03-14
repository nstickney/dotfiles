if ! DetectWSL; then          # No GUI in WSL
	AddPackage sway              # Tiling Wayland compositor and replacement for the i3 window manager
	AddPackage swayidle          # Idle management daemon for Wayland
	AddPackage swaylock          # Screen locker for Wayland
	AddPackage --foreign waypipe # A proxy for Wayland protocol applications; like ssh -X
	AddPackage wmname            # A utility to set the name of your window manager

	AddPackage blueberry                       # Bluetooth configuration tool
	AddPackage mako                            # Lightweight notification daemon for Wayland
	AddPackage polkit-gnome                    # Legacy polkit authentication agent for GNOME
	AddPackage python-i3ipc                    # An improved Python library to control i3wm
	AddPackage --foreign sway-launcher-desktop # TUI Application launcher with Desktop Entry support.
	AddPackage waybar                          # Highly customizable Wayland bar for Sway and Wlroots based compositors
	AddPackage otf-font-awesome                # OPTIONAL DEPENDENCY (waybar)
	AddPackage --foreign wdisplays-git         # GUI display configurator for wlroots compositors
	AddPackage wf-recorder                     # Screen recorder for wlroots-based compositors such as sway
	AddPackage --foreign wlstreamer-git        # Wrapper around wf-recorder and ffmpeg that automatically switches the screen being recorded based on current window focus. Works with sway.
	AddPackage wl-clipboard                    # Command-line copy/paste utilities for Wayland
	AddPackage xdg-desktop-portal-wlr          # xdg-desktop-portal backend for wlroots

	CopyFile /etc/systemd/user/sway-gsd-rfkill.service 755

	sway_bin="$(GetPackageOriginalFile sway /usr/share/wayland-sessions/sway.desktop)"
	sed -i 's|Exec=.*|Exec=/bin/sh -l -c sway|' "$sway_bin"
fi
