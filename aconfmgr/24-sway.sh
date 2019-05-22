# shellcheck disable=SC2148
if lspci -v | grep -q nvidia; then
	AddPackage arandr # Provide a simple visual front end for XRandR 1.2.
	AddPackage compton # X compositor that may fix tearing issues
	AddPackage feh # Fast and light imlib2-based image viewer
	AddPackage i3-gaps # A fork of i3wm tiling window manager with more features, including gaps
	AddPackage i3lock # An improved screenlocker based upon XCB and PAM
	# AddPackage i3-wm # An improved dynamic tiling window manager
	AddPackage imlib2 # Library that does image file loading and saving as well as rendering, manipulation, arbitrary polygon support
	AddPackage network-manager-applet # Applet for managing network connections
	AddPackage numlockx # Turns on the numlock key in X11
	AddPackage playerctl # mpris media player controller and lib for spotify, vlc, audacious, bmp, xmms2, and others.
	AddPackage polkit-gnome # Legacy polkit authentication agent for GNOME
	AddPackage rofi # Popup window switcher roughly based on superswitcher, requiring only xlib and xft
	AddPackage xautolock # An automatic X screen-locker/screen-saver
	AddPackage xdg-utils # Command line tools that assist applications with a variety of desktop integration tasks

	# AddPackage --foreign i3-gnome # Starts i3 inside a gnome session.
	AddPackage --foreign i3status-rust-git # Very resourcefriendly and feature-rich replacement for i3status, written in pure Rust
	AddPackage alsa-utils # Opt dep for i3status-rust-git
else
	AddPackage sway # Tiling Wayland compositor and replacement for the i3 window manager
	AddPackage swayidle # Idle management daemon for Wayland
	AddPackage swaylock # Screen locker for Wayland

	AddPackage grim # Screenshot utility that works under Wayland
	AddPackage slurp # Select a region in a Wayland compositor
	AddPackage playerctl # mpris media player controller and lib for spotify, vlc, audacious, bmp, xmms2, and others.
	AddPackage rofi # Popup window switcher roughly based on superswitcher, requiring only xlib and xft
	AddPackage xdg-utils # Command line tools that assist applications with a variety of desktop integration tasks

	AddPackage --foreign i3status-rust-git # Very resourcefriendly and feature-rich replacement for i3status, written in pure Rust
	AddPackage alsa-utils # Opt dep for i3status-rust-git
fi
