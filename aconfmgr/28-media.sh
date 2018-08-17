# shellcheck disable=SC2148
AddPackage alsa-utils # An alternative implementation of Linux sound support
AddPackage gimp # GNU Image Manipulation Program
AddPackage gst-libav # Gstreamer libav Plugin
AddPackage gst-plugins-bad # GStreamer Multimedia Framework Bad Plugins
AddPackage gst-plugins-ugly # GStreamer Multimedia Framework Ugly Plugins
AddPackage jpegoptim # Jpeg optimisation utility
AddPackage handbrake # Multithreaded video transcoder
AddPackage inkscape # Professional vector graphics editor
AddPackage libdvdcss # Portable abstraction library for DVD decryption
AddPackage openshot # an open-source, non-linear video editor for Linux based on MLT framework
AddPackage optipng # Compresses PNG files to a smaller size, without losing any information.
AddPackage pavucontrol # PulseAudio Volume Control
AddPackage pulseaudio # A featureful, general-purpose sound server
AddPackage simplescreenrecorder # A feature-rich screen recorder that supports X11 and OpenGL.
AddPackage vlc # A multi-platform MPEG, VCD/DVD, and DivX player
AddPackage qt4 # vlc opt dep

CreateLink /etc/systemd/user/sockets.target.wants/pipewire.socket /usr/lib/systemd/user/pipewire.socket
CreateLink /etc/systemd/user/sockets.target.wants/pulseaudio.socket /usr/lib/systemd/user/pulseaudio.socket

# AddPackage --foreign archlinux-artwork # Official logos, icons, CD labels and other artwork for Arch Linux

