AddPackage asciinema  # Record and share terminal sessions
AddPackage jpegoptim  # Jpeg optimisation utility
AddPackage optipng    # Compresses PNG files to a smaller size, without losing any information.
AddPackage svgcleaner # An application that cleans svg images from unnecessary data in batch mode.

if grep -v -q microsoft /proc/version; then
	AddPackage alsa-utils               # An alternative implementation of Linux sound support
	AddPackage audacity                 # A program that lets you manipulate digital audio waveforms
	AddPackage gifsicle                 # A powerful command-line program for creating, editing, manipulating and getting information about GIF images and animations
	AddPackage gimp                     # GNU Image Manipulation Program
	AddPackage gst-libav                # Gstreamer libav Plugin
	AddPackage gst-plugins-bad          # GStreamer Multimedia Framework Bad Plugins
	AddPackage gst-plugins-ugly         # GStreamer Multimedia Framework Ugly Plugins
	AddPackage handbrake                # Multithreaded video transcoder
	AddPackage inkscape                 # Professional vector graphics editor
	AddPackage libdvdcss                # Portable abstraction library for DVD decryption
	AddPackage openshot                 # an open-source, non-linear video editor for Linux based on MLT framework
	AddPackage pavucontrol              # PulseAudio Volume Control
	AddPackage pulseaudio               # A featureful, general-purpose sound server
	AddPackage vlc                      # A multi-platform MPEG, VCD/DVD, and DivX player
	AddPackage --foreign wlstreamer-git # Wrapper around wf-recorder and ffmpeg that automatically switches the screen being recorded based on current window focus. Works with sway.

	CopyFile /etc/pulse/default.pa
	CreateLink /etc/systemd/user/sockets.target.wants/pipewire.socket /usr/lib/systemd/user/pipewire.socket
	CreateLink /etc/systemd/user/sockets.target.wants/pulseaudio.socket /usr/lib/systemd/user/pulseaudio.socket
fi
