# shellcheck disable=SC2148
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