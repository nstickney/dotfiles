# shellcheck disable=SC2148
AddPackage alsa-utils # An alternative implementation of Linux sound support
AddPackage gst-libav # Gstreamer libav Plugin
AddPackage gst-plugins-bad # GStreamer Multimedia Framework Bad Plugins
AddPackage gst-plugins-ugly # GStreamer Multimedia Framework Ugly Plugins
AddPackage pavucontrol # PulseAudio Volume Control
AddPackage pulseaudio # A featureful, general-purpose sound server

CreateLink /etc/systemd/user/sockets.target.wants/pulseaudio.socket /usr/lib/systemd/user/pulseaudio.socket
