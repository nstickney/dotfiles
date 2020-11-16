AddPackage alsa-utils # An alternative implementation of Linux sound support
AddPackage asciinema # Record and share terminal sessions
AddPackage audacity # A program that lets you manipulate digital audio waveforms
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
AddPackage svgcleaner # An application that cleans svg images from unnecessary data in batch mode.
AddPackage vlc # A multi-platform MPEG, VCD/DVD, and DivX player

CopyFile /etc/pulse/default.pa
CreateLink /etc/systemd/user/sockets.target.wants/pipewire.socket /usr/lib/systemd/user/pipewire.socket
CreateLink /etc/systemd/user/sockets.target.wants/pulseaudio.socket /usr/lib/systemd/user/pulseaudio.socket
