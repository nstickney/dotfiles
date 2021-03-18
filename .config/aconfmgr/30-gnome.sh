if ! DetectVM; then              # No use for GNOME in a VM
	AddPackage gnome-control-center # GNOME's main interface to configure various aspects of the desktop
	AddPackage gnome-keyring        # Stores passwords and encryption keys
	AddPackage gnome-screenshot     # Take pictures of your screen
	AddPackage gnome-search-tool    # Utility to search for files
	AddPackage gnome-shell          # Next generation desktop shell
	AddPackage gnome-tweaks         # Graphical interface for advanced GNOME 3 settings (Tweak Tool)
	AddPackage xdg-user-dirs-gtk    # Creates user dirs and asks to relocalize them
	CreateLink /etc/systemd/system/display-manager.service /usr/lib/systemd/system/gdm.service
fi
