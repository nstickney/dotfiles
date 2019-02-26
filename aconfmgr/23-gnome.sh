if [ "$HOSTNAME" == 'elisha' ]; then
	AddPackage gnome-calculator # GNOME Scientific calculator
	AddPackage gnome-characters # A character map application
	AddPackage gnome-contacts # Contacts Manager for GNOME
	AddPackage gnome-desktop # Library with common API for various GNOME modules
	AddPackage gnome-dictionary # Look up words in dictionary sources
	AddPackage gnome-documents # A document manager application for GNOME
	AddPackage gnome-font-viewer # A font viewer utility for GNOME
	AddPackage gnome-keyring # Stores passwords and encryption keys
	AddPackage gnome-maps # A simple GNOME 3 maps application
	AddPackage gnome-music # Music player and management application
	AddPackage gnome-photos # Access, organize, and share your photos on GNOME
	AddPackage gnome-screenshot # Take pictures of your screen
	AddPackage gnome-search-tool # Utility to search for files
	AddPackage gnome-shell # The next generation GNOME Shell
	AddPackage gnome-shell-extensions # Extensions for GNOME shell, including classic mode
	AddPackage gnome-video-effects # Effects for Cheese, etc
	AddPackage gnome-user-docs # User documentation for GNOME
	AddPackage gnome-user-share # Easy to use user-level file sharing for GNOME
	AddPackage gnome-weather # Access current weather conditions and forecasts
	AddPackage grilo # Framework that provides access to various sources of multimedia content
	AddPackage grilo-plugins # Plugins for Grilo
	AddPackage libdmapsharing # A library that implements the DMAP family of protocols
	AddPackage mousetweaks # Mouse accessibility enhancements
	AddPackage mutter # A window manager for GNOME
	AddPackage mx # A widget toolkit using Clutter
	AddPackage tracker # Desktop-neutral user information store, search tool and indexer
fi

### GNOME-ish stuff used outside GNOME
AddPackage baobab # A graphical directory tree analyzer
AddPackage brasero # CD/DVD mastering tool
AddPackage eog # Eye of Gnome
AddPackage eog-plugins # Plugins for Eye of Gnome
AddPackage evince # Document viewer (PDF, Postscript, djvu, tiff, dvi, XPS, SyncTex support with gedit, comics books (cbr,cbz,cb7 and cbt))
AddPackage file-roller # Create and modify archives
AddPackage filemanager-actions # File-manager extension which offers user configurable context menu actions
AddPackage gdm # Display manager and login screen
AddPackage gnome-calculator # GNOME Scientific calculator
AddPackage gnome-control-center # GNOME's main interface to configure various aspects of the desktop
AddPackage gnome-disk-utility # Disk Management Utility for GNOME
AddPackage gnome-session # The GNOME Session Handler
AddPackage gnome-settings-daemon # The GNOME Settings daemon
AddPackage gnome-system-log # View your system logs
AddPackage gnome-system-monitor # View current processes and monitor system state
AddPackage gnome-tweaks # Graphical interface for advanced GNOME 3 settings (Tweak Tool)
AddPackage gparted # A Partition Magic clone, frontend to GNU Parted
AddPackage gucharmap # Gnome Unicode Charmap
AddPackage gvfs # Virtual filesystem implementation for GIO
AddPackage gvfs-afc # Virtual filesystem implementation for GIO (AFC backend; Apple mobile devices)
AddPackage gvfs-goa # Virtual filesystem implementation for GIO (Gnome Online Accounts backend; cloud storage)
AddPackage gvfs-google # Virtual filesystem implementation for GIO (Google Drive backend)
AddPackage gvfs-gphoto2 # Virtual filesystem implementation for GIO (gphoto2 backend; PTP camera, MTP media player)
AddPackage gvfs-mtp # Virtual filesystem implementation for GIO (MTP backend; Android, media player)
AddPackage gvfs-nfs # Virtual filesystem implementation for GIO (NFS backend)
AddPackage gvfs-smb # Virtual filesystem implementation for GIO (SMB/CIFS backend; Windows client)
AddPackage libgpod # A shared library to access the contents of an iPod
AddPackage libmtp # Library implementation of the Media Transfer Protocol
AddPackage lrzip # Multi-threaded compression with rzip/lzma, lzo, and zpaq
AddPackage nautilus # Default file manager for GNOME
AddPackage nautilus-image-converter # Nautilus extension to rotate/resize image files
AddPackage nautilus-sendto # Easily send files via mail
AddPackage nautilus-share # Nautilus extension to share folder using Samba
AddPackage p7zip # Command-line file archiver with high compression ratio
AddPackage rhythmbox # Music playback and management application
AddPackage seahorse # GNOME application for managing PGP keys.
AddPackage seahorse-nautilus # PGP encryption and signing for nautilus
AddPackage sushi # A quick previewer for Nautilus
AddPackage unace # An extraction tool for the proprietary ace archive format
AddPackage unrar # The RAR uncompression programs
AddPackage vinagre # A VNC Client for the GNOME desktop
AddPackage xdg-user-dirs-gtk # Creates user dirs and asks to relocalize them

AddPackage --foreign gnome-terminal-transparency # The GNOME Terminal Emulator, with background transparency
