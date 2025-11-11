if ! DetectWSL; then # No GUI in WSL

	AddPackage bitwarden         # A secure and free password manager for all of your devices.
	AddPackage cheese            #  	Take photos and videos with your webcam, with fun graphical effects
	AddPackage evince            # Document viewer (PDF, PostScript, XPS, djvu, dvi, tiff, cbr, cbz, cb7, cbt)
	AddPackage gnome-calculator  # GNOME Scientific calculator
	AddPackage gnome-characters  # A character map application
	AddPackage gnome-font-viewer # A font viewer utility for GNOME
	AddPackage solaar            # Linux device manager for a wide range of Logitech devices

	# 3D Modeling
	AddPackage leocad   # A CAD program for creating virtual LEGO models
	AddPackage openscad # The programmers solid 3D CAD modeller

	# Audio
	AddPackage audacity  # A program that lets you manipulate digital audio waveforms
	AddPackage rhythmbox # Music playback and management application

	# Bittorrent
	AddPackage qbittorrent # An advanced BitTorrent client programmed in C++, based on Qt toolkit and libtorrent-rasterbar

	# Books
	AddPackage calibre                      # Ebook management application
	CreateLink /usr/lib/calibre/bin bin-py3 # Use Python3 in calibre

	# Chat
	AddPackage --foreign discord_arch_electron # Discord (popular voice + video app) using system electron
	AddPackage signal-desktop                  # Signal Private Messenger for Linux
	AddPackage --foreign skypeforlinux-bin     # Skype for Linux - Stable/Release Version
	AddPackage teamspeak3                      # TeamSpeak is software for quality voice communication via the Internet

	# File management
	AddPackage nautilus                 # Default file manager for GNOME
	AddPackage nautilus-image-converter # Nautilus extension to rotate/resize image files
	AddPackage seahorse-nautilus        # PGP encryption and signing for nautilus
	AddPackage sushi                    # A quick previewer for Nautilus
	# AddPackage rmlint-shredder          # Graphical user interface for rmlint

	# Games
	AddPackage --foreign airshipper-git         # The official launcher for Veloren - an open-world, open-source multiplayer voxel RPG
	AddPackage --foreign amidst-git             # Advanced Minecraft Interface and Data/Structure Tracking
	AddPackage crawl-tiles                      # Dungeon Crawl Stone Soup: open-source, single-player, role-playing roguelike game of exploration and treasure-hunting (graphical version)
	AddPackage --foreign dwarffortress-ironhand # A single-player fantasy game in which you build a dwarven outpost or play an adventurer in a randomly generated world
	AddPackage --foreign dwarftherapist-git     # Heavily modified version of the original Dwarf Therapist.
	AddPackage freeciv                          # A multiuser clone of the famous Microprose game of Civilization
	AddPackage --foreign minecraft-launcher     # Official Minecraft Launcher
	CreateLink /opt/minecraft-launcher/swiftshader/libEGL.so /lib64/libEGL.so
	CreateLink /opt/minecraft-launcher/swiftshader/libGLESv2.so /lib64/libGLESv2.so
	AddPackage --foreign protontricks # A simple wrapper that does winetricks things for Proton enabled games.
	AddPackage steam                  # Valve's digital software delivery system
	AddPackage --foreign tome4        # An open-source, single-player, role-playing roguelike game set in the world of Eyal.

	# Images
	AddPackage eog         # Eye of Gnome
	AddPackage eog-plugins # Plugins for Eye of Gnome
	AddPackage gimp        # GNU Image Manipulation Program
	AddPackage inkscape    # Professional vector graphics editor

	# Java
	AddPackage jdk-openjdk # Get the latest java and use it.

	# Network
	AddPackage network-manager-applet # Applet for managing network connections
	AddPackage nm-connection-editor   # NetworkManager GUI connection editor and widgets
	AddPackage wireshark-qt           # Network traffic and protocol analyzer/sniffer - Qt GUI

	# Office suite
	AddPackage libreoffice-still # LibreOffice maintenance branch
	AddPackage coin-or-mp        # OPTIONAL DEPENDENCY (libreoffice-still)
	AddPackage gst-plugins-base  # OPTIONAL DEPENDENCY (libreoffice-still)
	AddPackage libmythes         # OPTIONAL DEPENDENCY (libreoffice-still)
	AddPackage libpaper          # OPTIONAL DEPENDENCY (libreoffice-still)
	AddPackage libwpg            # OPTIONAL DEPENDENCY (libreoffice-still)
	AddPackage pstoedit          # OPTIONAL DEPENDENCY (libreoffice-still)

	# Programming: Arduino
	AddPackage arduino-cli # Arduino command line interface

	# Programming: Reverse Engineering
	AddPackage ghidra # Software reverse engineering framework

	# Programming: VSCode
	AddPackage code            # The Open Source build of Visual Studio Code (vscode) editor
	AddPackage bash-completion # OPTIONAL DEPENDENCY (code)

	# Remote
	AddPackage remmina      # remote desktop client written in GTK+
	AddPackage freerdp      # remmina opt dep
	AddPackage libvncserver # remmina opt dep
	# AddPackage vinagre # A VNC Client for the GNOME desktop

	# Terminal emulator
	AddPackage alacritty # A cross-platform, GPU-accelerated terminal emulator
	AddPackage ncurses   # OPTIONAL DEPENDENCY (alacritty)

	# Video
	AddPackage handbrake  # Multithreaded video transcoder
	AddPackage obs-studio # Free, open source software for live streaming and recording
	AddPackage vlc        # Multi-platform MPEG, VCD/DVD, and DivX player
	# AddPackage --foreign openshot   # An award-winning free and open-source video editor

	# Web browser: Chrome
	AddPackage chromium                    # A web browser built for speed, simplicity, and security
	AddPackage --foreign chromium-widevine # A browser plugin designed for the viewing of premium video content
	AddPackage pipewire                    # OPTIONAL DEPENDENCY (chromium)

	# Web browser: Edge
	AddPackage --foreign microsoft-edge-stable-bin # A browser that combines a minimal design with sophisticated technology to make the web faster, safer, and easier
	AddPackage ttf-liberation                      # OPTIONAL DEPENDENCY (microsoft-edge-stable-bin)
	AddPackage xdg-utils                           # OPTIONAL DEPENDENCY (microsoft-edge-stable-bin)

	# Web browser: Firefox
	AddPackage firefox         # Standalone web browser from mozilla.org
	AddPackage hunspell-en_us  # OPTIONAL DEPENDENCY (firefox)
	AddPackage x11-ssh-askpass # OPTIONAL DEPENDENCY (code)
fi
