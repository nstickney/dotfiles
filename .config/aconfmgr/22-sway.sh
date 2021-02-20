if grep -v -q microsoft /proc/version; then
	AddPackage sway     # Tiling Wayland compositor and replacement for the i3 window manager
	AddPackage swayidle # Idle management daemon for Wayland
	AddPackage swaylock # Screen locker for Wayland
	AddPackage wmname   # A utility to set the name of your window manager

	AddPackage alacritty                       # A cross-platform, GPU-accelerated terminal emulator
	AddPackage grim                            # Screenshot utility that works under Wayland
	AddPackage glfw-wayland                    # A free, open source, portable framework for graphical application development (wayland)
	AddPackage imv                             # Image viewer for Wayland and X11
	AddPackage mako                            # Lightweight notification daemon for Wayland
	AddPackage --foreign mpvpaper-git          # A video wallpaper program for wlroots based wayland compositors.
	AddPackage pacman-contrib                  # used in i3status-rust-git config
	AddPackage playerctl                       # mpris media player controller and lib for spotify, vlc, audacious, bmp, xmms2, and others.
	AddPackage python-i3ipc                    # An improved Python library to control i3wm
	AddPackage slurp                           # Select a region in a Wayland compositor
	AddPackage --foreign sway-launcher-desktop # TUI Application launcher with Desktop Entry support.
	AddPackage waybar                          # Highly customizable Wayland bar for Sway and Wlroots based compositors
	AddPackage --foreign wdisplays-git         # GUI display configurator for wlroots compositors
	AddPackage --foreign wev-git               # Print wayland events, like xev(1)
	AddPackage wl-clipboard                    # Command-line copy/paste utilities for Wayland
	AddPackage wf-recorder                     # Screen recorder for wlroots-based compositors such as sway
	AddPackage --foreign wlsunset-git          # Day/night gamma adjustments for Wayland
	AddPackage xdg-desktop-portal-wlr          # xdg-desktop-portal backend for wlroots
	AddPackage xdg-utils                       # Command line tools that assist applications with a variety of desktop integration tasks
fi
