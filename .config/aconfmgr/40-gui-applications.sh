if ! DetectWSL; then # No GUI in WSL

	AddPackage rhythmbox  # Music playback and management application
	AddPackage solaar     # Linux device manager for a wide range of Logitech devices
	AddPackage stellarium # A stellarium with great graphics and a nice database of sky-objects

	# 3D Modeling
	AddPackage --foreign leocad # A CAD program for creating virtual LEGO models
	AddPackage openscad         # The programmers solid 3D CAD modeller

	# Audio editing
	AddPackage audacity # A program that lets you manipulate digital audio waveforms

	# Books
	AddPackage calibre                      # Ebook management application
	CreateLink /usr/lib/calibre/bin bin-py3 # Use Python3 in calibre

	# Calculator
	AddPackage gnome-calculator # GNOME Scientific calculator

	# Character Map
	AddPackage gnome-characters # A character map application

	# Chat
	AddPackage --foreign discord_arch_electron    # Discord (popular voice + video app) using the system provided electron for increased security and performance
	AddPackage signal-desktop                     # Signal Private Messenger for Linux
	AddPackage --foreign skypeforlinux-stable-bin # Skype for Linux - Stable/Release Version
	AddPackage --foreign teams                    # Microsoft Teams for Linux is your chat-centered workspace in Office 365

	# Credential management
	AddPackage --foreign bitwarden-bin # A secure and free password manager for all of your devices.

	# Document viewer
	AddPackage evince # Document viewer (PDF, PostScript, XPS, djvu, dvi, tiff, cbr, cbz, cb7, cbt)

	# File management
	AddPackage nautilus                 # Default file manager for GNOME
	AddPackage nautilus-image-converter # Nautilus extension to rotate/resize image files
	AddPackage seahorse-nautilus        # PGP encryption and signing for nautilus
	AddPackage sushi                    # A quick previewer for Nautilus
	AddPackage rmlint-shredder          # Graphical user interface for rmlint

	# Fonts
	AddPackage gnome-font-viewer # A font viewer utility for GNOME

	# Games
	AddPackage --foreign airshipper-git         # The official launcher for Veloren - an open-world, open-source multiplayer voxel RPG
	AddPackage --foreign amidst-git             # Advanced Minecraft Interface and Data/Structure Tracking
	AddPackage --foreign dwarffortress-ironhand # A single-player fantasy game in which you build a dwarven outpost or play an adventurer in a randomly generated world
	AddPackage --foreign dwarftherapist-git     # Heavily modified version of the original Dwarf Therapist.
	AddPackage freeciv                          # A multiuser clone of the famous Microprose game of Civilization
	AddPackage --foreign minecraft-launcher     # Official Minecraft Launcher
	CreateLink /opt/minecraft-launcher/swiftshader/libEGL.so /lib64/libEGL.so
	CreateLink /opt/minecraft-launcher/swiftshader/libGLESv2.so /lib64/libGLESv2.so
	AddPackage steam                 # Valve's digital software delivery system
	AddPackage --foreign steam-fonts # Fonts to fix scrambled or missing text in steam menus
	AddPackage steam-native-runtime  # Native replacement for the Steam runtime using system libraries
	AddPackage stone-soup            # Open-source, single-player, role-playing roguelike game of exploration and treasure-hunting
	AddPackage --foreign tome4       # An open-source, single-player, role-playing roguelike game set in the world of Eyal.

	# Images
	AddPackage eog         # Eye of Gnome
	AddPackage eog-plugins # Plugins for Eye of Gnome
	AddPackage gimp        # GNU Image Manipulation Program
	AddPackage inkscape    # Professional vector graphics editor

	# Network
	AddPackage network-manager-applet # Applet for managing network connections
	AddPackage nm-connection-editor   # NetworkManager GUI connection editor and widgets
	AddPackage wireshark-qt           # Network traffic and protocol analyzer/sniffer - Qt GUI

	# Office suite
	AddPackage libreoffice-still # LibreOffice maintenance branch
	AddPackage coin-or-mp        # OPTIONAL DEPENDENCY (libreoffice-still)
	AddPackage gst-plugins-base  # OPTIONAL DEPENDENCY (libreoffice-still)
	AddPackage jdk11-openjdk     # OPTIONAL DEPENDENCY (libreoffice-still)
	AddPackage jre11-openjdk     # OPTIONAL DEPENDENCY (libreoffice-still)
	AddPackage libmythes         # OPTIONAL DEPENDENCY (libreoffice-still)
	AddPackage libpaper          # OPTIONAL DEPENDENCY (libreoffice-still)
	AddPackage libwpg            # OPTIONAL DEPENDENCY (libreoffice-still)
	AddPackage pstoedit          # OPTIONAL DEPENDENCY (libreoffice-still)

	# Programming: Arduino
	AddPackage arduino          # Arduino prototyping platform SDK
	AddPackage arduino-avr-core # OPTIONAL DEPENDENCY (arduino)

	# Programming: Reverse Engineering
	AddPackage ghidra # Software reverse engineering framework

	# Programming: VSCode
	AddPackage code            # The Open Source build of Visual Studio Code (vscode) editor
	AddPackage bash-completion # OPTIONAL DEPENDENCY (code)

	# Remote
	AddPackage remmina # remote desktop client written in GTK+
	AddPackage vinagre # A VNC Client for the GNOME desktop

	# Security
	AddPackage --foreign burpsuite # An integrated platform for performing security testing of web applications (free edition)

	# Terminal emulator
	AddPackage alacritty # A cross-platform, GPU-accelerated terminal emulator
	AddPackage ncurses   # OPTIONAL DEPENDENCY (alacritty)

	# Video
	AddPackage handbrake # Multithreaded video transcoder
	AddPackage openshot  # An award-winning free and open-source video editor
	AddPackage vlc       # Multi-platform MPEG, VCD/DVD, and DivX player

	# Web browser: Chrome
	AddPackage chromium                    # A web browser built for speed, simplicity, and security
	AddPackage --foreign chromium-widevine # A browser plugin designed for the viewing of premium video content
	AddPackage pipewire                    # OPTIONAL DEPENDENCY (chromium)

	# Web browser: Edge
	AddPackage --foreign microsoft-edge-dev-bin # A browser that combines a minimal design with sophisticated technology to make the web faster, safer, and easier
	AddPackage gtk3                             # OPTIONAL DEPENDENCY (microsoft-edge-dev-bin)
	AddPackage libpipewire02                    # OPTIONAL DEPENDENCY (microsoft-edge-dev-bin)
	AddPackage ttf-liberation                   # OPTIONAL DEPENDENCY (microsoft-edge-dev-bin)
	AddPackage xdg-utils                        # OPTIONAL DEPENDENCY (microsoft-edge-dev-bin)

	# Web browser: Firefox
	AddPackage firefox         # Standalone web browser from mozilla.org
	AddPackage hunspell-en_us  # OPTIONAL DEPENDENCY (firefox)
	AddPackage x11-ssh-askpass # OPTIONAL DEPENDENCY (code)
fi
